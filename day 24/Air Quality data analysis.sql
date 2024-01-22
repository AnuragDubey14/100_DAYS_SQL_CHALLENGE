-- creating database

Create database AQI;

-- select database to use further
use AQI;

-- create table using flat file options
-- let's explore inserted data 
select * from Air_Quality;

-- let's do analysis on this AIR Quality data and solve some questions 



-- Easy Level:
-- 1. Retrieve all columns for all rows in the dataset.

SELECT * FROM Air_Quality;


-- 2. Display unique countries present in the dataset.
SELECT DISTINCT(dbo.Air_Quality.country) FROM Air_Quality;


-- 3. Count the total number of records in the dataset.
SELECT COUNT(*) AS 'Total Records' FROM Air_Quality;


-- 4. List all distinct pollutants recorded in the dataset.
SELECT DISTINCT(dbo.Air_Quality.pollutant_id) FROM Air_Quality;


-- 5. Retrieve records for a specific city of your choice.
SELECT * FROM Air_Quality WHERE dbo.Air_Quality.city='Gwalior';



-- Intermediate Level:


-- 1. Calculate the average pollutant_avg for each pollutant across all stations.
SELECT dbo.Air_Quality.pollutant_id, 
AVG(dbo.Air_Quality.pollutant_avg) AS 'Average_pollutant' 
FROM Air_Quality 
GROUP BY dbo.Air_Quality.pollutant_id
ORDER BY 'Average_pollutant' DESC;



-- 2. Find the station(s) with the highest pollutant_max value and display their details.
SELECT * FROM Air_Quality 
WHERE dbo.Air_Quality.pollutant_max=(SELECT
MAX(dbo.Air_Quality.pollutant_max)
FROM Air_Quality);



-- 3. List the states where the air quality is not recorded (missing entries for pollutant values).
SELECT * FROM Air_Quality
WHERE dbo.Air_Quality.pollutant_id IS NULL OR
dbo.Air_Quality.pollutant_min IS NULL OR
dbo.Air_Quality.pollutant_max IS NULL OR
dbo.Air_Quality.pollutant_avg IS NULL;



-- 4. -Retrieve the records where the latitude is greater than a specified value.
DECLARE @specified_latitude FLOAT;
SET @specified_latitude = 20.0;

SELECT * FROM Air_Quality
WHERE dbo.Air_Quality.latitude > @specified_latitude;



--5. Display the city and station with the lowest pollutant_min value.
SELECT dbo.Air_Quality.city,
dbo.Air_Quality.station,
dbo.Air_Quality.pollutant_min
FROM Air_Quality 
WHERE dbo.Air_Quality.pollutant_min = (SELECT 
MIN(dbo.Air_Quality.pollutant_min)
FROM Air_Quality);



-- Advanced Level:


-- 1.Identify the country with the highest overall pollutant_avg value.

SELECT TOP 1 dbo.Air_Quality.country,
AVG(dbo.Air_Quality.pollutant_avg) AS overall_avg
FROM Air_Quality
GROUP BY dbo.Air_Quality.country
ORDER BY overall_avg DESC;



-- 2. Determine the top 3 cities with the lowest average pollutant_avg values.

SELECT TOP 3 dbo.Air_Quality.city,
AVG(dbo.Air_Quality.pollutant_avg) AS overall_avg
FROM Air_Quality
GROUP BY dbo.Air_Quality.city
ORDER BY overall_avg ASC;



-- 3.Calculate the percentage change in pollutant_avg from the previous update for a specific station.

DECLARE @station_code VARCHAR(50); 
SET @station_code = 'MPPCB'; 

WITH PollutantChange AS (
    SELECT
        dbo.Air_Quality.station,
        dbo.Air_Quality.last_update,
        dbo.Air_Quality.pollutant_avg,
        LAG(dbo.Air_Quality.pollutant_avg) OVER (PARTITION BY dbo.Air_Quality.station ORDER BY dbo.Air_Quality.last_update) AS prev_pollutant_avg
    FROM Air_Quality 
    WHERE dbo.Air_Quality.station_code = @station_code
)
SELECT station, last_update,
    pollutant_avg,
    prev_pollutant_avg,
    CASE
        WHEN prev_pollutant_avg IS NOT NULL THEN
            ((pollutant_avg - prev_pollutant_avg) / prev_pollutant_avg) * 100
        ELSE
            NULL
    END AS percentage_change
FROM PollutantChange
ORDER BY last_update;



-- 4. Rank the stations based on their total pollutant_avg values in descending order.
SELECT dbo.Air_Quality.station,
SUM(dbo.Air_Quality.pollutant_avg)AS 'Total pollutant_Avg',
DENSE_RANK() OVER(ORDER BY SUM(dbo.Air_Quality.pollutant_avg) DESC) AS 'Rank'
FROM dbo.Air_Quality
GROUP BY dbo.Air_Quality.station;




-- 5. Find the city where the air quality has shown the most improvement (highest decrease in pollutant_avg).

WITH CityImprovement AS (
    SELECT
        dbo.Air_Quality.city,
        dbo.Air_Quality.last_update,
        dbo.Air_Quality.pollutant_avg,
        LAG(dbo.Air_Quality.pollutant_avg) OVER (PARTITION BY dbo.Air_Quality.city ORDER BY dbo.Air_Quality.last_update) AS prev_pollutant_avg,
        (dbo.Air_Quality.pollutant_avg - LAG(dbo.Air_Quality.pollutant_avg) OVER (PARTITION BY dbo.Air_Quality.city ORDER BY dbo.Air_Quality.last_update)) AS improvement
    FROM dbo.Air_Quality 
)
SELECT
    city,
    MAX(improvement) AS max_improvement
FROM CityImprovement
GROUP BY city
ORDER BY max_improvement DESC;

