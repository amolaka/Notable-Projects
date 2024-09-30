# DS4002_Project1
## Section 1: Software and platform section
- Software used: R-Studio and Python (Google Colab)
- Platform used: Mac
- Add-on packages used: pandas, re, nltk, vaderSentiment, SentimentIntensity Analyzer, tidyverse, rvest, KMeans, matplotlib.pylot, seaborn, train_test_split, LogisticRegression, accuracy_score, kruskal

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
     * Presentation Diagrams
       * 3bodywordcloud1.png
       * falloutwordcloud1.pgn
       * moringshowcordcloud1.png
       * mrmrssmithwordcloud.png
       * overallcrownwordcloud.pgn
       * gildedagewordcloud1.png
       * crownwordcloud1.png
       * overall3bodywordcloud.png
       * overallfalloutwordcloud.png
       * overallgildedwordcloud.png
       * overallmorningwordcloud.png
       * overallmrmrssmithworldcloud.png
       * overallshogunwordcloud.png.
       * overallslowhorsewordcloud.png
     * Sentiment Analysis Diagrams
       * Shogun_Pie
       * 3bodypie.png
       * CrownPie.png
       * Falloutpie.png
       * Morningshowpie.png
       * Mrmrssmithpie.png
       * PostSentimentAnalysis2.png
       * Sentiment Analysis of Nominee Shows
       * SlowhorsePie.png
       * gildedagepie.png
       * shogunpie.png
 * SCRIPTS
   * Project 1 --Data Scraping
   * Project 1 -- Data_Cleaning_and_EDA.ipynb
   * Project 1 -- Predictive_Model_and_Statistical_Significance.ipynb
   * Project_1_Sentiment_Analysis.ipynb
 * LISENSE
 * README.md

## Section 3: Instructions for reproducing results

1. Find nominated series on review on Rotten Tomatoes and IMDb
2. Scrape text data from IMDB and Rotten Tomatoes for each nominateed series in R-Studio
3. Clean data in R-Studio and create a data frame with four columns: Content (reviews), Platform (whether it is Rotten Tomatoes/IMDb), Title of review (only for IMDb), Rating (-/10 only for IMDB)
4. Export the CSV created in R and upload them to Google Colab and import VADER sentiment analysis tool
5. Collect the positive, negative, neutral, and compound sentiment scores
6. Conduct hypothesis testing through generating the sentiment scores from VADER, clustering the scores (K-Means Clustering) for visualization, conducting a logistical regression to get predicted probabilities, compare compound score to prediction results, and finally perform a Kruskal-Wallis Test to see if there is any significant difference in compound scores among nominees.
