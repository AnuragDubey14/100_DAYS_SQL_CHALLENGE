-- productions schema tables

select * from production.brands;
select * from production.categories;
select * from production.products;
select * from production.stocks;

-- sales schema tables
select * from sales.customers;
select * from sales.order_items;
select * from sales.orders;
select * from sales.staffs;
select * from sales.stores;


-- data analysis 

-- Beginner Level Questions  

--1.  Retrieve all columns from the customers table.
select * from sales.customers;

--2. List all distinct states from the customers table.
select distinct(state) as 'State' from sales.customers;

--3. Count the total number of customers in the customers table.
select count(*) as 'number of customer' from sales.customers;

-- 4. Retrieve the first 5 rows from the order_items table.
select top 5 * from sales.order_items;

--5. Find the total number of orders in the orders table.
select count(*) as 'Number of Orders' from sales.orders;

-- 6. Display the first and last names of staff members in the staffs table.
select first_name, last_name from sales.staffs;

-- 7. Calculate the average quantity of items sold from the order_items table.
SELECT item_id, AVG(quantity) AS average_quantity
FROM sales.order_items
GROUP BY item_id;

--8. Show the top 5 customers (by customer_id) who made the most orders.
SELECT top 5 c.customer_id,c.first_name,c.last_name,count(*) as total_orders FROM sales.customers as c inner join sales.orders as o on c.customer_id=o.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total_orders desc;



-- Intermediate Level 

--1. Find the total revenue generated from all orders. (Consider list_price and discount in order_items table)
SELECT 
    SUM((oi.list_price - (oi.list_price * oi.discount)) * oi.quantity) AS total_revenue
FROM 
    sales.order_items oi;

--2. Identify the customer with the highest total spending.
select top 1 c.customer_id,c.first_name,c.last_name,
sum((oi.list_price - (oi.list_price * oi.discount)) * oi.quantity) as 'spending' 
from sales.customers as c inner join sales.orders as o on c.customer_id=o.customer_id
inner join sales.order_items as oi on o.order_id=oi.order_id
group by c.customer_id,c.first_name,c.last_name
order by 'spending' desc;

-- 3. List the products (product_id, product name) with the highest and lowest list_price.
select product_id,product_name  from production.products
where list_price=(select max(list_price) from production.products)
or list_price=(select min(list_price) from production.products);

-- 4. Calculate the average order processing time in days.
SELECT AVG(DATEDIFF(day, shipped_date, order_date)) AS 'average_order_processing_days'
FROM sales.orders;

-- 5. Determine the staff member who has processed the most orders.
select top 1 s.staff_id ,s.first_name,s.last_name from sales.staffs as s inner join 
sales.orders as o on s.staff_id=o.staff_id
group by s.staff_id,s.first_name,s.last_name
order by count(*) desc;




-- Advanced Level 

--1. Find the store that has the highest total revenue
select top 1 s.store_id,s.store_name,sum((oi.list_price - (oi.list_price * oi.discount)) * oi.quantity) as total_revenue 
from sales.stores as s inner join sales.orders as o on s.store_id=o.store_id 
inner join sales.order_items as oi on oi.order_id=o.order_id
group by s.store_id,s.store_name
order by total_revenue desc;


--2. Identify the most popular product (by quantity sold).
select top 1 p.product_id,p.product_name,sum(oi.quantity) as 'total_quantity_ordered' from production.products
as p inner join sales.order_items as oi on p.product_id=oi.product_id
group by p.product_id,p.product_name
order by sum(oi.quantity) desc;


--3. Display the customer(s) who have not placed any orders.
select * from sales.customers where customer_id not in (
select customer_id from sales.orders);


--4. Calculate the average discount percentage applied to orders.
SELECT AVG(discount) AS 'average_discount_percentage'
FROM sales.order_items;



-- 5. Find the months with the highest and lowest numbers of orders.
SELECT Month, TotalOrders
FROM (
    SELECT TOP 1 MONTH(order_date) AS 'Month', COUNT(order_id) AS 'TotalOrders'
    FROM sales.orders
    GROUP BY MONTH(order_date)
    ORDER BY TotalOrders DESC

    UNION

    SELECT TOP 1 MONTH(order_date) AS 'Month', COUNT(order_id) AS 'TotalOrders'
    FROM sales.orders
    GROUP BY MONTH(order_date)
    ORDER BY TotalOrders ASC
) AS Subquery;




