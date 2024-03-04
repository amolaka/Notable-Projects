import discord
import time
import os
import json
from discord.ext import commands
import pandas as pd

import openai
from dotenv import load_dotenv

try:
    with open('chatbot.json') as f:
        info = json.load(f)
except FileNotFoundError:
    print("Error: 'chatbot.json' file not found.")
except json.JSONDecodeError:
    print("Error: unable to parse 'env_info.json'. Make sure this is a valid JSON file.")
try:
    openai.api_key = info['API_KEY']
    TOKEN = info['TOKEN']
except KeyError as e:
    print(f"Error: Missing {e}")

# Initialize variables for chat history
explicit_input = ""
chatgpt_output = 'Chat log: \n'
cwd = os.getcwd()
i = 1

# Find an available chat history file
while os.path.exists(os.path.join(cwd, f'chat_history{i}.txt')):
    i += 1

history_file = os.path.join(cwd, f'chat_history{i}.txt')

# Create a new chat history file
with open(history_file, 'w') as f:
    f.write('\n')

# Initialize chat history
chat_history = ''

# OPEN AI CODE

name = 'Harry Potter'

# Define the role of the bot
role = 'customer service'

# Import csv file
with open ('Potions.csv', 'r') as potions_file:
    potions_file_contents = potions_file.read()
    
# Define the impersonated role with instructions
impersonated_role = f"""
    From the start to end of every conversation, you are going to act as {name}. Your role is {role}. You will pretend you are at Hogwarts.
    You are a true impersonation of {name} and you reply to all requests with a British accent. Do
    not start every line with "As Harry Potter," use the pronoun "I" instead. You will speak like a wizard in England.
    You will be informed by the CSV data here: {potions_file_contents}.
      
"""
# Function to complete chat input using OpenAI's GPT-3.5 Turbo
def chatcompletion(user_input, impersonated_role, explicit_input, chat_history):
    output = openai.ChatCompletion.create(
        model="gpt-4",
        temperature=1,
        presence_penalty=0,
        frequency_penalty=0,
        max_tokens=4000,
        messages=[
            {"role": "system", "content": f"{impersonated_role}. Conversation history: {chat_history}"},
            {"role": "user", "content": f"{user_input}. {explicit_input}"},
        ]
    )

    for item in output['choices']:
        chatgpt_output = item['message']['content']

    return chatgpt_output

# Function to handle user chat input
def chat(user_input):
    global chat_history, name, chatgpt_output
    current_day = time.strftime("%d/%m", time.localtime())
    current_time = time.strftime("%H:%M:%S", time.localtime())
    chat_history += f'\nUser: {user_input}\n'
    chatgpt_raw_output = chatcompletion(user_input, impersonated_role, explicit_input, chat_history).replace(f'{name}:', '')
    chatgpt_output = f'{name}: {chatgpt_raw_output}'
    chat_history += chatgpt_output + '\n'
    with open(history_file, 'a') as f:
        f.write('\n'+ current_day+ ' '+ current_time+ ' User: ' +user_input +' \n' + current_day+ ' ' + current_time+  ' ' +  chatgpt_output + '\n')
        f.close()
    return chatgpt_raw_output



# DISCORD CODE

intents = discord.Intents().all()
client = commands.Bot(command_prefix="!", intents=intents)


@client.event
async def on_ready():
    print("Bot is ready")

# Greeting function
@client.command()
async def hi(ctx):
    await ctx.send("Hello, welcome to Hogwarts!")
# Help function
@client.command()
async def harry_help(ctx):
    await ctx.send("I am Harry Potter and am here to assist you today with any questions you might have. Ask me anything you'd like, and I'll do my best to answer. If you want to hear about a random spell, type !spell. If you'd like to know a fun fact about a random potion, type !potion. If you want a special greeting, type !friend.")
# Spell function
@client.command(brief = 'Random spell', description = 'Return random magic spell')
async def spell(ctx):
    response_spell = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are Harry Potter, as a customer service representative."},
            {"role": "user", "content": "Generate the name and effect of a random, unique spell from Harry Potter."},
        ],
        temperature=1,
        max_tokens=200
    )
    generated_spell_text = response_spell['choices'][0]['message']['content'].strip()
    await ctx.send(f"🪄... {generated_spell_text}")
# Friend function        
@client.command(brief='Return random greeting', description='Return greeting from random character in Harry Potter')
async def friend(ctx):
    response_character = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[{"role": "system", "content": "You are Harry Potter, as a customer service representative."},
                  {"role": "user", "content": "Generate a random character from Harry Potter."}]
    )
    generated_character = response_character['choices'][0]['message']['content'].strip()

    response_greeting = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are Harry Potter, as a customer service representative."},
            {"role": "user", "content": f"Generate a random greeting from {generated_character}."}
        ]
    )
    generated_greeting = response_greeting['choices'][0]['message']['content'].strip()
    await ctx.send(f"{generated_character} says: {generated_greeting}")
# Potion function
potions_df = pd.read_csv('Potions.csv', delimiter = ';')
@client.command(brief = 'Random potion', description = 'Return a random potion and what it does')
async def potion(ctx):
    selected_potion = potions_df.sample(1).iloc[0]
    potion_name = selected_potion['Name']
    potion_effect = selected_potion['Effect']
    print(f"Selected Potion: {potion_name}, Effect: {potion_effect}")
    await ctx.send(f"...🧪...Have you heard about {potion_name}? This is what it does: {potion_effect}.")


responses = 0
list_user = []

# Return response
@client.event
async def on_message(message):
    print(message.content)
    if message.author == client.user:
        return    
    #print(message.author)
    #print(client.user)
    #print(message.content)
    await client.process_commands(message)
    if message.content.startswith('!'):
        return
    answer = chat(message.content)
    print("Harry Potter says: " + answer)
    #answer = "Harry Potter Says:" + answer
    await message.channel.send(answer)

# Turn off bot
@client.command()
@commands.is_owner()
async def shutdown(context):
    await context.send("Goodbye, until next time!")
    exit()

client.run(TOKEN)
