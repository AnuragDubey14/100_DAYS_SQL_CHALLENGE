-- ----------------------------------SWIGGY CASE STUDY -------------------------------

-- ------LETS CREATE A NEW DATABASE SWIGGY --------
create database swiggy;

-- ---------- SELECT DATABASE SWIGGY TO USE ------
USE SWIGGY;

 -- ------------LETS CREATE ALL TABLE -----------
 CREATE TABLE USER(user_id INT NOT NULL,	name VARCHAR(45),	email VARCHAR(50),	password VARCHAR(45));
 CREATE TABLE RESTAURANT(r_id INT NOT NULL,	r_name VARCHAR(50),	cuisine VARCHAR(50));
 CREATE TABLE FOOD(f_id INT NOT NULL,	f_name VARCHAR(50),	type VARCHAR(45));
 CREATE TABLE MENU(menu_id INT NOT NULL,	r_id INT ,	f_id INT,	price DOUBLE);
 CREATE TABLE ORDERS(order_id INT,	user_id INT,	r_id INT,	amount INT,	date DATE,	partner_id INT,	delivery_time INT,	delivery_rating	INT , restaurant_rating INT);
 CREATE TABLE DELIVERY_PARTNER(partner_id INT,	partner_name VARCHAR(50));
 CREATE TABLE ORDER_DETAILS(id INT,	order_id INT,	f_id INT);
 
 -- -----------INSERT DATA IN ALL THE TABLES --------------------
 
 -- -----------INSERT DATA INTO USER TABLE ---------------------
 
 INSERT INTO USER(user_id, name, email, password) VALUES ('1', 'Nitish', 'nitish@gmail.com', 'p252h')
, ('2', 'Khushboo', 'khushboo@gmail.com', 'hxn9b'),
('3', 'Vartika', 'vartika@gmail.com', '9hu7j'),
('4', 'Ankit', 'ankit@gmail.com', 'lkko3'),
('5', 'Neha', 'neha@gmail.com', '3i7qm'),
('6', 'Anupama', 'anupama@gmail.com', '46rdw2'),
('7', 'Rishabh', 'rishabh@gmail.com', '4sw123');

-- --------------INSERT DATA INTO RESTAURANT TABLE ----------------

INSERT INTO RESTAURANT(r_id, r_name, cuisine) VALUES ('1', 'dominos', 'Italian'),
('2', 'kfc', 'American'),
('3', 'box8', 'North Indian'),
 ('4', 'Dosa Plaza', 'South Indian'),
('5', 'China Town', 'Chinese');

-- -----------INSERT DATA INTO FOOD TABLE ----------------------------

INSERT INTO FOOD (f_id, f_name, type) VALUES ('1', 'Non-veg Pizza', 'Non-veg'),
('2', 'Veg Pizza', 'Veg'),
('3', 'Choco Lava cake', 'Veg'),
('4', 'Chicken Wings', 'Non-veg'),
('5', 'Chicken Popcorn', 'Non-veg'),
('6', 'Rice Meal', 'Veg'),
('7', 'Roti meal', 'Veg'),
('8', 'Masala Dosa', 'Veg'),
('9', 'Rava Idli', 'Veg'),
('10', 'Schezwan Noodles', 'Veg'),
('11',	'Veg Manchurian','Veg');

-- -----------------INSERT DATA INTO MENU TABLE ------------------------

INSERT INTO MENU (menu_id, r_id, f_id, price) VALUES ('1', '1', '1', '450'),
('2', '1', '2', '400'),
('3', '1', '3', '100'),
('4', '2', '3', '115'),
('5', '2', '4', '230'),
('6', '2', '5', '300'),
('7', '3', '3', '80'),
('8', '3', '6', '160'),
('9', '3', '7', '140'),
('10', '4', '6', '230'),
('11', '4', '8', '180'),
('12', '4', '9', '120'),
('13', '5', '6', '250'),
('14', '5', '10', '220'),
('15', '5', '11', '180');

-- -----------------------INSERT DATA INTO ORDERS TABLE ---------------------------------

INSERT INTO ORDERS VALUES
(1001, 1, 1, 550, '2022-05-10', 1, 25, 5, 3),
(1002, 1, 2, 415, '2022-05-26', 1, 19, 5, 2),
(1003, 1, 3, 240, '2022-06-15', 5, 29, 4, NULL),
(1004, 1, 3, 240, '2022-06-29', 4, 42, 3, 5),
(1005, 1, 3, 220, '2022-07-10', 1, 58, 1, 4),
(1006, 2, 1, 950, '2022-06-10', 2, 16, 5, NULL),
(1007, 2, 2, 530, '2022-06-23', 3, 60, 1, 5),
(1008, 2, 3, 240, '2022-07-07', 5, 33, 4, 5),
(1009, 2, 4, 300, '2022-07-17', 4, 41, 1, NULL),
(1010, 2, 5, 650, '2022-07-31', 1, 67, 1, 4),
(1011, 3, 1, 450, '2022-05-10', 2, 25, 3, 1),
(1012, 3, 4, 180, '2022-05-20', 5, 33, 4, 1),
(1013, 3, 2, 230, '2022-05-30', 4, 45, 3, NULL),
(1014, 3, 2, 230, '2022-06-11', 2, 55, 1, 2),
(1015, 3, 2, 230, '2022-06-22', 3, 21, 5, NULL),
(1016, 4, 4, 300, '2022-05-15', 3, 31, 5, 5),
(1017, 4, 4, 300, '2022-05-30', 1, 50, 1, NULL),
(1018, 4, 4, 400, '2022-06-15', 2, 40, 3, 5),
(1019, 4, 5, 400, '2022-06-30', 1, 70, 2, 4),
(1020, 4, 5, 400, '2022-07-15', 3, 26, 5, 3),
(1021, 5, 1, 550, '2022-07-01', 5, 22, 2, NULL),
(1022, 5, 1, 550, '2022-07-08', 1, 34, 5, 1),
(1023, 5, 2, 645, '2022-07-15', 4, 38, 5, 1),
(1024, 5, 2, 645, '2022-07-21', 2, 58, 2, 1),
(1025, 5, 2, 645, '2022-07-28', 2, 44, 4, NULL);

-- ----------------INSERT DATA INTO DELIVERY PARTNER TABLE ------------------

INSERT INTO DELIVERY_PARTNER (partner_id, partner_name)
VALUES
  ('1', 'Suresh'),
  ('2', 'Amit'),
  ('3', 'Lokesh'),
  ('4', 'Kartik'),
  ('5', 'Gyandeep');
  
  -- ----------------- INSERT DATA INTO ORDER DETAILS TABLE -----------------
  
  INSERT INTO ORDER_DETAILS(id, order_id, f_id)
VALUES
('1', '1001', '1'),
('2', '1001', '3'),
('3', '1002', '4'),
('4', '1002', '3'),
('5', '1003', '6'),
('6', '1003', '3'),
('7', '1004', '6'),
('8', '1004', '3'),
('9', '1005', '7'),
('10', '1005', '3'),
('11', '1006', '1'),
('12', '1006', '2'),
('13', '1006', '3'),
('14', '1007', '4'),
('15', '1007', '3'),
('16', '1008', '6'),
('17', '1008', '3'),
('18', '1009', '8'),
('19', '1009', '9'),
('20', '1010', '10'),
('21', '1010', '11'),
('22', '1010', '6'),
('23', '1011', '1'),
('24', '1012', '8'),
('25', '1013', '4'),
('26', '1014', '4'),
('27', '1015', '4'),
('28', '1016', '8'),
('29', '1016', '9'),
('30', '1017', '8'),
('31', '1017', '9'),
('32', '1018', '10'),
('33', '1018', '11'),
('34', '1019', '10'),
('35', '1019', '11'),
('36', '1020', '10'),
('37', '1020', '11'),
('38', '1021', '1'),
('39', '1021', '3'),
('40', '1022', '1'),
('41', '1022', '3'),
('42', '1023', '3'),
('43', '1023', '4'),
('44', '1023', '5'),
('45', '1024', '3'),
('46', '1024', '4'),
('47', '1024', '5'),
('48', '1025', '3'),
('49', '1025', '4'),
('50', '1025', '5');

-- ----------------------- LETS CHECK INSERTED DATA INTO ALL TABLE ---------------

select * from delivery_partner;
select * from food;
select * from orders;
select * from menu;
select * from restaurant;
SELECT * FROM ORDER_DETAILS;
select * from user;

-- --------------------- LETS SOLVE THE BUSINESS CASE QUESTIONS ----------------

-- Q1. Find customers who have never ordered

select USER_ID,NAME FROM USER WHERE USER_ID NOT IN (SELECT DISTINCT USER_ID FROM ORDERS);

-- Q2. Average Price/dish

SELECT MENU.F_ID, FOOD.F_NAME, AVG(MENU.PRICE) AS AVERAGE_PRICE
FROM MENU
INNER JOIN FOOD ON FOOD.F_ID = MENU.F_ID
GROUP BY MENU.F_ID, FOOD.F_NAME;

-- Q3. Find the top restaurant in terms of the number of orders for a given month

SELECT R.R_NAME AS RESTAURANT_NAME, 
       month(O.DATE) AS MONTH, 
       COUNT(O.R_ID) AS NUMBER_OF_ORDERS
FROM ORDERS AS O 
INNER JOIN RESTAURANT AS R ON R.R_ID = O.R_ID
GROUP BY R.R_NAME, MONTH(O.DATE)
having month=5
ORDER BY NUMBER_OF_ORDERS DESC;

-- Q4. restaurants with monthly sales greater than x for 

-- first solution 

SELECT R.R_NAME AS RESTAURANT_NAME,
       MONTH(O.DATE) AS MONTH,
       SUM(O.AMOUNT) AS MONTHLY_SALES
FROM ORDERS AS O
INNER JOIN RESTAURANT AS R ON O.R_ID = R.R_ID
GROUP BY MONTH(O.DATE), R.R_NAME
HAVING SUM(O.AMOUNT) > 500 AND MONTH = 5;

-- second solution 

select r.r_name,sum(amount) as revenue,monthname(date) as month
from orders as o
join restaurant as r
on o.r_id=r.r_id
where monthname(date) like 'may'
group by r.r_name, o.r_id, month
having revenue>500;


-- Q5. Show all orders with order details for a particular customer in a particular date range
SELECT o.order_id,r.r_name,f.f_name
from orders as o
join restaurant r 
on r.r_id=o.r_id
join order_details od
on o.order_id=od.order_id
join food f 
on f.f_id=od.f_id
where user_id=(select user_id from user where name like 'Nitish')
and (date >'2022-06-10' and date < '2022-07-10');

-- Q6. Find restaurants with max repeated customers

SELECT R.R_NAME, COUNT(*) AS LOYAL_CUSTOMER
FROM (
    SELECT R_ID, USER_ID, COUNT(*) AS VISITS
    FROM ORDERS
    GROUP BY R_ID, USER_ID
    HAVING VISITS > 1
) AS T
JOIN RESTAURANT R ON R.R_ID = T.R_ID
GROUP BY R.R_NAME  -- Include R.R_NAME in the GROUP BY
ORDER BY LOYAL_CUSTOMER DESC
LIMIT 1;

-- Q7. Month over month revenue growth of swiggy

SELECT MONTH, ((REVENUE - PREV) / PREV) * 100 AS PERCENT_CHANGE
FROM (
  WITH SALES AS (
    SELECT MONTH(DATE) AS 'MONTH', SUM(AMOUNT) AS 'REVENUE'
    FROM ORDERS
    GROUP BY MONTH(DATE)
  )
  SELECT MONTH, REVENUE, LAG(REVENUE, 1) OVER (ORDER BY MONTH) AS PREV
  FROM SALES
) AS T;

-- Q8. Customer - favorite food

WITH TEMP AS (
SELECT O.USER_ID,OD.F_ID,COUNT(*) AS FREQUENCY FROM ORDERS O 
JOIN ORDER_DETAILS OD ON O.ORDER_ID=OD.ORDER_ID
GROUP BY O.USER_ID,OD.F_ID
)
SELECT U.NAME,F.F_NAME,T1.FREQUENCY FROM TEMP AS T1 
JOIN USER U ON U.USER_ID=T1.USER_ID
JOIN FOOD F ON F.F_ID=T1.F_ID 
WHERE T1.FREQUENCY = (SELECT MAX(FREQUENCY) FROM TEMP T2 WHERE T2.USER_ID=T1.USER_ID);

-- Q9. Find the most loyal customers for all restaurant

SELECT R.R_NAME,U.NAME
FROM (
    SELECT R_ID, USER_ID, COUNT(*) AS VISITS
    FROM ORDERS
    GROUP BY R_ID, USER_ID
    HAVING VISITS > 1
) AS T
JOIN RESTAURANT R ON R.R_ID = T.R_ID
JOIN USER U ON U.USER_ID=T.USER_ID
GROUP BY R.R_NAME ,U.NAME 
ORDER BY COUNT(*) DESC;

-- Q10. Month over month revenue growth of a restaurant

SELECT R_NAME AS RESTAURANT_NAME, MONTH, ((REVENUE - PREV) / PREV) * 100 AS PERCENT_CHANGE
FROM (
  WITH SALES AS (
    SELECT MONTH(DATE) AS 'MONTH', SUM(AMOUNT) AS 'REVENUE', ORDERS.R_ID,RESTAURANT.R_NAME
    FROM ORDERS 
    JOIN RESTAURANT ON ORDERS.R_ID=RESTAURANT.R_ID
    GROUP BY MONTH(DATE), ORDERS.R_ID,RESTAURANT.R_NAME
    HAVING R_ID = 1
  )
  SELECT R_NAME,MONTH, REVENUE, LAG(REVENUE, 1) OVER (PARTITION BY R_ID ORDER BY MONTH) AS PREV 
  FROM SALES
) AS T;





