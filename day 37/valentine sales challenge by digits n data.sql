create database valentine;
use valentine;

-- Table for storing information about countries
    CREATE TABLE Countries (
        country_id INT PRIMARY KEY,
        country_name VARCHAR(100) NOT NULL
    );
    
    -- Table for storing information about chocolate products
    CREATE TABLE Products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        brand VARCHAR(100) NOT NULL
    );
    
    -- Table for storing information about sales
    CREATE TABLE Sales (
        sale_id INT PRIMARY KEY,
        product_id INT NOT NULL,
        country_id INT NOT NULL,
        sale_date DATE NOT NULL,
        quantity_sold INT NOT NULL,
        revenue DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (product_id) REFERENCES Products(product_id),
        FOREIGN KEY (country_id) REFERENCES Countries(country_id)
    );
    
    INSERT INTO Countries (country_id, country_name) VALUES
    (1, 'United States'),
    (2, 'United Kingdom'),
    (3, 'Canada'),
    (4, 'Australia'),
    (5, 'Germany'),
    (6, 'France'),
    (7, 'Italy'),
    (8, 'Spain'),
    (9, 'Japan'),
    (10, 'China'),
    (11, 'India'),
    (12, 'Brazil'),
    (13, 'Mexico'),
    (14, 'South Korea'),
    (15, 'Netherlands'),
    (16, 'Switzerland'),
    (17, 'Sweden'),
    (18, 'Norway'),
    (19, 'Denmark'),
    (20, 'Finland'),
    (21, 'Belgium'),
    (22, 'Austria'),
    (23, 'Portugal'),
    (24, 'Greece'),
    (25, 'Ireland'),
    (26, 'New Zealand'),
    (27, 'South Africa'),
    (28, 'Singapore'),
    (29, 'Hong Kong'),
    (30, 'Malaysia'),
    (31, 'Thailand'),
    (32, 'Philippines'),
    (33, 'Vietnam'),
    (34, 'Indonesia'),
    (35, 'Argentina'),
    (36, 'Chile'),
    (37, 'Colombia'),
    (38, 'Peru'),
    (39, 'Turkey'),
    (40, 'Russia'),
    (41, 'Poland'),
    (42, 'Hungary'),
    (43, 'Czech Republic'),
    (44, 'Romania'),
    (45, 'Ukraine'),
    (46, 'Egypt'),
    (47, 'Saudi Arabia'),
    (48, 'United Arab Emirates'),
    (49, 'Israel'),
    (50, 'Pakistan');
    
    INSERT INTO Products (product_id, product_name, brand) VALUES
    (1, 'Dairy Milk', 'Cadbury'),
    (2, 'Hershey''s Milk Chocolate', 'Hershey''s'),
    (3, 'Milka', 'Milka'),
    (4, 'Lindt Excellence', 'Lindt'),
    (5, 'Ghirardelli Intense Dark', 'Ghirardelli'),
    (6, 'Toblerone', 'Toblerone'),
    (7, 'Ferrero Rocher', 'Ferrero'),
    (8, 'Godiva Dark Chocolate', 'Godiva'),
    (9, 'Green & Black''s Organic Chocolate', 'Green & Black''s'),
    (10, 'KitKat', 'Nestlé'),
    (11, 'Snickers', 'Mars'),
    (12, 'Twix', 'Mars'),
    (13, 'M&M''s', 'Mars'),
    (14, 'Cadbury Silk', 'Cadbury'),
    (15, 'Cadbury Bournville', 'Cadbury'),
    (16, 'Cadbury Fuse', 'Cadbury'),
    (17, 'Terry''s Chocolate Orange', 'Terry''s'),
    (18, 'Nestlé Crunch', 'Nestlé'),
    (19, 'Cadbury Flake', 'Cadbury'),
    (20, 'Cadbury Dairy Milk Silk Oreo', 'Cadbury'),
    (21, 'Nestlé Milkybar', 'Nestlé'),
    (22, 'Nestlé Toll House Chocolate Chips', 'Nestlé'),
    (23, 'Cadbury Caramello', 'Cadbury'),
    (24, 'Lindt Lindor', 'Lindt'),
    (25, 'Cadbury Dairy Milk Fruit & Nut', 'Cadbury'),
    (26, 'Cadbury Dairy Milk Roast Almond', 'Cadbury'),
    (27, 'Cadbury Dairy Milk Silk', 'Cadbury'),
    (28, 'Cadbury 5 Star', 'Cadbury'),
    (29, 'Cadbury Perk', 'Cadbury'),
    (30, 'Cadbury Dairy Milk Crackle', 'Cadbury'),
    (31, 'Cadbury Bournvita', 'Cadbury'),
    (32, 'Cadbury Choclairs Gold', 'Cadbury'),
    (33, 'Cadbury Gems', 'Cadbury'),
    (34, 'Cadbury 3 Wishes', 'Cadbury'),
    (35, 'Cadbury Fuse Chocolicious', 'Cadbury'),
    (36, 'Cadbury Temptations', 'Cadbury'),
    (37, 'Cadbury Dairy Milk Silk Bubbly', 'Cadbury'),
    (38, 'Cadbury Dairy Milk Shots', 'Cadbury'),
    (39, 'Cadbury Celebrations', 'Cadbury'),
    (40, 'Cadbury Dairy Milk Miniatures', 'Cadbury'),
    (41, 'Cadbury Perk Cashew', 'Cadbury'),
    (42, 'Cadbury Dairy Milk Silk Hazelnut', 'Cadbury'),
    (43, 'Cadbury Dairy Milk Lickables', 'Cadbury'),
    (44, 'Cadbury Dairy Milk Lickables Oreo', 'Cadbury'),
    (45, 'Cadbury Dairy Milk Crispello', 'Cadbury'),
    (46, 'Cadbury Dairy Milk Silk Roast Almond', 'Cadbury'),
    (47, 'Cadbury Dairy Milk Marvellous Creations', 'Cadbury'),
    (48, 'Cadbury Dairy Milk Silk Mousse', 'Cadbury'),
    (49, 'Cadbury Dairy Milk Silk Oreo Red Velvet', 'Cadbury'),
    (50, 'Cadbury Dairy Milk Silk Hazelnut', 'Cadbury');
    
    INSERT INTO Sales (sale_id, product_id, country_id, sale_date, quantity_sold, revenue) VALUES
    (1, 1, 1, '2024-02-14', 100, 500.00),
    (2, 2, 2, '2024-02-14', 75, 300.00),
    (3, 3, 3, '2024-02-14', 50, 250.00),
    (4, 4, 4, '2024-02-14', 200, 1000.00),
    (5, 5, 5, '2024-02-14', 150, 750.00),
    (6, 6, 6, '2024-02-14', 80, 400.00),
    (7, 7, 7, '2024-02-14', 120, 600.00),
    (8, 8, 8, '2024-02-14', 90, 450.00),
    (9, 9, 9, '2024-02-14', 60, 300.00),
    (10, 10, 10, '2024-02-14', 100, 500.00),
    (11, 11, 11, '2024-02-14', 75, 375.00),
    (12, 12, 12, '2024-02-14', 50, 250.00),
    (13, 13, 13, '2024-02-14', 200, 1000.00),
    (14, 14, 14, '2024-02-14', 150, 750.00),
    (15, 15, 15, '2024-02-14', 80, 400.00),
    (16, 16, 16, '2024-02-14', 120, 600.00),
    (17, 17, 17, '2024-02-14', 90, 450.00),
    (18, 18, 18, '2024-02-14', 60, 300.00),
    (19, 19, 19, '2024-02-14', 100, 500.00),
    (20, 20, 20, '2024-02-14', 75, 375.00),
    (21, 21, 21, '2024-02-14', 50, 250.00),
    (22, 22, 22, '2024-02-14', 200, 1000.00),
    (23, 23, 23, '2024-02-14', 150, 750.00),
    (24, 24, 24, '2024-02-14', 80, 400.00),
    (25, 25, 25, '2024-02-14', 120, 600.00),
    (26, 26, 26, '2024-02-14', 90, 450.00),
    (27, 27, 27, '2024-02-14', 60, 300.00),
    (28, 28, 28, '2024-02-14', 100, 500.00),
    (29, 29, 29, '2024-02-14', 75, 375.00),
    (30, 30, 30, '2024-02-14', 50, 250.00),
    (31, 31, 31, '2024-02-14', 200, 1000.00),
    (32, 32, 32, '2024-02-14', 150, 750.00),
    (33, 33, 33, '2024-02-14', 80, 400.00),
    (34, 34, 34, '2024-02-14', 120, 600.00),
    (35, 35, 35, '2024-02-14', 90, 450.00),
    (36, 36, 36, '2024-02-14', 60, 300.00),
    (37, 37, 37, '2024-02-14', 100, 500.00),
    (38, 38, 38, '2024-02-14', 75, 375.00),
    (39, 39, 39, '2024-02-14', 50, 250.00),
    (40, 40, 40, '2024-02-14', 200, 1000.00),
    (41, 41, 41, '2024-02-14', 150, 750.00),
    (42, 42, 42, '2024-02-14', 80, 400.00),
    (43, 43, 43, '2024-02-14', 120, 600.00),
    (44, 44, 44, '2024-02-14', 90, 450.00),
    (45, 45, 45, '2024-02-14', 60, 300.00),
    (46, 46, 46, '2024-02-14', 100, 500.00),
    (47, 47, 47, '2024-02-14', 75, 375.00),
    (48, 48, 48, '2024-02-14', 50, 250.00),
    (49, 49, 49, '2024-02-14', 200, 1000.00),
    (50, 50, 50, '2024-02-14', 150, 750.00);



-- Let's see the data 
select * from dbo.Countries;
select * from dbo.Products;
select * from dbo.Sales;



-- Let's solve some Questions 

-- 1)Find the product with the highest average revenue per sale?
with product_avg_sale as (select p.product_name,AVG(s.revenue) as highest_revenue,
DENSE_RANK() over(order by AVG(s.revenue) desc) as rnk
from dbo.Products p left join dbo.Sales s
on p.product_id=s.product_id
group by p.product_name)
select product_name,highest_revenue
from product_avg_sale where rnk=1;



-- 2)Find the product with the highest total revenue?
with product_total_revenue as (select p.product_name,sum(s.revenue) as total_revenue,
DENSE_RANK() over(order by sum(s.revenue) desc) as rnk
from dbo.Products p left join dbo.Sales s
on p.product_id=s.product_id
group by p.product_name)
select product_name,total_revenue
from product_total_revenue where rnk=1;



-- 3)Determine the month with the highest total revenue across all sales?
select top 1 month(sale_date) as Month,SUM(revenue) as total_revenue
from dbo.Sales
group by month(sale_date)
order by 2 desc;


-- 4)What are the names of all the countries listed in the table?
select country_name from dbo.Countries;


-- 5)How many countries are there in total?
select COUNT(distinct(country_id)) as 'Number of Countries' 
from dbo.Countries;


-- 6)Which brand has the highest number of products?
with brand_with_number_of_product as (select brand,COUNT(product_name) as 'total product',
DENSE_RANK() over(order by COUNT(product_name) desc) as rnk
from dbo.Products
group by brand)
select brand,[total product] 
from brand_with_number_of_product
where rnk=1;



-- 7)What is the average quantity sold per transaction?
SELECT AVG(quantity_sold) AS average_quantity_sold
FROM Sales;


-- 8)Which country generated the highest revenue from Cadbury sales?
with country_with_high_revenue_in_cadbury as (select country_name,SUM(revenue) as 'total revenue',
DENSE_RANK() over(order by SUM(revenue) desc) as rnk
from dbo.Countries c left join dbo.Sales s on c.country_id=s.country_id
inner join dbo.Products p on p.product_id=s.product_id and p.brand='Cadbury'
group by country_name) 
select country_name,[total revenue] from country_with_high_revenue_in_cadbury
where rnk=1;


--  9)On which date were the most sales recorded?
select sale_date,
count(sale_id) as 'total number of sales' from Sales
group by sale_date
order by 2 desc;


-- 10)Which product has the highest quantity sold?
with product_quantity_sold as (select product_name,sum(quantity_sold) as 'total quantity sold',
DENSE_RANK() over(order by sum(quantity_sold) desc) as rnk
from Products p left join Sales s on p.product_id=s.product_id
group by product_name)
select product_name,[total quantity sold] from product_quantity_sold
where rnk=1;