use awesome_chocolate;
show tables;
use `awesome chocolates`;
show tables;

select * from geo;
select * from people;
select * from products;
select * from sales;

-- 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales where Amount>2000 and Boxes<100;

-- 2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select Salesperson,count(*) as 'Total Shipments' from sales  s inner join people p on s.SPID=p.SPID
where SaleDate between '2022-01-01' and '2022-01-31'
group by Salesperson
order by 2 desc;


-- 3. Which product sells more boxes? Milk Bars or Eclairs?
select product,sum(Boxes) as total_box from sales s inner join products p on s.PID=p.PID
where product='Milk Bars' or product='Eclairs'
group by product
order by total_box desc;


-- 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select product,sum(Boxes) as 'Total Box Sold' from sales s inner join products p on s.PID=p.PID
where SaleDate between '2022-02-01' and '2022-02-07' and product in ('Milk Bars','Eclairs')
group by product
order by sum(Boxes) desc;


-- 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select SaleDate,Amount,Customers,Boxes,
case when DAYOFWEEK(SaleDate)=4 then 'Shipment on Wednesday'
else 'Shipment on other day' end as `Shipment day` from sales 
where Customers <100 and Boxes<100; 

-- HARD PROBLEMS
-- 👉 These require concepts not covered in the video

-- 1. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select distinct(SalesPerson) as `SalesPerson Name` from sales s inner join people p on s.SPID=p.SPID
where SaleDate between '2022-01-01' and '2022-01-07';


-- 2. Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.salesperson
from people p
where p.spid not in
(select distinct s.spid from sales s where s.SaleDate between '2022-01-01' and '2022-01-07');


-- 3. How many times we shipped more than 1,000 boxes in each month?

select year(saledate) as Year, month(saledate) as 'Month', count(*) as 'Times we shipped 1k boxes'
from sales
where boxes>1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

-- 4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?

select case when count(*)=12 then 'Yes'
else 'No' end as `total months we shipped at least one box`
from (select month(SaleDate) as month from sales s
inner join products p on s.PID=p.PId and p.product='After Nines'
inner join geo g on s.GeoID=g.GeoID and g.Geo='New Zealand'
group by month(SaleDate)
)  shipment_in_new_zealand_all_month;


-- 5. India or Australia? Who buys more chocolate boxes on a monthly basis?
select month,
India_buys_boxes as 'India Buys Boxes',
Australia_buys_boxes as 'Australia Buys Boxes',
case when India_buys_boxes>Australia_buys_boxes then 'India Buys More'
else 'Australia Buys More'
end as 'Who Buy more' from (select month(SaleDate) as month,
sum(case when g.Geo='India' then Boxes end) as India_buys_boxes,
sum(case when g.Geo='Australia' then Boxes end) as Australia_buys_boxes
from sales s inner join geo g on s.GeoID=g.GeoID and g.Geo in ('India','Australia')
group by month(SaleDate)) as Buy_detail_India_Australia;

 

