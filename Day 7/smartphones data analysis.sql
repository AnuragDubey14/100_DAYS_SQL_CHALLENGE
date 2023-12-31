-- -------------------- Day 7 of 100 days SQL Challenge ------------

-- -------------LETS CREATE NEW DATABASE 

CREATE DATABASE DAY7;

-- -------------SELECT DATABASE DAY5 TO USE FURTHER
USE DAY7;

-- ---------I HAVE A SMARTPHONES DATASET THAT I HAVE DOWNLOADED
-- ---------AFTER THAT I HAVE THE IMPORTED THE DATASET USING TABLE DATA IMPORT 

-- ---------LETS SEE SAMPLE DATA 
SELECT * FROM SMARTPHONES;

-- --------------- COUNT NUMBER OF ROWS IN THE TABLE
SELECT COUNT(*) AS `NUMBER OF ROWS` FROM SMARTPHONES;

-- --------- LET'S DO SOME PRACTICE ON SORTING 

-- PROBLEM 1- FIND TOP 5 SAMSUNG PHONES WITH BIGGEST SCREEN SIZE

SELECT * FROM SMARTPHONES 
WHERE brand_name='samsung'
ORDER BY screen_size DESC LIMIT 5;

-- PROBLEM 2- SORT ALL THE PHONE WITH IN DESCENDING ORDER OF NUMBER OF TOTAL CAMERA'S

SELECT * FROM SMARTPHONES
ORDER BY (num_front_cameras+num_rear_cameras) DESC;

-- PROBLEM 3- SORT THE DATA ON THE BASIS OF PPI IN DECREASING ORDER

SELECT model,
ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height),2) AS `ppi`
FROM SMARTPHONES
ORDER BY ppi DESC;

-- PROBLEM 4- FIND THE PHONE WITH 2ND LARGEST BATTERY
SELECT * FROM SMARTPHONES 
ORDER BY battery_capacity DESC LIMIT 1,1;

-- PROBLEM 5- FIND THE NAME AND RATING OF THE WORST RATED APPLE PHONE
SELECT model,rating FROM SMARTPHONES
WHERE brand_name = 'apple'
ORDER BY RATING ASC
LIMIT 1;

-- PROBLEM 6- SORT PHONES ALPHABETICALLY AND THEN ON THE BASIS OF RATING IN DESC ORDER
SELECT * FROM SMARTPHONES
ORDER BY MODEL ASC, RATING DESC;

-- PROBLEM 7- SORT PHONES ALPHABETICALLY AND THEN ON THE BASIS OF PRICE IN ASC ORDER
SELECT 	model,price FROM SMARTPHONES
ORDER BY model ASC,price ASC;

-- ---------------- GROUPING DATA -----------------

-- PROBLEM 1- GROUP SMARTPHONES BY BRAND AND GET THE COUNT , AVERAGE PRICE ,MAX RATING, AVG SCREEN SIZE, AND AVERAGE BATTERY CAPACITY

SELECT brand_name, COUNT(*) AS `NUMBER OF PHONES`,
AVG(price) AS `AVERAGE PRICE`, 
MAX(rating) AS `MAX RATING`,
AVG(screen_size) AS `AVERAGE SCREEN SIZE`,
AVG(battery_capacity) AS `AVERAGE BATTERY CAPACITY`
FROM SMARTPHONES
GROUP BY brand_name;

-- PROBLEM 2- GROUP SMARTPHONES BY WETHER THEY HAVE NFC AND GET THE AVERAGE PRICE AND RATING
SELECT 
     has_nfc,
    AVG(price) AS `AVERAGE PRICE`,
    AVG(rating) AS `AVERAGE RATING`
FROM SMARTPHONES
GROUP BY 1;

-- PROBLEM 3- GROUP SMARTPHONES BY THE EXTENDED MEMORY AVAILABLE AND GET THE AVERAGE PRICE
SELECT 
    model, 
    extended_memory_available, 
    AVG(price) AS `AVERAGE PRICE` 
FROM SMARTPHONES 
GROUP BY extended_memory_available,model;

-- PROBLEM 4- GROUP SMARTPHONES BY THE BRAND AND PROCESSOR BRAND AND GET THE COUNT OF MODELS AND THE AVERAGE PRIMARY CAMERA RESOLUTION (REAR)
SELECT brand_name,
processor_brand,
COUNT(*) AS `NUMBER OF MODEL AVAILABLE`,
AVG(primary_camera_rear) AS `AVERAGE PRIMARY CAMERA RESOLUTION`
FROM smartphones
GROUP BY brand_name,processor_brand;

-- PROBLEM 5- FIND TOP 5 COSTLY PHONE BRANDS
SELECT brand_name, AVG(price) AS `AVERAGE PRICE` FROM SMARTPHONES
GROUP BY brand_name
ORDER BY `AVERAGE PRICE` DESC LIMIT 5;

-- PROBLEM 6- WHICH BRAND MAKES THE SMALLEST SCREEN SMARTPHONES
SELECT 
    brand_name, 
    AVG(screen_size) AS average_screen_size 
FROM smartphones 
GROUP BY brand_name 
ORDER BY average_screen_size
LIMIT 1;

-- PROBLEM 7- AVERAGE PRICE OF 5G PHONES VS AVERAGE PRICE OF NON 5G PHONES
SELECT has_5g, AVG(price) AS `AVERAGE PRICE` FROM SMARTPHONES 
GROUP BY has_5g;

-- PROBLEM 8- GROUP SMARTPHONES BY THE BRAND, AND FIND THE BRAND WITH THE HIGHEST NUMBER OF MODELS THAT HAVE BOTH NFC AND IR BLASTER
SELECT brand_name, COUNT(*) AS `NUMBER OF MODELS` 
FROM SMARTPHONES WHERE has_nfc='True' AND has_ir_blaster='True'
GROUP BY brand_name
ORDER BY `NUMBER OF MODELS` DESC LIMIT 1;

-- PROBLEM 9- FIND ALL SAMSUNG 5G ENABLED SMARTPHONES AND FIND OUT THE AVERAGE PRICE FOR NFC AND NON-NFC PHONES
SELECT model,
AVG(price) AS `AVERAGE PRICE`,
 has_nfc
FROM SMARTPHONES
WHERE brand_name='samsung' AND has_5g='True'
GROUP BY model,has_nfc;

-- PROBLEM 10- FIND THE PHONE NAME,PRICE OF THE COSTLIEST PHONE
SELECT model,price FROM SMARTPHONES
ORDER BY price DESC LIMIT 1;


-- -------------------HAVING CLAUSE -------------------

-- PROBLEM 1- FIND THE AVERAGE RATING OF SMARTPHONE BRANDS WHICH HAVE MORE THAN 20 PHONES
SELECT brand_name,
ROUND(AVG(rating),2) AS `AVERAGE RATING`,
COUNT(*) AS `NUMBER OF PHONES`
FROM SMARTPHONES
GROUP BY brand_name
HAVING `NUMBER OF PHONES`>20
ORDER BY `AVERAGE RATING` DESC;


/* PROBLEM 2- FIND THE TOP 3 BRANDS WITH THE HIGHEST AVERAGE RAM THAT HAVE A REFRESH RATE OF AT 
LEAST 90 HZ AND FAST CHARGING AVAILABLE AND DON'T CONSIDER BRANDS WHICH HAVE LESS THAN 10 PHONES */

SELECT brand_name,
AVG(ram_capacity) as `AVERAGE RAM`,COUNT(*) AS `NUMBER OF PHONES`
FROM SMARTPHONES
WHERE refresh_rate > 90 AND fast_charging_available=1
GROUP BY brand_name
HAVING `NUMBER OF PHONES` >=10
ORDER BY `AVERAGE RAM` DESC
LIMIT 3; 

-- ----PROBLEM 3- FIND THE AVERAGE PRICE OF ALL THE PHONE BRANDS WITH THE AVERAGE RATING>70 AND NUM_PHONE MORE THAN 10 AMONG ALL 5G ENABLED PHONES
SELECT brand_name,
AVG(price) AS `AVERAGE PRICE`,
COUNT(*) AS `NUMBER OF PHONES`,
AVG(rating) AS `AVERAGE RATING`
FROM SMARTPHONES 
WHERE has_5g='True'
GROUP BY brand_name
HAVING `AVERAGE RATING`>70
ORDER BY `AVERAGE PRICE` DESC;

