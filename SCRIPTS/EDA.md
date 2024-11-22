```python
%cd /sfs/weka/scratch/axu5pa/DS_4002_Project_3
```


```python
pip install openpyxl
```


```python
import pandas as pd
import openpyxl

# Load the Excel file into a DataFrame
df = pd.read_excel('/sfs/weka/scratch/axu5pa/DS_4002_Project_3/PH2Dataset/PH2_dataset.xlsx', skiprows=12)  # Adjust 'skiprows' based on where your actual data starts

# Display the first few rows to verify
print(df.head())
```


```python
from IPython.display import display

# Use display instead of print for a cleaner output in Jupyter Notebook
display(df)
```


```python
pip install pillow
```


```python
import os
import pandas as pd
from PIL import Image

# Load your dataframe (assuming it's already loaded, or you can load it from a CSV)
# df = pd.read_csv('your_dataframe.csv')  # Load your dataframe if needed

# Define the directory where your .bmp images are stored
image_dir = '/sfs/weka/scratch/axu5pa/DS_4002_Project_3/PH2Dataset/Images'

# List all .bmp files in the directory
image_files = [f for f in os.listdir(image_dir) if f.endswith('.bmp')]

# Create a dictionary to map image names (without .bmp) to file paths
image_dict = {os.path.splitext(f)[0]: os.path.join(image_dir, f) for f in image_files}

# Add a new column to the dataframe for image paths
df['Image Path'] = df['Image Name'].map(image_dict)

# Define a function to classify based on the 'X' values in the relevant columns
def classify_lesion(row):
    if row['Common Nevus'] == 'X':
        return 'Benign'
    elif row['Atypical Nevus'] == 'X':
        return 'Benign*'
    elif row['Melanoma'] == 'X':
        return 'Malignant'
    else:
        return 'Unknown'  # If none of the columns have an 'X'

# Apply the function to each row in the dataframe to create a new 'Class' column
df['Class'] = df.apply(classify_lesion, axis=1)

# Check if there are any unknown classifications
unknown_classifications = df[df['Class'] == 'Unknown']
if not unknown_classifications.empty:
    print("Some images were not classified correctly:")
    print(unknown_classifications)
else:
    print("All images classified successfully.")

# Drop the 'Lesion Type' column if it exists
if 'Lesion Type' in df.columns:
    df = df.drop(columns=['Lesion Type'])

# Check if there are any missing matches
missing_images = df[df['Image Path'].isnull()]

if not missing_images.empty:
    print("Some images were not found:")
    print(missing_images)
else:
    print("All images matched successfully.")

# Example: Open and display an image from the dataframe using PIL
for index, row in df.iterrows():
    img_path = row['Image Path']
    if img_path:  # Ensure there's a valid path
        img = Image.open(img_path)
        display(img)  # Display image in Jupyter Notebook (optional)
```


```python
from IPython.display import display

# Use display instead of print for a cleaner output in Jupyter Notebook
display(df)
```


```python
import pandas as pd

# Assuming df already has columns 'Common Nevus', 'Atypical Nevus', and 'Melanoma'

# Define a function to classify based on the 'X' values in the relevant columns
def classify_lesion(row):
    if row['Common Nevus'] == 'X':
        return 'Benign'
    elif row['Atypical Nevus'] == 'X':
        return 'Benign*'
    elif row['Melanoma'] == 'X':
        return 'Malignant'
    else:
        return 'Unknown'  # If none of the columns have an 'X'

# Apply the function to each row in the dataframe to create a new 'Class' column
df['Class'] = df.apply(classify_lesion, axis=1)

# Check if there are any unknown classifications
unknown_classifications = df[df['Class'] == 'Unknown']
if not unknown_classifications.empty:
    print("Some images were not classified correctly:")
    print(unknown_classifications)
else:
    print("All images classified successfully.")

# Drop the 'Lesion Type' column if it exists
if 'Lesion Type' in df.columns:
    df = df.drop(columns=['Lesion Type'])

# Display the first few rows of the dataframe to verify
from IPython.display import display

# Use display instead of print for a cleaner output in Jupyter Notebook
display(df)
```


```python
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from PIL import Image, ImageStat
import numpy as np
import cv2

# Assuming df is already loaded with the 'Image Path' and 'Class' columns

# For reference:
benign_classes = ['Common Nevus']
benign_star_classes = ['Atypical Nevus']
malignant_classes = ['Melanoma']
```


```python
# Question 1: Are the classes balanced, or is there class imbalance?
# --------------------------------------------------------------
import matplotlib.pyplot as plt
import seaborn as sns

# Plot the distribution of classes ('Benign', 'Benign*', 'Malignant')
plt.figure(figsize=(8, 6))
sns.countplot(data=df, x='Class', palette='Set2')

# Set plot title and labels
plt.title('Distribution of Benign, Benign*, and Malignant Lesions')
plt.xlabel('Class')
plt.ylabel('Count')

# Show the plot
plt.show()

# Print class distribution for severity check (percentage)
class_distribution = df['Class'].value_counts(normalize=True) * 100
print("Class Distribution (%):\n", class_distribution)
```


```python
# Question 2: Are the images consistent in resolution? Do they have similar aspect ratios?
# --------------------------------------------------------------
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from PIL import Image

# Function to get image dimensions and aspect ratio
def get_image_dimensions(image_path):
    # Check if the image path is valid and not NaN
    if isinstance(image_path, str) and os.path.exists(image_path):
        with Image.open(image_path) as img:
            width, height = img.size
            aspect_ratio = width / height
            return width, height, aspect_ratio
    else:
        return None, None, None  # Return None for invalid paths

# Apply function to each row in dataframe and store results in new columns
df[['Width', 'Height', 'Aspect Ratio']] = df['Image Path'].apply(lambda x: pd.Series(get_image_dimensions(x)))

# Drop rows where dimensions couldn't be calculated (i.e., where Width is None)
df_cleaned = df.dropna(subset=['Width'])

# Plot histograms of image widths, heights, and aspect ratios
fig, axes = plt.subplots(1, 3, figsize=(18, 6))

sns.histplot(df_cleaned['Width'], bins=20, ax=axes[0], color='skyblue')
axes[0].set_title('Image Width Distribution')

sns.histplot(df_cleaned['Height'], bins=20, ax=axes[1], color='lightgreen')
axes[1].set_title('Image Height Distribution')

sns.histplot(df_cleaned['Aspect Ratio'], bins=20, ax=axes[2], color='salmon')
axes[2].set_title('Image Aspect Ratio Distribution')

plt.tight_layout()
plt.show()
```


```python
# Calculate the average (mean) of 'Width', 'Height', and 'Aspect Ratio'
average_width = df_cleaned['Width'].mean()
average_height = df_cleaned['Height'].mean()
average_aspect_ratio = df_cleaned['Aspect Ratio'].mean()

# Print the results
print(f"Average Width: {average_width:.2f} pixels")
print(f"Average Height: {average_height:.2f} pixels")
print(f"Average Aspect Ratio: {average_aspect_ratio:.2f}")
```


```python
# Question 3: Is there a difference in color distribution across classes?
# --------------------------------------------------------------
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Convert 'X' values in color columns to binary (1 for 'X', 0 for NaN)
color_columns = ['White', 'Red', 'Light-Brown', 'Dark-Brown', 'Blue-Gray', 'Black']
df[color_columns] = df[color_columns].applymap(lambda x: 1 if x == 'X' else 0)

# Melt the dataframe to long format for easier plotting
df_melted = df.melt(id_vars='Class', value_vars=color_columns, var_name='Color', value_name='Presence')

# Plot the distribution of colors by class
plt.figure(figsize=(10, 6))
sns.barplot(data=df_melted, x='Color', y='Presence', hue='Class', ci=None, palette='Set2')

# Set plot title and labels
plt.title('Color Distribution Across Lesion Classes')
plt.xlabel('Color')
plt.ylabel('Average Presence (1 = Present, 0 = Absent)')

# Show the plot
plt.tight_layout()
plt.show()
```


```python
# Question 4: Do images differ significantly in brightness or contrast?
# --------------------------------------------------------------
import pandas as pd
from PIL import Image, ImageStat
import matplotlib.pyplot as plt
import seaborn as sns

# Function to calculate brightness and contrast of an image
def get_brightness_contrast(image_path):
    # Check if the image path is valid and not NaN
    if isinstance(image_path, str) and os.path.exists(image_path):
        img = Image.open(image_path).convert('L')  # Convert to grayscale for brightness/contrast calculation
        stat = ImageStat.Stat(img)

        # Brightness: Mean pixel value in grayscale image
        brightness = stat.mean[0]

        # Contrast: Standard deviation of pixel values (higher std -> higher contrast)
        contrast = stat.stddev[0]

        return brightness, contrast
    else:
        return None, None  # Return None for invalid paths

# Apply function to each row in dataframe and store results in new columns
df[['Brightness', 'Contrast']] = df['Image Path'].apply(lambda x: pd.Series(get_brightness_contrast(x)))

# Drop rows where brightness or contrast couldn't be calculated (i.e., where Brightness is None)
df_cleaned = df.dropna(subset=['Brightness'])

# Plot histograms of brightness and contrast values across images
fig, axes = plt.subplots(1, 2, figsize=(12, 6))

sns.histplot(df_cleaned['Brightness'], bins=20, ax=axes[0], color='orange')
axes[0].set_title('Brightness Distribution')

sns.histplot(df_cleaned['Contrast'], bins=20, ax=axes[1], color='purple')
axes[1].set_title('Contrast Distribution')

plt.tight_layout()
plt.show()
```


```python
print(df.columns)
```
