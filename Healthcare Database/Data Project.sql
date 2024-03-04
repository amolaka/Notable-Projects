-- Create Database
CREATE DATABASE `Healthcare_Management`;
USE Healthcare_Management;

-- Admission data and hospital data already loaded in from Jupyter Notebooks

-- Modify Admissions table
-- Change any necessary data types, add keys
ALTER TABLE Admissions
CHANGE COLUMN case_id Case_ID INT,
CHANGE COLUMN Hospital_code Hospital_Code INT,
CHANGE COLUMN Hospital_type_code Hospital_Type_Code ENUM('a', 'b', 'c', 'd', 'e', 'f', 'g'),
MODIFY COLUMN City_Code_Hospital INT,
CHANGE COLUMN Hospital_region_code Hospital_Region_Code ENUM('X', 'Y', 'Z'),
CHANGE COLUMN `Available Extra Rooms in Hospital` Extra_Rooms INT,
MODIFY COLUMN Department VARCHAR(100),
MODIFY COLUMN Ward_Type ENUM('P', 'Q', 'R', 'S', 'T', 'U'),
MODIFY COLUMN Ward_Facility_Code ENUM('A', 'B', 'C', 'D', 'E', 'F'),
CHANGE COLUMN `Bed Grade` Bed_Grade VARCHAR(5),
CHANGE COLUMN patientid PatientID INT,
MODIFY COLUMN City_Code_Patient INT,
CHANGE COLUMN `Type of Admission` Admission_Type VARCHAR(50),
CHANGE COLUMN `Severity of Illness` Illness_Severity VARCHAR(50),
CHANGE COLUMN `Visitors with Patient` Patient_Visitors INT,
MODIFY COLUMN Age VARCHAR(100),
MODIFY COLUMN Admission_Deposit INT,
MODIFY COLUMN Stay VARCHAR(100),
ADD COLUMN Admission_Date DATE,
ADD PRIMARY KEY (Case_ID),
ADD KEY (Hospital_Code),
ADD KEY (City_Code_Hospital),
ADD KEY (PatientID),
ADD KEY (City_Code_Patient);

-- Populate Admission_Date column in Admissions Table
-- Use random dates from the past 10 years
UPDATE Admissions
SET Admission_Date = DATE_FORMAT(
    DATE_ADD('2013-09-25', INTERVAL FLOOR(RAND() * 3650) DAY),
    '%Y-%m-%d %H:%i:%s'
);

-- Change Hospital Code to match IDs in Hospitals Table
UPDATE Admissions
SET Hospital_Code = (SELECT Hospital_ID FROM Hospitals ORDER BY RAND() LIMIT 1);

-- Modify Hospitals table 
-- Update Data types that were not defined well in original dataset, add keys
ALTER TABLE Hospitals
CHANGE COLUMN hospital_id Hospital_ID INT,
CHANGE COLUMN hospital_org_id Hospital_Org_ID INT,
CHANGE COLUMN ein EIN INT,
CHANGE COLUMN name Name VARCHAR(150),
CHANGE COLUMN street_address Street_Address VARCHAR(150),
CHANGE COLUMN city City VARCHAR(100),
CHANGE COLUMN state State VARCHAR(5),
CHANGE COLUMN zip_code Zip_Code INT,
CHANGE COLUMN fips_state_and_county_code FIPS_Code INT,
CHANGE COLUMN hospital_bed_count Hospital_Bed_Count INT,
CHANGE COLUMN chrch_affl_f Church_Affiliation ENUM('N', 'Y'),
CHANGE COLUMN urban_location_f Urban_Location ENUM('N', 'Y'),
CHANGE COLUMN children_hospital_f Children_Hospital ENUM('N', 'Y'),
CHANGE COLUMN memb_counc_teach_hosps_f COTH_Member ENUM('N', 'Y'),
CHANGE COLUMN medicare_provider_number Medicare_Provider_Number INT,
CHANGE COLUMN county County VARCHAR(100),
CHANGE COLUMN hospital_bed_size Hospital_Bed_Size VARCHAR(100),
CHANGE COLUMN updated_dt Updated_Date TEXT,
DROP COLUMN name_cr,
ADD PRIMARY KEY (Hospital_ID),
ADD KEY (EIN),
ADD KEY (FIPS_Code),
ADD KEY (Medicare_Provider_Number);

-- Modify Date format
UPDATE Hospitals
SET Updated_Date = STR_TO_DATE(Updated_Date, '%M %d, %Y');

-- Create Patients table
CREATE TABLE Patients (
`Patient_Number` INT NOT NULL AUTO_INCREMENT,
`Patient_ID` INT NOT NULL,
`First_Name` VARCHAR(50),
`Last_Name` VARCHAR(50),
`DOB` DATE,
`Age` INT,
`Gender` VARCHAR(50),
`Email` VARCHAR(100),
`Phone_Number` VARCHAR(100),
`Street_Address` LONGTEXT,
`City` VARCHAR(50),
`State` VARCHAR(50),
`Insurance_Number` INT,
`PCP` VARCHAR(100),
PRIMARY KEY (`Patient_ID`),
KEY (`Patient_Number`),
KEY `First_Name` (`First_Name`),
KEY `Last_Name` (`Last_Name`),
KEY `Insurance_Number` (`Insurance_Number`)
);

-- Populate Patients Table
-- Patient IDs taken from Admissions table, DOBs and Ages chosen randomly 
-- Emails made randomly based on patient name from customers table in northwind database
-- State matches output from API in Hospitals table, cities were chosen randomly from Cities in the Hospitals table
-- Insurance number and PCP names were chosen randomly
INSERT INTO Patients (Patient_ID, DOB, Age, Gender, Email, Phone_Number, Insurance_Number, PCP)
VALUES
(8088, '1990-09-19', 33, 'Female', 'bedecs.anna@gmail.com', '685-770-8489', 011027, 'Amber Lowery'),
(63418, '1957-06-04', 66, 'Male', 'gs.antonio@yahoo.com', '359-653-8347', 774856, 'Lorenzo Ayala'),
(64869, '1962-10-03', 61, 'Male', 'thomas.axen3@gmail.com', '337-865-9450', 859383, 'Lorenzo Ayala'),
(88451, '1993-02-27', 30, 'Female', 'christinalee27@gmail.com', '263-451-2590', 983729, 'Amber Lowery'),
(31397, '1972-08-16', 51, 'Male', 'martin.od5@hotmail.com', '337-586-5653', 417598, 'Mitchell Sheppard'),
(109338, '1990-07-18', 33, 'Male', 'francisco10@yahoo.com', '883-417-2757',  013231, 'Cassandra Zamora'),
(28843, '1976-03-21', 47, 'Male', 'xie.my09@gmail.com', '437-684-8840', 173294, 'Cassandra Zamora'),
(84932, '1989-01-14', 34, 'Female', 'eanderson14@gmail.com', '421-475-0921', 675045, 'Amber Lowery'),
(74756, '2005-02-26', 18, 'Male', 'smortensen@yahoo.com', '283-722-3467', 845273, 'Mitchell Sheppard'),
(30632, '1982-06-16', 41, 'Male', 'rwacker@gmail.com', '918-724-5429', 168928, 'Cassandra Zamora'),
(44201, '1966-02-17', 57, 'Male', 'peter.k12@hotmail.com', '890-316-5575', 368787, 'Mitchell Sheppard'),
(107753, '1968-08-01', 55, 'Male', 'john.edwards02@yahoo.com', '485-411-7689', 689728, 'Amber Lowery'),
(130244, '1998-02-10', 25, 'Male', 'ludick.a@gmail.com', '439-975-4924', 567281, 'Charles Dixon'),
(115513, '1943-12-10', 79, 'Male', 'carlos.grilo05@gmail.com', '961-882-5734', 348792, 'Charles Dixon'),
(117626, '1995-05-24', 28, 'Female', 'hkupkova@gmail.com', '268-927-9295', 204051, 'Charles Dixon'),
(48585, '1961-01-31', 62, 'Male', 'daniel.goldschmidt@gmail.com', '320-751-5387', 382529, 'Mitchell Sheppard'),
(83512, '1940-04-10', 83, 'Male', 'jp.bagel22@hotmail.com', '459-711-8794', 799320, 'Amber Lowery'),
(82551, '1945-01-29', 78, 'Female', 'catherine.am@gmail.com', '601-482-1376', 657065, 'Charles Dixon'),
(6112, '2002-12-05', 20, 'Male', 'alex.egg@gmail.com', '834-474-1302', 227570, 'Lorenzo Ayala'),
(128803, '1980-01-30', 43, 'Male', 'george.li43@yahoo.com', '959-827-3514', 191310, 'Lorenzo Ayala'),
(33340, '1989-08-02', 34, 'Male', 'tham.bernard97@gmail.com', '313-770-0378', 186371, 'Mitchell Sheppard'),
(68311, '2002-07-08', 21, 'Female', 'lramos2002@gmail.com', '986-800-9493', 160789, 'Cassandra Zamora'),
(110115, '1945-01-30', 78, 'Male', 'entin.m@gmail.com', '717-534-7747', 863654, 'Lorenzo Ayala'),
(37254, '1970-12-03', 62, 'Male', 'jonas.h67@yahoo.com', '568-312-4206', 865325, 'Amber Lowery'),
(121941, '2003-07-13', 20, 'Male', 'rodmanjohn34@hotmail.com', '375-916-6365', 068734, 'Mitchell Sheppard'),
(87835, '2005-05-23', 18, 'Male', 'run.liu100@yahoo.com', '777-803-6392', 815908, 'Lorenzo Ayala'),
(21257, '1991-05-19', 32, 'Female', 'karen.toh@gmail.com', '440-954-9068', 939380, 'Cassandra Zamora'),
(27075, '1997-06-06', 26, 'Male', 'raghav.a45@gmail.com', '855-392-8543', 764511, 'Mitchell Sheppard'),
(73389, '1994-01-06', 29, 'Female', 'sj.lee88@gmail.com', '342-613-6623', 790600, 'Charles Dixon');

UPDATE Patients
JOIN northwind.customers AS c ON Patients.Patient_Number = c.id
SET Patients.First_Name = c.first_name, 
	Patients.Last_Name = c.last_name,
	Patients.Street_Address = c.address;

UPDATE Patients
SET City = (
    SELECT City
    FROM Hospitals
    ORDER BY RAND()
    LIMIT 1
);
UPDATE Patients
SET State = (
	SELECT State
    FROM Hospitals
    LIMIT 1
);

-- Create Date dimension table
CREATE TABLE Date_Dimension(
 date_key int NOT NULL,                                              
 full_date date NULL,
 date_name char(11) NOT NULL,
 date_name_us char(11) NOT NULL,
 date_name_eu char(11) NOT NULL,
 day_of_week tinyint NOT NULL,
 day_name_of_week char(10) NOT NULL,
 day_of_month tinyint NOT NULL,
 day_of_year smallint NOT NULL,
 weekday_weekend char(10) NOT NULL,
 week_of_year tinyint NOT NULL,
 month_name char(10) NOT NULL,
 month_of_year tinyint NOT NULL,
 is_last_day_of_month char(1) NOT NULL,
 calendar_quarter tinyint NOT NULL,
 calendar_year smallint NOT NULL,
 calendar_year_month char(10) NOT NULL,
 calendar_year_qtr char(10) NOT NULL,
 fiscal_month_of_year tinyint NOT NULL,
 fiscal_quarter tinyint NOT NULL,
 fiscal_year int NOT NULL,
 fiscal_year_month char(10) NOT NULL,
 fiscal_year_qtr char(10) NOT NULL,
  PRIMARY KEY (`date_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Here is the PopulateDateDimension Stored Procedure: 
delimiter //

DROP PROCEDURE IF EXISTS PopulateDateDimension//
CREATE PROCEDURE PopulateDateDimension(BeginDate DATETIME, EndDate DATETIME)
BEGIN

	# Holds a flag so we can determine if the date is the last day of month
	DECLARE LastDayOfMon CHAR(1);

	# Number of months to add to the date to get the current Fiscal date
	DECLARE FiscalYearMonthsOffset INT;

	# These two counters are used in our loop.
	DECLARE DateCounter DATETIME;    #Current date in loop
	DECLARE FiscalCounter DATETIME;  #Fiscal Year Date in loop

	# Set this to the number of months to add to the current date to get the beginning of the Fiscal year.
    # For example, if the Fiscal year begins July 1, put a 6 there.
	# Negative values are also allowed, thus if your 2010 Fiscal year begins in July of 2009, put a -6.
	SET FiscalYearMonthsOffset = 6;

	# Start the counter at the begin date
	SET DateCounter = BeginDate;

	WHILE DateCounter <= EndDate DO
		# Calculate the current Fiscal date as an offset of the current date in the loop
		SET FiscalCounter = DATE_ADD(DateCounter, INTERVAL FiscalYearMonthsOffset MONTH);

		# Set value for IsLastDayOfMonth
		IF MONTH(DateCounter) = MONTH(DATE_ADD(DateCounter, INTERVAL 1 DAY)) THEN
			SET LastDayOfMon = 'N';
		ELSE
			SET LastDayOfMon = 'Y';
		END IF;

		# add a record into the date dimension table for this date
		INSERT INTO Date_Dimension
			(date_key
			, full_date
			, date_name
			, date_name_us
			, date_name_eu
			, day_of_week
			, day_name_of_week
			, day_of_month
			, day_of_year
			, weekday_weekend
			, week_of_year
			, month_name
			, month_of_year
			, is_last_day_of_month
			, calendar_quarter
			, calendar_year
			, calendar_year_month
			, calendar_year_qtr
			, fiscal_month_of_year
			, fiscal_quarter
			, fiscal_year
			, fiscal_year_month
			, fiscal_year_qtr)
		VALUES  (
			( YEAR(DateCounter) * 10000 ) + ( MONTH(DateCounter) * 100 ) + DAY(DateCounter)  #DateKey
			, DateCounter #FullDate
			, CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'/', DATE_FORMAT(DateCounter,'%m'),'/', DATE_FORMAT(DateCounter,'%d')) #DateName
			, CONCAT(DATE_FORMAT(DateCounter,'%m'),'/', DATE_FORMAT(DateCounter,'%d'),'/', CAST(YEAR(DateCounter) AS CHAR(4)))#DateNameUS
			, CONCAT(DATE_FORMAT(DateCounter,'%d'),'/', DATE_FORMAT(DateCounter,'%m'),'/', CAST(YEAR(DateCounter) AS CHAR(4)))#DateNameEU
			, DAYOFWEEK(DateCounter) #DayOfWeek
			, DAYNAME(DateCounter) #DayNameOfWeek
			, DAYOFMONTH(DateCounter) #DayOfMonth
			, DAYOFYEAR(DateCounter) #DayOfYear
			, CASE DAYNAME(DateCounter)
				WHEN 'Saturday' THEN 'Weekend'
				WHEN 'Sunday' THEN 'Weekend'
				ELSE 'Weekday'
			END #WeekdayWeekend
			, WEEKOFYEAR(DateCounter) #WeekOfYear
			, MONTHNAME(DateCounter) #MonthName
			, MONTH(DateCounter) #MonthOfYear
			, LastDayOfMon #IsLastDayOfMonth
			, QUARTER(DateCounter) #CalendarQuarter
			, YEAR(DateCounter) #CalendarYear
			, CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'-',DATE_FORMAT(DateCounter,'%m')) #CalendarYearMonth
			, CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'Q',QUARTER(DateCounter)) #CalendarYearQtr
			, MONTH(FiscalCounter) #[FiscalMonthOfYear]
			, QUARTER(FiscalCounter) #[FiscalQuarter]
			, YEAR(FiscalCounter) #[FiscalYear]
			, CONCAT(CAST(YEAR(FiscalCounter) AS CHAR(4)),'-',DATE_FORMAT(FiscalCounter,'%m')) #[FiscalYearMonth]
			, CONCAT(CAST(YEAR(FiscalCounter) AS CHAR(4)),'Q',QUARTER(FiscalCounter)) #[FiscalYearQtr]
		);
		# Increment the date counter for next pass thru the loop
		SET DateCounter = DATE_ADD(DateCounter, INTERVAL 1 DAY);
	END WHILE;
END//

CALL PopulateDateDimension('2013/09/25', '2023/09/25');


-- Create Fact table to model a billing process
CREATE TABLE Fact_Billing (
Billing_ID INT NOT NULL AUTO_INCREMENT,
Patient_ID INT NOT NULL,
Case_ID INT NOT NULL,
Hospital_ID INT NOT NULL, 
Date_ID INT NOT NULL,
Billing_Date DATE NOT NULL,
Cost DECIMAL(10, 2) NOT NULL,
Payment_Status VARCHAR(10) NOT NULL,
Notes TEXT,
PRIMARY KEY (Billing_ID),
FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
FOREIGN KEY (Case_ID) REFERENCES Admissions(Case_ID),
FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(Hospital_ID),
FOREIGN KEY (Date_ID) REFERENCES Date_Dimension(date_key)
);

-- Populate Fact table
INSERT INTO Fact_Billing
(
    Patient_ID,
    Case_ID,
    Hospital_ID,
    Date_ID,
    Billing_Date,
    Cost,
    Payment_Status
)
SELECT
	Patients.Patient_ID,
    Admissions.Case_ID,
    Hospitals.Hospital_ID,
    Date_Dimension.date_key,
    Admissions.Admission_Date AS Billing_Date,
	GREATEST(ROUND(RAND() * 10000, 2), 2118) AS Cost,
    CASE WHEN RAND() < 0.5 THEN 'Paid' ELSE 'Unpaid' END AS Payment_Status
FROM
	Patients
    JOIN Admissions ON Patients.Patient_ID = Admissions.PatientID
    JOIN Hospitals ON Admissions.Hospital_Code = Hospitals.Hospital_ID
    JOIN Date_Dimension ON Admissions.Admission_Date = Date_Dimension.full_date;

-- SQL Query to Demonstrate Functionality
-- Select each patient and show what hospitals they were admitted into, how many times, and the total cost for treatments at that hospital
SELECT
    Patients.Patient_ID,
    Patients.First_Name,
    Patients.Last_Name,
    Hospitals.Name AS Hospital_Name,
    COUNT(Admissions.Case_ID) AS Num_Admissions,
    SUM(Fact_Billing.Cost) AS Total_Cost
FROM
    Patients
JOIN Admissions ON Patients.Patient_ID = Admissions.PatientID
JOIN Hospitals ON Admissions.Hospital_code = Hospitals.Hospital_ID
JOIN Fact_Billing ON Admissions.Case_ID = Fact_Billing.Case_ID
GROUP BY
    Patients.Patient_ID, Patients.First_Name, Hospitals.Name;
