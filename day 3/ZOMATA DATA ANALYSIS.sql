-- ----------------------------------------DAY 3 OF 100 DAY OF SQL CHALLENGE------------------------------

-- ----------------------------------------ZOMATO SALES ANALYSIS------------------------------------------
-- ----LETS CREATE NEW DATABASE ZOMATO --------------------------------------------

create database zomato;

-- -----SELECT NEWLY CREATED DATABASE ---------------------------------------------
use zomato;

-- -----LETS CREATE SOME TABLES----------------------------------------------------
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

CREATE TABLE users(userid integer,signup_date date); 

CREATE TABLE sales(userid integer,created_date date,product_id integer);
 
CREATE TABLE product(product_id integer,product_name text,price integer); 

-- -------LETS INSERT DATA INTO ALL THE CREATED TABLE-------------------

INSERT INTO goldusers_signup(userid, gold_signup_date) 
VALUES (1, '2017-09-22'),
       (3, '2017-04-21');

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-09-11',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

-- --------------RETRIEVE/CHECK ALL INSERTED DATA---------------

select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

-- -----------LETS SOLVE THE BUSINESS CASE QUESTIONS-------------

-- Q1. what is the total amount each customer spent on zomato?

SELECT a.userid, SUM(b.price) AS total_amount_spent
FROM sales AS a
INNER JOIN product AS b ON a.product_id = b.product_id
GROUP BY a.userid;

-- Q2. How many days has each customer visited zomato?

select userid,count(distinct(created_date)) distinct_days from sales group by userid;


-- Q3. What was the first product purchased by each customer?

select * from(
select *,rank() over(partition by userid order by created_date)rnk from sales) 
a where rnk=1;

-- Q4.1 What is the most purchased item on the menu and how many times was it purchased by all customers?

select product_id,count(product_id) as most_purchased_product from 
sales group by product_id order by count(product_id) desc limit 1;

-- Q4.2 how many times was it purchased by all customers?

select userid ,count(product_id) as cnt from sales where product_id=
(select product_id from 
sales group by product_id order by count(product_id) desc limit 1)
group by userid;

-- Q5. which item was the most popular for each customer?

WITH ranked_sales AS (
    SELECT *, RANK() OVER(PARTITION BY userid ORDER BY cnt DESC) AS rnk
    FROM (
        SELECT userid, product_id, COUNT(product_id) AS cnt
        FROM sales
        GROUP BY userid, product_id
    ) AS subquery_alias
)
SELECT *
FROM ranked_sales
WHERE rnk = 1;


