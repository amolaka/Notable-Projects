# Dermatological Image Classification Analysis
- By Anwita Molaka, Corinna Keum, and Joshua Mazher
- Our goal is to develop a model that analyzes various dermatological lesions to predict if a lesion is benign or malignant

## Section 1: Software and platform section
- Software used: Python (Jupyter Notebook)
- Platform used: Mac
- Packages used: pandas, os, numpy, matplotlib.pyplot, seaborn, PIL, tensorflow, sklearn, openpyxl, IPython.display, cv2, re

## Section 2: Map of Documentation

* DS4002 Project 3
 * DATA
   * Pre-Processed Data
     * normalized_merged_images (3).zip
   * Data Appendix -- Project 3.pdf
   * PH2 Dataset Images -- Raw 

 * OUTPUT
   * EDA Diagrams
     * brightness and contrast distribution.png
     * color distribution across lesion classes.png
     * distributionoflesions.png
     * image height distribution.png
   * Presentation Diagrams
     * model accuracy and loss.png
     * confusion matrix.png

* SCRIPTS
  * CNN -- Trial_1.ipynb
  * CNN--Trial2(1).ipynb
  * EDA (1).ipynb
  * Image Preprocessing.ipynb
  * Preprocessingdata.ipynb

## Section 3: Instructions for reproducing results
1. For reproducing the results of the project, first download the data in the data folder called PH2Dataset.rar. You will then need to run it through our script called EDA (1).ipynb. This script will open the .rar file, in order to analyize the images. This will allow you to conduct the EDA and better understand the data. 

2. Next you will need to process the data. For this step, put the opened PH2Dataset through the Image Preprocessing.ipynb, this step will produce the final dataset that we will be using, you can find the final data set in the data folder called: normalized_merged_images (3).zip. 

3. Next we will be using the CNN model to conduct the classification step in our project. You will need to use script called CNN -- Trial_1.ipynb and CNN--Trial2(1).ipynb and run the code accordingly. This will produce the results of the classification and analyze the accuracy.  


## References
[1] “Climate change and skin cancer: Urgent Call for Action,” The Lancet, https://www.thelancet.com/journals/lanonc/article/PIIS1470-2045(23)00348-0/fulltext (accessed Nov. 6, 2024). 

[2] Z. Li et al., “Artificial Intelligence in dermatology image analysis: Current developments and future trends,” Journal of clinical medicine, https://pmc.ncbi.nlm.nih.gov/articles/PMC9693628/ (accessed Nov. 6, 2024). 

