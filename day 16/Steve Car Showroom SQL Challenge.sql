create Database Car_Showroom;

use Car_Showroom;

CREATE TABLE cars (
car_id INT PRIMARY KEY,
make VARCHAR(50),
type VARCHAR(50),
style VARCHAR(50),
cost_$ INT
);

INSERT INTO cars (car_id, make, type, style, cost_$)
VALUES (1, 'Honda', 'Civic', 'Sedan', 30000),
(2, 'Toyota', 'Corolla', 'Hatchback', 25000),
(3, 'Ford', 'Explorer', 'SUV', 40000),
(4, 'Chevrolet', 'Camaro', 'Coupe', 36000),
(5, 'BMW', 'X5', 'SUV', 55000),
(6, 'Audi', 'A4', 'Sedan', 48000),
(7, 'Mercedes', 'C-Class', 'Coupe', 60000),
(8, 'Nissan', 'Altima', 'Sedan', 26000);

CREATE TABLE salespersons (
salesman_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
city VARCHAR(50)
);

INSERT INTO salespersons (salesman_id, name, age, city)
VALUES (1, 'John Smith', 28, 'New York'),
(2, 'Emily Wong', 35, 'San Fran'),
(3, 'Tom Lee', 42, 'Seattle'),
(4, 'Lucy Chen', 31, 'LA');

CREATE TABLE sales (
sale_id INT PRIMARY KEY,
car_id INT,
salesman_id INT,
purchase_date DATE,
FOREIGN KEY (car_id) REFERENCES cars(car_id),
FOREIGN KEY (salesman_id) REFERENCES salespersons(salesman_id)
);

INSERT INTO sales (sale_id, car_id, salesman_id, purchase_date)
VALUES (1, 1, 1, '2021-01-01'),
(2, 3, 3, '2021-02-03'),
(3, 2, 2, '2021-02-10'),
(4, 5, 4, '2021-03-01'),
(5, 8, 1, '2021-04-02'),
(6, 2, 1, '2021-05-05'),
(7, 4, 2, '2021-06-07'),
(8, 5, 3, '2021-07-09'),
(9, 2, 4, '2022-01-01'),
(10, 1, 3, '2022-02-03'),
(11, 8, 2, '2022-02-10'),
(12, 7, 2, '2022-03-01'),
(13, 5, 3, '2022-04-02'),
(14, 3, 1, '2022-05-05'),
(15, 5, 4, '2022-06-07'),
(16, 1, 2, '2022-07-09'),
(17, 2, 3, '2023-01-01'),
(18, 6, 3, '2023-02-03'),
(19, 7, 1, '2023-02-10'),
(20, 4, 4, '2023-03-01');


SELECT * FROM cars;
SELECT * FROM salesperson;
SELECT * FROM sales;










-- 1. What are the details of all cars purchased in the year 2022?

SELECT DISTINCT c.car_id, c.make, c.type, c.style, c.cost_$
FROM cars AS c
INNER JOIN sales AS s ON c.car_id = s.car_id
WHERE YEAR(s.purchase_date) = '2022';







-- 2. What is the total number of cars sold by each salesperson?

SELECT sp.salesman_id, sp.name AS 'salesman name', COUNT(s.sale_id) AS 'Sold number of car'
FROM salespersons AS sp
INNER JOIN sales AS s ON sp.salesman_id = s.salesman_id
GROUP BY 1, 2;




/*
3. What is the total revenue generated by each salesperson?
*/

SELECT sp.salesman_id, sp.name, SUM(c.cost_$) AS `Total Revenue`
FROM salespersons AS sp
INNER JOIN sales AS s ON sp.salesman_id = s.salesman_id
INNER JOIN cars AS c ON c.car_id = s.car_id
GROUP BY 1, 2;



/*
4. What are the details of the cars sold by each salesperson?
*/

SELECT
    sp.salesman_id, sp.name AS 'Salesperson Name', c.car_id, c.make, c.type, c.style, c.cost_$
FROM salespersons AS sp
JOIN sales AS s ON sp.salesman_id = s.salesman_id
JOIN cars AS c ON s.car_id = c.car_id;


/* 
5. What is the total revenue generated by each car type?
*/


SELECT c.type, SUM(c.cost_$) AS 'Total Revenue'
FROM cars AS c
INNER JOIN sales AS s ON c.car_id=s.car_id
GROUP BY c.type
ORDER BY 2 DESC;

/* 
6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?
*/

SELECT 
    c.* 
FROM cars AS c
INNER JOIN sales AS s ON c.car_id = s.car_id
INNER JOIN salespersons AS sp ON sp.salesman_id = s.salesman_id
WHERE YEAR(s.purchase_date) = 2021 AND sp.name = 'Emily Wong';




/* 
7. What is the total revenue generated by the sales of hatchback cars?
*/

SELECT 
    c.style, SUM(c.cost_$) AS 'Total Revenue Hatchback'
FROM cars AS c 
INNER JOIN sales AS s ON c.car_id = s.car_id
WHERE c.style = 'Hatchback'
GROUP BY c.style;


/* 
8. What is the total revenue generated by the sales of SUV cars in the year 2022?
*/


SELECT c.style, SUM(c.cost_$) AS 'Total Revenue SUV'
FROM cars AS c 
INNER JOIN sales AS s ON c.car_id=s.car_id 
WHERE c.style='SUV' AND YEAR(s.purchase_date)='2022'
GROUP BY 1; 


/* 
9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
*/


SELECT 
name AS 'SalesPerson Name', city 
FROM salespersons 
WHERE name IN (
SELECT 
sp.name
FROM salespersons AS sp 
INNER JOIN sales AS s ON sp.salesman_id = s.salesman_id 
WHERE YEAR(s.purchase_date) = '2023'
GROUP BY sp.name
ORDER BY COUNT(s.sale_id) DESC
LIMIT 1);

/* 
10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?
*/

SELECT 
    sp.name AS 'SalesPerson Name', 
    sp.age AS 'SalesPerson Age'
FROM salespersons AS sp
JOIN sales AS s ON sp.salesman_id = s.salesman_id
JOIN cars AS c ON s.car_id = c.car_id
WHERE YEAR(s.purchase_date) = '2022'
GROUP BY sp.name, sp.age
ORDER BY SUM(c.cost_$) DESC
LIMIT 1;



