-- -------------------- Day 5 of 100 days SQL Challenge ------------

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE DAY5;

-- -------------SELECT DATABASE DAY5 TO USE FURTHER
USE DAY5;

-- ---------I HAVE A INSURANCE DATASET THAT I HAVE DOWNLOADED FROM KAGGLE 
-- ---------AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

-- ---------LETS SEE SAMPLE DATA 
SELECT * FROM INSURANCE_DATA;

-- --------------- COUNT NUMBER OF ROWS IN THE DATABASE
SELECT COUNT(*) AS `NUMBER OF ROWS` FROM INSURANCE_DATA;

-- --------- SHOW  RECORDS OF MALE PATIENT FROM  SOUTHWEST REGION.
SELECT * FROM INSURANCE_DATA WHERE gender = 'male' AND region ='southwest';

-- --------- Show all records having bmi in range 30 to 45 both inclusive.
select * from insurance_data where bmi between 30 and 45;

-- Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
select min(bloodpressure) as MinBP, max(bloodpressure) as MaxBP from insurance_data;

-- ------ Find no of unique patients who are not from southwest region.
select count(distinct(PatientID)) as `number of unique patients` from insurance_data where region !='southwest';

-- ---------- Total claim amount from male smoker 
select round(sum(claim),2) as `Total claimed amount by smoker` from insurance_Data where smoker='yes';

-- -------- Select all records of south region.
select * from insurance_data where region like 'south%';

-- ------- No of patient having normal blood pressure. Normal range[90-120]
select count(*) as `Number of people with normal blood pressure` from insurance_data where bloodpressure between 90 and 120;

-- ------What is the average claim amount for non-smoking female patients who are diabetic?
select round(avg(claim),2) as `average claim amount for non-smoking female patient`
 from insurance_data where gender='female' and diabetic='yes';
 
 -- ----- Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
 set sql_safe_updates=0;
 update  insurance_data set claim=5000 where PatientID = 1234;
 
 
-- ------ Write a SQL query to delete all records for patients who are smokers and have no children.
select * from insurance_data;
delete from insurance_data where smoker='yes' and children=0;