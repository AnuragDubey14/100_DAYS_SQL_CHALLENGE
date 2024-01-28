create database data_professional;

use data_professional;

-- I import the file using flat file option in ms-sql server
-- let's see the data

select * from data_professional;

-- let's solve question and analyse the data 

-- Easy Level:

-- 1-Retrieve all columns for employees with the job title 'Data Analyst'.
select * from data_professional where job_title='Data Analyst';


-- 2-List distinct job categories present in the dataset.
select distinct(job_category) as job_category from data_professional;


-- 3-Find the average salary (in USD) for all job categories.
select avg(salary_in_usd) as 'Salary(USD)' from data_professional;


-- Moderate Level:

-- 1-Identify the top 5 job titles with the highest average salary.
select top 5 job_title, avg(salary) as average_salary from data_professional
group by job_title
order by average_salary desc;


-- 2-Calculate the total number of employees for each experience level.
select experience_level,count(*) as 'total_employee' from data_professional
group by experience_level
order by 2 desc;


-- 3-Retrieve the job title and salary for employees with a salary greater than $100,000 USD.
select job_title,salary_in_usd from data_professional
where salary_in_usd>100000
order by 2 desc;

-- 4-Determine the average salary for each company size.
select company_size,avg(salary) as average_salary,avg(salary_in_usd) as average_salary_usd from data_professional
group by company_size
order by average_salary desc,average_salary_usd desc;


-- Hard Level:

-- 1-Find the company location with the highest average salary for Data Scientists.
with cte as (select company_location,avg(salary) as average_salary,
dense_rank() over(order by avg(salary) desc) as rnk from data_professional
where job_title='Data Scientist'
group by company_location)

select company_location,average_salary from cte where rnk=1;


-- 2-Identify the top 3 job titles with the highest total salary across all companies.
with cte as (select job_title,sum(salary) as total_salary,
DENSE_RANK() over(order by sum(salary) desc) as rnk 
from data_professional
group by job_title)
select job_title, total_salary from cte where rnk<=3;


-- 3-Calculate the median salary for each job category.
SELECT
    job_category,
    AVG(salary) AS median_salary
FROM (
    SELECT
        job_category,
        salary,
        ROW_NUMBER() OVER (PARTITION BY job_category ORDER BY salary) AS row_num,
        COUNT(*) OVER (PARTITION BY job_category) AS total_rows
    FROM
        data_professional
) AS RankedSalaries
WHERE
    row_num IN ((total_rows + 1) / 2, (total_rows + 2) / 2)
GROUP BY
    job_category;


-- 4-Retrieve the job title and salary for employees who work in a remote setting and have an experience level of 'Senior'.
select job_title,salary,salary_in_usd 
from data_professional
where work_setting='Remote' and experience_level='Senior';

-- 5-Find the company size with the highest number of employees.
select top 1 company_size,count(*) as total_employee
from data_professional
group by company_size
order by total_employee desc;


-- 6-Calculate the average salary for each job title in the 'Technology' job category.
select job_title,avg(salary) as average_salary from data_professional
where job_category='Technology'
group by job_title
order by average_salary desc;


-- 7-Identify the top 3 companies with the highest total salary payout.
-- Note - there is no information about the company
select * from data_professional;

-- Advanced Level:
-- 1-Find the job title with the highest salary for employees working in 'Large' companies.
select top 1 job_title,avg(salary) as highest_salary
from data_professional
where company_size='L'
group by job_title
order by highest_salary desc;


-- 2-Calculate the salary growth percentage for each job title between the years 2022 and 2023.
SELECT
    job_title,
    (SUM(CASE WHEN work_year = 2023 THEN salary ELSE 0 END) - SUM(CASE WHEN work_year = 2022 THEN salary ELSE 0 END)) /
    SUM(CASE WHEN work_year = 2022 THEN salary ELSE 1 END) * 100.0 AS growth_percentage
FROM data_professional
WHERE work_year IN (2022, 2023)
GROUP BY job_title
ORDER BY growth_percentage DESC;


-- 3-Determine the company location with the highest average salary for employees with an experience level of 'Mid-Level'.
select top 1 company_location,avg(salary) as highest_average_salary
from data_professional
where experience_level='Mid-level'
group by company_location
order by highest_average_salary desc;


-- 4-Identify the job title with the highest salary in each job category.
WITH RankedSalaries AS (
    SELECT
        job_category, job_title, salary,
		ROW_NUMBER() OVER (PARTITION BY job_category ORDER BY salary DESC) AS salary_rank
    FROM data_professional
)
SELECT job_category, job_title, salary
FROM RankedSalaries
WHERE salary_rank = 1;




-- 5-Calculate the average salary for employees in each company size, considering only those with an 'Advanced' experience level.
select company_size,avg(salary) as average_salary 
from data_professional
where experience_level='Senior'
group by company_size 
order by average_salary desc;


-- 6-Find the job title with the highest salary increase from the year 2022 to 2024.
-- Note - we have no data for the year 2024
