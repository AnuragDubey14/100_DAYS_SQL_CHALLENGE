select * from sales;
select * from menu;
select * from members;


-- What is the total amount each customer spent at the restaurant?
select m.customer_id,sum(price) as 'Total Spent' from members m inner join sales s on m.customer_id=s.customer_id
inner join menu on s.product_id=menu.product_id
group by m.customer_id
order by 2 desc;

-- How many days has each customer visited the restaurant?
select s.customer_id,count(distinct(order_date)) as 'Days Visited' from members m inner join sales s on m.customer_id=s.customer_id
group by s.customer_id;

-- What was the first item from the menu purchased by each customer?
WITH RankedSales AS (
  SELECT
    s.customer_id,
    m.product_name,
    ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS purchase_rank
  FROM
    sales s
    INNER JOIN menu m ON s.product_id = m.product_id
)

SELECT customer_id, product_name
FROM RankedSales
WHERE purchase_rank = 1;


-- What is the most purchased item on the menu and how many times was it purchased by all customers?
with most_purchase_item as 
(select product_name,count(*) Number_of_purchase,
dense_rank() over(order by count(*) desc) as rnk 
from sales s inner join menu m on s.product_id=m.product_id
group by product_name)

select product_name,Number_of_purchase from most_purchase_item
where rnk=1;

-- Which item was the most popular for each customer?
SELECT customer_id, product_name, number_of_time_ordered
FROM (
  SELECT
    m.customer_id,
    product_name,
    COUNT(*) AS number_of_time_ordered,
    DENSE_RANK() OVER (PARTITION BY m.customer_id ORDER BY COUNT(*) DESC) AS rnk
  FROM
    members m
    INNER JOIN sales s ON m.customer_id = s.customer_id
    INNER JOIN menu ON s.product_id = menu.product_id
  GROUP BY m.customer_id, product_name
) ranked_items
WHERE rnk = 1;

-- Which item was purchased first by the customer after they became a member?
with item_first_purchase as (
select m.customer_id,product_name,
row_number() over(partition by m.customer_id order by order_date asc) as rn 
from members m inner join sales s on m.customer_id=s.customer_id
inner join menu on menu.product_id=s.product_id
where m.join_date<s.order_date)

select customer_id,product_name
from item_first_purchase
where rn=1;


-- Which item was purchased just before the customer became a member?
with item_first_purchase as (
select m.customer_id,product_name,
row_number() over(partition by m.customer_id order by order_date desc) as rn from members m inner join sales s on m.customer_id=s.customer_id
inner join menu on menu.product_id=s.product_id
where m.join_date>s.order_date)

select customer_id,product_name
from item_first_purchase
where rn=1;


-- What is the total items and amount spent for each member before they became a member?

select m.customer_id,
count(product_name) as 'total items',
sum(price) as 'total amount spent'
from members m inner join sales s on m.customer_id=s.customer_id
inner join menu on menu.product_id=s.product_id
where m.join_date>s.order_date
group by m.customer_id
order by 1;

-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier -
-- how many points would each customer have?
WITH PointsPerPurchase AS (
  SELECT
    s.customer_id,
    m.product_name,
    m.price,
    CASE WHEN m.product_name = 'sushi' THEN m.price * 20 ELSE m.price * 10 END AS points
  FROM
    sales s
    INNER JOIN menu m ON s.product_id = m.product_id
)

SELECT
  customer_id,
  SUM(points) AS total_points
FROM PointsPerPurchase
GROUP BY customer_id
ORDER BY customer_id;

/*In the first week after a customer joins the program (including their join date) 
they earn 2x points on all items, not just sushi - 
how many points do customer A and B have at the end of January?*/

WITH PointsPerPurchase AS (
  SELECT
    s.customer_id,
    product_name,
    price,
    CASE
      WHEN s.order_date <= m.join_date + INTERVAL 7 DAY THEN price * 20
      ELSE price * 10
    END AS points
  FROM
    sales s
    INNER JOIN menu  ON s.product_id = menu.product_id
    inner join members m on m.customer_id=s.customer_id
    where month(s.order_date)=1 and s.customer_id in ('A','B')
)

SELECT
  customer_id,
  SUM(points) AS total_points
FROM PointsPerPurchase
GROUP BY customer_id
ORDER BY customer_id;



