use practice;


CREATE TABLE pubs (
pub_id INT PRIMARY KEY,
pub_name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);

--------------------

-- Create the 'beverages' table

CREATE TABLE beverages (
beverage_id INT PRIMARY KEY,
beverage_name VARCHAR(50),
category VARCHAR(50),
alcohol_content FLOAT,
price_per_unit DECIMAL(8, 2)
);


--------------------

-- Create the 'sales' table

-- Drop the sales table if it exists
DROP TABLE IF EXISTS sales;

-- Create the sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    pub_id INT,
    beverage_id INT,
    quantity INT,
    transaction_date DATE,
    FOREIGN KEY (pub_id) REFERENCES pubs(pub_id),
    FOREIGN KEY (beverage_id) REFERENCES beverages(beverage_id)
);



--------------------
-- Create the 'ratings' table 
CREATE TABLE ratings
( rating_id INT PRIMARY KEY,
pub_id INT, 
customer_name VARCHAR(50), 
rating FLOAT, 
review TEXT,
FOREIGN KEY (pub_id) REFERENCES pubs(pub_id) );

--------------------
-- Insert sample data into the 'pubs' table
INSERT INTO pubs (pub_id, pub_name, city, state, country)
VALUES
(1, 'The Red Lion', 'London', 'England', 'United Kingdom'),
(2, 'The Dubliner', 'Dublin', 'Dublin', 'Ireland'),
(3, 'The Cheers Bar', 'Boston', 'Massachusetts', 'United States'),
(4, 'La Cerveceria', 'Barcelona', 'Catalonia', 'Spain');
--------------------
-- Insert sample data into the 'beverages' table
INSERT INTO beverages (beverage_id, beverage_name, category, alcohol_content, price_per_unit)
VALUES
(1, 'Guinness', 'Beer', 4.2, 5.99),
(2, 'Jameson', 'Whiskey', 40.0, 29.99),
(3, 'Mojito', 'Cocktail', 12.0, 8.99),
(4, 'Chardonnay', 'Wine', 13.5, 12.99),
(5, 'IPA', 'Beer', 6.8, 4.99),
(6, 'Tequila', 'Spirit', 38.0, 24.99);

--------------------

INSERT INTO sales (sale_id, pub_id, beverage_id, quantity, transaction_date)
VALUES
(1, 1, 1, 10, '2023-05-01'),
(2, 1, 2, 5, '2023-05-01'),
(3, 2, 1, 8, '2023-05-01'),
(4, 3, 3, 12, '2023-05-02'),
(5, 4, 4, 3, '2023-05-02'),
(6, 4, 6, 6, '2023-05-03'),
(7, 2, 3, 6, '2023-05-03'),
(8, 3, 1, 15, '2023-05-03'),
(9, 3, 4, 7, '2023-05-03'),
(10, 4, 1, 10, '2023-05-04'),
(11, 1, 3, 5, '2023-05-06'),
(12, 2, 2, 3, '2023-05-09'),
(13, 2, 5, 9, '2023-05-09'),
(14, 3, 6, 4, '2023-05-09'),
(15, 4, 3, 7, '2023-05-09'),
(16, 4, 4, 2, '2023-05-09'),
(17, 1, 4, 6, '2023-05-11'),
(18, 1, 6, 8, '2023-05-11'),
(19, 2, 1, 12, '2023-05-12'),
(20, 3, 5, 5, '2023-05-13');


--------------------
-- Insert sample data into the 'ratings' table
INSERT INTO ratings (rating_id, pub_id, customer_name, rating, review)
VALUES
(1, 1, 'John Smith', 4.5, 'Great pub with a wide selection of beers.'),
(2, 1, 'Emma Johnson', 4.8, 'Excellent service and cozy atmosphere.'),
(3, 2, 'Michael Brown', 4.2, 'Authentic atmosphere and great beers.'),
(4, 3, 'Sophia Davis', 4.6, 'The cocktails were amazing! Will definitely come back.'),
(5, 4, 'Oliver Wilson', 4.9, 'The wine selection here is outstanding.'),
(6, 4, 'Isabella Moore', 4.3, 'Had a great time trying different spirits.'),
(7, 1, 'Sophia Davis', 4.7, 'Loved the pub food! Great ambiance.'),
(8, 2, 'Ethan Johnson', 4.5, 'A good place to hang out with friends.'),
(9, 2, 'Olivia Taylor', 4.1, 'The whiskey tasting experience was fantastic.'),
(10, 3, 'William Miller', 4.4, 'Friendly staff and live music on weekends.');


----------------------------------

select * from pubs;
select * from beverages;
select * from ratings;
select * from sales;


----------------------------------
-- 1. How many pubs are located in each country??
select country,count(*) as 'Number of Pubs'
from pubs
group by country;


-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
select pub_name,SUM(quantity*price_per_unit) as 'Total Sales Amount'
from pubs p inner join sales s on p.pub_id=s.pub_id
inner join beverages b on b.beverage_id=s.beverage_id
group by pub_name;


-- 3. Which pub has the highest average rating?
with avg_pub_rating as (select pub_name,AVG(rating) as average_rating,
DENSE_RANK() over(order by AVG(rating) desc) as rnk
from pubs p inner join ratings r on p.pub_id=r.pub_id
group by pub_name)

select pub_name,average_rating from avg_pub_rating where rnk=1;



-- 4. What are the top 5 beverages by sales quantity across all pubs?
select top 5 beverage_name,SUM(quantity) as 'Total quantity sold'
from beverages b inner join sales s on b.beverage_id=s.beverage_id
group by beverage_name
order by 2 desc;


-- 5. How many sales transactions occurred on each date?
select transaction_date,count(sale_id) as 'Transactions Occurred'
from sales
group by transaction_date
order by 2 desc;


-- 6. Find the name of someone that had cocktails and which pub they had it in.
select customer_name,pub_name
from ratings r inner join pubs p on r.pub_id=p.pub_id
inner join sales s on s.pub_id=p.pub_id
inner join beverages b on b.beverage_id=s.beverage_id and category='Cocktail';



-- 7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
select category,
AVG(price_per_unit) as 'Average Price Per Category'
from beverages
where category<>'Spirit'
group by category
order by 2 desc;



-- 8. Which pubs have a rating higher than the average rating of all pubs?
select pub_name,rating
from pubs p inner join ratings r on p.pub_id=r.pub_id
where rating>(select 
AVG(rating) from ratings);



-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
select pub_name,
transaction_date,
SUM(quantity*price_per_unit) over(partition by pub_name order by transaction_date) as running_total
from pubs p inner join sales s on p.pub_id=s.pub_id
inner join beverages b on b.beverage_id=s.beverage_id;



-- 10. For each country, what is the average price per unit of beverages in each category, 
-- and what is the overall average price per unit of beverages across all categories?

WITH cte AS (
    SELECT
        country,
        category,
        AVG(price_per_unit) AS avg_price_per_unit_category
    FROM  pubs p
    JOIN  sales s ON p.pub_id = s.pub_id
    JOIN  beverages b ON s.beverage_id = b.beverage_id
    GROUP BY  country, category
), 
cte1 AS (
    SELECT
        country,
        AVG(price_per_unit) AS overall_avg_price_per_unit
    FROM  pubs p
    JOIN  sales s ON p.pub_id = s.pub_id
    JOIN  beverages b ON s.beverage_id = b.beverage_id
    GROUP BY  country )
SELECT 
    cte.country,
    cte.category,
    cte.avg_price_per_unit_category,
    cte1.overall_avg_price_per_unit
FROM cte
JOIN cte1 ON cte.country = cte1.country
ORDER BY cte.country, cte.category;


-- 11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, 
-- and what is the pub's overall sales amount?

WITH pub_sales AS (
    SELECT
        p.pub_id,
        pub_name,
        category,
        SUM(quantity * price_per_unit) AS sales_amount,
        SUM(SUM(quantity * price_per_unit)) OVER (PARTITION BY p.pub_id) AS total_sales_amount
    FROM pubs p
    JOIN sales s ON p.pub_id = s.pub_id
    JOIN beverages b ON s.beverage_id = b.beverage_id
    GROUP BY p.pub_id, pub_name, category
)
SELECT
    pub_id,
    pub_name,
    category,
    sales_amount,
    sales_amount / total_sales_amount * 100 AS percentage_contribution,
    total_sales_amount AS overall_sales_amount
FROM pub_sales
ORDER BY pub_id, category;
