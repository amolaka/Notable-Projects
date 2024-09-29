# DS4002_Project1
## Section 1: Software and platform section
- Software used: R-Studio and Python (google collab)
- Platform used: Mac
- Add-on packages used: pandas, re, nltk, vaderSentiment, SentimentIntensity Analyzer, tidyverse, rvest

## Section 2: Map of Documentation

 * DS4002 Project 1
 * DATA
   * Initial Data
     * 3body_reviews.csv
     * fallout_reviews.csv
     * mr_mrs_smith_reviews.csv
     * shogun_reviews.csv
     * slow_horses_reviews.csv
     * the_crown_reviews.csv
     * the_gilded_reviews.csv
     * the_morning_show_reviews.csv
   * Final Data
     * 3body_reviews_combined.csv
     * fallout_reviews_combined.csv
     * mr_mrs_smith_reviews_combined.csv
     * shogun_reviews_combined.csv
     * slow_horses_reviews_combined.csv
     * the_crown_reviews_combined.csv
     * the_gilded_reviews_combined.csv
     * the_morning_show_reviews_combined.csv
   * OUTPUT
     * EDA Diagrams
       * Average Rating of Emmy-Nominated Shows for Outstanding Drama Series
       * OUTPUT/EDA Diagrams/Average Review Length for Emmy-Nominated Shows for Outstanding Drama Series
       * Number of Reviews for Emmy-Nominated Shows for Outstanding Drama Series
     * K-Means Clusters Diagrams
       * Compound vs Positive
       * Compound vs Negative
       * Compound vs Neutral
       * Negative vs Positive
     * Sentiment Analysis Diagrams
       * Shogun_Pie
       * 3Body_Pie
       * Fallout_Pie
       * Mr.Mrs_Pie
       * SlowHorse_Pie
       * Crown_Pie
       * Gilded_Pie
       * MorningShow_Pie
       * Sentiment Analysis of Nominee Shows
 * SCRIPTS
   * DSProject1.R
   * Project_1_Data_Cleaning_and_EDA.ipynb
   * Project_1_Predictive_Model_and_Statistical_Significance.ipynb
   * Project_1_Sentiment_Analysis.ipynb
 * LISENSE
 * README.md

## Section 3: Instructions for reproducing results

1. Find nominated series on review on Rotten Tomatoes and IMDb
2. Scrape text data from IMDB and Rotten Tomatoes for each nominateed series in R-Studio
3. Clean data on R-Studio and create a data frame with four columns: Content (reviews), Platform (wether it is Rotten Tomatoes/IMDb), Title of review (only for IMDb), Rating (-/10 only for IMDB)
4. Export the CSV created in R and upload them to Google Collab and import VADER sentiment analysis tool
5. collect the positive, negative, neutral, and compound sentiment scores
6. Conduct hypothesis testing through analysizing the sentiment scores from VADER, preforming t-test, get a p-value, and make a desision tree model
