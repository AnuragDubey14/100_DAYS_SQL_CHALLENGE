-- -------------------- Day 6 of 100 days SQL Challenge ------------

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE DAY6;

-- -------------SELECT DATABASE DAY5 TO USE FURTHER
USE DAY6;

-- ---------I HAVE A SLEEP EFFICIENCY DATASET THAT I HAVE DOWNLOADED FROM KAGGLE 
-- ---------AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

-- ---------LETS SEE SAMPLE DATA 
SELECT * FROM SLEEP_EFFICIENCY;

-- --------------- COUNT NUMBER OF ROWS IN THE TABLE
SELECT COUNT(*) AS `NUMBER OF ROWS` FROM SLEEP_EFFICIENCY;

/*Problem 1:
The question is:
Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5. */

-- Solution -
SELECT ROUND(AVG(`Sleep duration`),2) AS `Average sleep duration of top 15 male`
FROM SLEEP_EFFICIENCY
WHERE Gender='male' AND `Sleep duration`>=7.5 
ORDER BY `Sleep duration` DESC
LIMIT 15;

/*Problem 2: 
The question is: 
Show avg deep sleep time for both gender. Round result at 2 decimal places.
Note: sleep time and deep sleep percentage will give you, deep sleep time. */

SELECT 
Gender, 
ROUND(AVG((`Sleep duration` * `Deep sleep percentage`)/100), 2) AS `Average deep sleep time`
FROM Sleep_efficiency
GROUP BY gender;

/*Problem 3:
The question is:
Find out the lowest 10th to 30th light sleep percentage records
where deep sleep percentage values are between 25 to 45.
 Display age, light sleep percentage and deep sleep percentage columns only.*/
 
 SELECT age,`Light sleep percentage`,`Deep sleep percentage`
 FROM SLEEP_EFFICIENCY
 WHERE `Deep sleep percentage` BETWEEN 25 AND 45
 ORDER BY `Light sleep percentage` ASC 
 LIMIT 20 OFFSET 9;
 
 /*Problem 4:
 The question is:
 Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
Note: the differences in deep sleep time for smoking and non smoking status*/

SELECT `Exercise frequency`,`Smoking status`,
ROUND(AVG(CASE WHEN `Smoking status` = 'Yes' THEN `Sleep duration` * `Deep sleep percentage` / 100 END),2) as `Average Deep Sleep Time Smoking`,
ROUND(AVG(CASE WHEN `Smoking status` = 'No' THEN `Sleep duration` * `Deep sleep percentage` / 100 END),2) as `Average Deep Sleep Time Non Smoking`,
ROUND(AVG(`Sleep duration` * `Light sleep percentage` / 100),2) as `Average Light Sleep Time`,
ROUND(AVG(`Sleep duration` * `REM sleep percentage` / 100),2) as `Average REM Sleep Time`
FROM SLEEP_EFFICIENCY
GROUP BY `Exercise frequency`, `Smoking status`;
 
 
/*Problem 5:
 The question is:
 Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people
 who do exercise atleast 3 days a week. Show result in descending order awekenings*/
 
 SELECT ROUND(AVG(`Caffeine consumption`),2) AS `Average Caffeine Consumption`,
ROUND(AVG(`Sleep duration` * `Deep sleep percentage` / 100),2) AS `Average deep sleep time`,
ROUND(AVG(`Alcohol consumption`),2) as `Average Alcohol Consumption`,
`Awakenings`
FROM Sleep_efficiency WHERE `Exercise frequency`>=3
GROUP BY `Awakenings`
ORDER BY `Awakenings` DESC;
 
   