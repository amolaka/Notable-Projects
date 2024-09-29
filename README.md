# DS4002_Project1
## Section 1: Software and platform section
- Software used: R-Studio and Python (google collab)
- Platform used: Mac
- Add-on packages used: pandas, re, nltk, vaderSentiment, SentimentIntensity Analyzer, tidyverse, rvest

## Section 2: Map of Documentation

DS4002_Project1
- DATA 
  Initial Data
  Final Data
- OUTPUT
  EDA diagrams
  K-Means Clusters Diagrams
  Sentiment Analysis Diagrams
- SCRIPTS

## Section 3: Instructions for reproducing results

1. Find nominated series on review on Rotten Tomatoes and IMDb
2. Scrape text data from IMDB and Rotten Tomatoes for each nominateed series in R-Studio
3. Clean data on R-Studio and create a data frame with four columns: Content (reviews), Platform (wether it is Rotten Tomatoes/IMDb), Title of review (only for IMDb), Rating (-/10 only for IMDB)
4. Export the CSV created in R and upload them to Google Collab and import VADER sentiment analysis tool
5. collect the positive, negative, neutral, and compound sentiment scores
6. Conduct hypothesis testing through analysizing the sentiment scores from VADER, preforming t-test, get a p-value, and make a desision tree model
