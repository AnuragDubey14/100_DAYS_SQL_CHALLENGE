-- -------------------- Day 9 of 100 days SQL Challenge ------------

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE day9;

-- -------------SELECT DATABASE DAY5 TO USE FURTHER
USE day9;

-- ---I HAVE A DATASET THAT I HAVE DOWNLOADED FROM KAGGLE
-- ---AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

/* DATA DICTIONARY 

Year The Digest year this information comes from

State The U.S. State

Type Type of University, Private or Public and in-state or out-of-state. Private colleges charge the same for in/out of state

Length Whether the college mainly offers 2-year (Associates) or 4-year (Bachelors) programs

Expense The Expense being described, tuition/fees or on-campus living expenses

Value The average cost for this particular expense, in USD ($)
*/

-- ---------LETS SEE SAMPLE DATA 
SELECT * FROM US_DATA;

/* PROBLEM 1:
The question is:
Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 
and type is 'Public In-State'. Also the number of occurance should be between 6 to 10.
 Display the average value upto 2 decimal places, state names and the occurance of the states.
 */
 
 SELECT `State`, COUNT(*) AS `Number of Occurrences`, ROUND(AVG(`Value`),2) AS `Average Value`
 FROM US_DATA
 WHERE `Year` IN (2013,2017,2021) AND `Type` = 'Public In-State'
 GROUP BY State 
 HAVING  `Number of Occurrences` BETWEEN 6 AND 10
 ORDER BY `Average Value` DESC;
 
 /*PROBLEM 2:
 The question is:
 Best state in terms of low education cost (Tution Fees) in 'Public' type university.
 */
 
 SELECT State, AVG(`Value`) AS `Average Cost` FROM US_DATA
 WHERE `Expense` = 'Fees/Tuition' AND `Type` = 'Public In-State'
 GROUP BY State
 ORDER BY `Average Cost` ASC LIMIT 1;
 
 /*PROBLEM 3:
 The question is:
 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
 */
 
 SELECT State, AVG(`Value`) AS `Average Cost` FROM US_DATA
 WHERE `Year`=2021 AND `Type` = 'Private'
 GROUP BY State 
 ORDER BY `Average Cost` DESC LIMIT 1,1;
 
 /* PROBLEM 4- 
 The question is:
 Calculate the average cost of living (room and board) as a percentage of the total expenses for each state for private university
 */
 
 SELECT 
    State, 
    AVG(Value) AS Avg_Cost_of_Living, 
    AVG(Value) / (SELECT AVG(Value) FROM US_DATA WHERE Type = 'Private' AND Expense IN ('Fees/Tuition', 'Room/Board')) * 100 AS Percentage_of_Total_Expenses
FROM US_DATA
WHERE Type = 'Private' AND Expense = 'Room/Board'
GROUP BY State;

/*PROBLEM 5-
The Question is:
 How does the distribution of expenses vary between 2-year and 4-year programs for each state?
 */
 
 SELECT State, `Length`, AVG(`Value`) AS `Average Cost`
 FROM US_DATA
 GROUP BY State, `Length`;
 
 /* PROBLEM 6-
 The question is:
 Calculate the average annual growth rate of educational expenses for each state and institution type over a 5-year period (2010-2015).
 */
 
 SELECT State, Year,Type, AVG(Value) AS `Average Cost`
 FROM US_DATA WHERE Year BETWEEN 2010 AND 2015
 GROUP BY State,Year, Type;
 
 

