# Carbon Neutral Prediction Analysis
- By Corinna Keum, Anwita Molaka, and Joshua Mazher

## Section 1: Software and platform section
- Software used: Python (Google Colab)
- Platform used: Mac
- Packages used: pandas, os, numpy, matplotlib.pyplot, warnings, ARIMA, mean_squared_error

## Section 2: Map of Documentation

* DS4002 Project 2
 * DATA
   * Initial Data
     * GHG_totals.csv
   * Final Data
     * Afghanistan.csv
     * Albania.csv
     * Algeria.csv
     * ....
   * Final Data (2)
     * Jamaica.csv
     * Japan.csv
     * Jordan.csv
     * ....
   * Final Data (3)
     * United_Arab_Emirates.csv
     * United_Kingdom.csv
     * United_States.csv
     * ....
   * Data Appendix.pdf

 * OUTPUT
   * EDA Diagrams
     * Average Greenhouse Gas Emissions by Country.png
     * Greenhouse Gas Emission Trends by Top 5 Countries (Highest to Lowest Average Emissions).png
     * Greenhouse Gas Emissions Heatmap (Top 20 Countries).png
     * Top 20 Countries by Average Annual GHG Emissions.png
     * Total GHG Emissions Across All Countries.png
   * Presentation Diagrams
     * Top 10 Countries by GHG Emissions in 2022
     * Top 10 Countries by Projected GHG Emissions in 2050
     * Project Steps Outline Diagram

* SCRIPTS
  * Project 2 -- ARIMA
  * Project 2 -- Model Evaluation
  * Project 2 -- Data Cleaning
  * Project 2 -- Exploratory Data Analysis

## Section 3: Instructions for reproducing results
1. First, download the country CSV files in our Final Data folders (for example 'Zimbabwe.csv', 'Zambia.csv', 'Yemen.csv', etc.)

2. Next, run the 'Project 2 -- Exploratory Data Analysis'.ipynb file in our SCRIPTS folder. This will generate our EDA plots.
**** NOTE, you will need to import the country csv files for this ipynb file to work! 

3. Next, run the 'Project 2 -- Model Evaluation'.ipynb file in our SCRIPTS folder. This has the code for testing which model (ARIMA, ETS, Prophet, Polynomial Regression) works best. You will notice that ARIMA ends up having the lowest RMSE value, leading us to use ARIMA as our predictive model of choice.
**** NOTE, you will need to import the country csv files for this ipynb file to work!

4. Next, run the 'Project 2 -- ARIMA'.ipynb file in our SCRIPTS folder. This describes each country's predicted emissions for the target year 2050. For reference, our research question is: "Will a country's commitment to being carbon neutral by 2050 be reflected in the trends of their country's carbon emissions?" So any ARIMA results that depicts the Project 2050 Emissions being a value higher than zero is predicted by this model to not hold on to their commitment.
**** NOTE, you will need to import the country csv files for this ipynb file to work!

## References
[1] A. Hayes, “Autoregressive integrated moving average (ARIMA) prediction model,” Investopedia, https://www.investopedia.com/terms/a/autoregressive-integrated-moving-average-arima.asp (accessed Oct. 27, 2024). 

[2] “CO2 emissions of All World Countries,” EDGAR, https://edgar.jrc.ec.europa.eu/report_2022 (accessed Oct. 27, 2024).

[3] “The Complete Guide to Time Series models,” Built In, https://builtin.com/data-science/time-series-model (accessed Oct. 27, 2024).
