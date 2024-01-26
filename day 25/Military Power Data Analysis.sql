create database military;

use military;

select * from military_power;

--Easy Level:

-- 1-Retrieve the names of all countries in the dataset.
select distinct(country) from military_power;


-- 2-Find countries with more than 500,000 active personnel.
select country,Active_personnel from military_power
where Active_personnel >500000;


-- 3-Calculate the average defense budget across all countries.
select avg(Defense_Budget) as average_defense_budget from military_power;


-- 4-List countries and their coastline coverage in descending order.
select country,Coastline_Coverage from military_power
order by Coastline_Coverage Desc;

-- 5-Display countries that have helicopter carriers.
select country,Helicopter_Carriers from military_power
where Helicopter_Carriers <> 0;


-- Intermediate Level:
-- 1-List the top 3 countries with the highest defense budget as a percentage of their GDP.
select Top 3 country,Defense_Budget from military_power
order by Defense_Budget DESC;


-- 2-Calculate the ratio of Navy ships to coastline coverage for each country.
SELECT 
    country,
    CASE 
        WHEN Coastline_Coverage <> 0 AND Navy_Ships <> 0 THEN Navy_Ships*1.0 / Coastline_Coverage * 1.0
        WHEN Navy_Ships = 0 THEN Coastline_Coverage
        WHEN Coastline_Coverage <> 0 THEN Navy_Ships
    END AS Navy_Ships_to_Coastline_Ratio
FROM 
    military_power
ORDER BY 
    Navy_Ships_to_Coastline_Ratio DESC;



-- 3-Retrieve countries with external debt greater than 500 billion.
select country,External_debt from military_power
where External_debt>500000000000;

-- 4-Display countries where the number of fighters is greater than the number of interceptors.
-- note - There is not a separate column for number of fighter

select country,Fighters_interceptors from military_power
order by Fighters_interceptors desc;





-- 5-Calculate the density of submarines per coastline kilometer for each country.
select 
    country,
    Case when submarines<>0 and Coastline_Coverage<>0 then Submarines*1.0 / Coastline_Coverage*1.0
	when Submarines=0 then 0
	when Coastline_Coverage=0 then 0 
	end AS Submarines_Per_Coastline_Kilometer
from military_power;

-- Hard Level:

-- 1-Rank countries based on the number of attack helicopters they possess.
select country,
Attack_Helicopters,
dense_rank() over(order by Attack_Helicopters Desc) as Attack_Helicopter_rank
from military_power;


-- 2-Create a military strength index by combining active personnel, tanks, and total aircraft strength.
SELECT 
    country,
    (Active_Personnel + Tanks + Total_Aircraft_Strength) AS Military_Strength_Index
FROM 
    military_power
order by Military_Strength_Index desc;


-- 3-Find countries where the defense budget is greater than the GDP and the number of tanks is greater than 5,000.
SELECT 
    country,
    defense_budget,
    external_debt,
    tanks
FROM 
    military_power
WHERE 
    defense_budget > external_debt
    AND tanks > 5000;

-- 4-Calculate the average oil consumption per capita for all countries.
select country,
ROUND(oil_consumption*1.0/Total_Population ,4) as avg_oil_consumption_per_capita
from military_power
order by 2 desc;

-- 5-Retrieve countries where the percentage of the population reaching military age annually is in the top 10%.
SELECT 
    country,
    Reaching_Mil_Age_Annually,
    Total_Population,
    ROUND((Reaching_Mil_Age_Annually * 100.0) / Total_Population, 2) AS Percentage_Reaching_Mil_Age
FROM 
    military_power
WHERE 
    ROUND((Reaching_Mil_Age_Annually * 100.0) / Total_Population, 2) >= 10
ORDER BY 
    Percentage_Reaching_Mil_Age DESC;

select * from military_power;
-- 6-Display countries that share borders with the country having the highest external debt.
-- Note - Don't have information which country shared the borders with which country


-- 7-Calculate the defense budget per active personnel for each country.
select country,
round(Defense_Budget*1.0 / Active_Personnel,2) AS Defense_Budget_Per_Active_Personnel
from military_power
where Active_Personnel <>0
order by 2 desc;

-- 8-Retrieve countries that have a special-mission category unique to them.
SELECT country
FROM military_power
WHERE 
    Special_Mission <> 0
    AND country NOT IN (
        SELECT country
        FROM military_power
        WHERE Special_Mission <>0
        GROUP BY country
        HAVING COUNT(*) > 1);

-- 9-List countries with a purchasing power parity greater than 2 trillion and external debt less than 200 billion.
SELECT  country
FROM military_power
WHERE Purchasing_Power_Parity > 2E12
    AND External_Debt < 2E11;


--10-Retrieve countries where the number of ports/trade terminals is greater than the number of railway coverage points.

select country,Ports_Trade_Terminals,Railway_Coverage from military_power
where Ports_Trade_Terminals>Railway_Coverage;

