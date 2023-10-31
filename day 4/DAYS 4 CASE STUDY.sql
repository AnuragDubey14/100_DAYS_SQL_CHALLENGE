-- ---------------DAY 4 OF 100 DAY OF SQL CHALLENGE 

-- --------------SALES DATA ANALYSIS AND CASE STUDY 

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE DAY4;

-- -------------SELECT DATABASE DAY4 TO USE FURTHER
USE DAY4;

-- ---------I HAVE A SAMPLE PAPER SALES DATASET THAT I HAVE DOWNLOADED FROM MODE 
-- ---------AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

-- ---------LETS SEE SAMPLE DATA 
select * from paper_sales LIMIT 5;

-- --------TOTAL NUMBER OF ROWS

select count(*) AS `NUMBER OF ROW` from paper_sales;

-- ---------LETS SOLVE THE BUSINESS CASE QUESTIONS 

-- SECTION - 1  Total Revenue Analysis:
-- What is the total revenue generated from all orders?

SELECT ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES;

-- What is the total revenue generated by each paper type?

SELECT PAPER_TYPE AS `PAPER TYPE`, ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY PAPER_TYPE;

-- SECTION - 2 Order Status Analysis:
-- How many orders are in each status (COMPLETED, RETURNED, CANCELLED)?
SELECT STATUS, COUNT(*) AS `NUMBER OF ORDERS` FROM PAPER_SALES
GROUP BY STATUS;

-- SECTION - 3 Product Analysis:
-- Which product has the highest revenue?

SELECT PRODUCT_NAME,ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY PRODUCT_NAME ORDER BY `TOTAL REVENUE` DESC LIMIT 1;

-- Which product has the highest quantity ordered?

SELECT PRODUCT_NAME,SUM(QUANTITY) AS `TOTAL QUANTITY` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC ;

-- What is the average rating for each product?
SELECT PRODUCT_NAME, AVG(RATING) AS `AVERAGE RATING` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- SECTION - 4 Shipping Analysis:
-- What is the average shipping cost for each shipping mode (EXPRESS, REGULAR)?

SELECT SHIPPING_MODE AS `SHIPPING MODE`, AVG(SHIPPING_COST) AS `AVERAGE SHIPPING COST`  FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- Which shipping mode is the most commonly used?
SELECT SHIPPING_MODE AS `SHIPPING MODE`, COUNT(SHIPPING_MODE) AS `FREQUENCY` 
FROM PAPER_SALES GROUP BY 1;

-- SECTION -5 Customer Analysis:
-- Who are the top 10 customers by total revenue?

SELECT ORDER_CONTACT_NAME AS `CUSTOMER NAME`, ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC LIMIT 10;

-- Which account manager has the most revenue?
 
SELECT ACCOUNT_MANAGER AS `ACCOUNT MANAGER`,ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- How many orders were cancelled by each customer?
SELECT ORDER_CONTACT_NAME AS `CUSTOMER`,COUNT(*) AS `NUMBER OF ORDERED CANCELLED` FROM PAPER_SALES
WHERE STATUS = 'RETURNED'
GROUP BY 1;

-- SECTION 6 - Time Analysis:
-- What is the average time taken to close an order?

SELECT AVG(DAYS_TO_CLOSE) AS `AVERAGE DAY TO CLOSE THE ORDER` FROM PAPER_SALES;

-- What is the average time taken to ship an order?

 SELECT AVG(DAYS_TO_SHIP) AS `AVERAGE DAY TO SHIP THE ORDER` FROM PAPER_SALES;
 
 -- SECTION 7 - Discount Analysis:
-- What is the average discount applied to orders in each paper type?

SELECT PAPER_TYPE AS `PAPER TYPE`,AVG(DISCOUNT) AS `AVERAGE DISCOUNT` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- Which product has the highest average discount?
SELECT PRODUCT_NAME AS `PRODUCT_NAME`,AVG(DISCOUNT) AS `AVERAGE DISCOUNT` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- SECTION 8 - Review Analysis:
-- What is the average rating for orders with reviews?
SELECT ORDER_ID, AVG(RATING) AS `AVERAGE RATING`,GROUP_CONCAT(REVIEW SEPARATOR '; ') AS `REVIEWS`
FROM
    PAPER_SALES
GROUP BY
    ORDER_ID
ORDER BY
    `AVERAGE RATING` DESC;

-- SECTION - 9 Location Analysis:
-- Which region has the highest total revenue?

SELECT SHIPPING_REGION AS `REGION`, ROUND(SUM(REVENUE)) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 DESC;

-- Which state has the highest total revenue?
SELECT SHIPPING_STATE AS `STATE`,ROUND(SUM(REVENUE)) AS `TOTAL REVENUE` FROM PAPER_SALES
GROUP BY 1 ORDER BY 2 LIMIT 1;

-- SECTION - 10 Return Analysis:

-- How many orders were returned, and what was the total revenue for returned orders?

SELECT ROUND(SUM(REVENUE),3) AS `TOTAL REVENUE` FROM PAPER_SALES
WHERE STATUS='RETURNED';