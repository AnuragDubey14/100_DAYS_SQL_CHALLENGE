-- -------------------- Day 8 of 100 days SQL Challenge ------------

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE DAY8;

-- -------------SELECT DATABASE DAY5 TO USE FURTHER
USE DAY8 ;

-- ---I HAVE MULTIPLE DATASET THAT I HAVE DOWNLOADED
-- ---AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

-- ---------LETS SEE SAMPLE DATA FROM ALL AVAILABLE TABLES 
SELECT * FROM CATEGORY;
SELECT * FROM ORDER_DETAILS;
SELECT * FROM ORDERS;
SELECT * FROM USERS;


-- ---------Problem Solution ------------------

-- Problem 1- Find all the orders placed in pune?
select * from orders 
join users
on orders.user_id = users.user_id
where users.city='Pune';

-- Problem 2-  Find all orders under the Chairs category?
select * from order_details
join category 
on order_details.category_id=category.category_id
where category.vertical='Chairs';

-- Problem 3- Find all Profitable orders?
select o.order_id,sum(od.profit) as `Profit`
from orders as o
join order_details as od
on o.order_id=od.order_id
group by o.order_id
having Profit>0
order by Profit desc;


-- Problem 4- Find the customer who has placed the max number of orders? 
select u.name,count(*) as`number of orders`
from orders as o
join users as u
on o.user_id=u.user_id
Group by u.name
order by `number of orders` desc limit 1;

-- Problem 5- Which is the most profitable category? 
select c.vertical,sum(profit) as `Total Profit`
from order_details od join category c 
on od.category_id=c.category_id
group by c.vertical
order by `Total Profit` desc limit 1;

-- Problem 6- Which is the most profitable state?
select state, sum(profit) as Profit 
from orders as o join order_details as od
on o.order_id=od.order_id
join users as u on o.user_id = u.user_id
group by state 
order by Profit desc limit 1;

-- Problem 7- Find all categories with profits higher than 5000
select c.vertical,sum(profit) as profit
from order_details od join category c 
on od.category_id=c.category_id
Group by c.vertical
Having profit > 5000; 


