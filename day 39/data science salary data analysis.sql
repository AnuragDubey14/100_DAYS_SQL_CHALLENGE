use practice;

show tables;

select * from salary;

/*You're a Compensation analyst employed by a multinational corporation. 
Your Assignment is to Pinpoint Countries who give work fully remotely, for the title 'managers’
 Paying salaries Exceeding $90,000 USD */
 
 select distinct company_location from salary
 where remote_ratio=100 and job_title like "%manager%" and salary_in_usd>90000;
 
 
 /*AS a remote work advocate Working for a progressive HR tech startup who place their freshers’ clients IN large tech firms. 
 you're tasked WITH Identifying top 5 Country Having greatest count of large (company size) number of companies. */  
 
 select company_location,count(company_size) as number_of_companies from salary
 where company_size='L' and experience_level='EN'
 group by company_location
 order by 2 desc
 limit 5;
 
 
 /*Picture yourself AS a data scientist Working for a workforce management platform.
 Your objective is to calculate the percentage of employees. Who enjoy fully remote roles 
 WITH salaries Exceeding $100,000 USD, Shedding light ON the attractiveness of high-paying
 remote positions IN today's job market.*/
 
 select 
 round(count(case
 when remote_ratio=100 then job_title
	end)/count(*)*100,2) as 'percentage of people working remote and having salary>100000'
 from salary 
 where salary_in_usd>100000;
 
/*Imagine you're a data analyst Working for a global recruitment agency.
 Your Task is to identify the Locations where entry-level average salaries 
 exceed the average salary for that job title IN market for entry level,
 helping your agency guide candidates towards lucrative opportunities.*/
 select t.job_title,company_location,average,average_per_country from (
 (select job_title,avg(salary_in_usd) as average from salary where experience_level="EN" group by job_title
 ) t 
inner join 
(select company_location,job_title,avg(salary_in_usd) as average_per_country from salary where experience_level="EN" group by company_location ,job_title)
m on t.job_title=m.job_title)
where average_per_country>average;



/* You've been hired by a big HR Consultancy to look at how much people get paid IN different Countries.
 Your job is to Find out for each job title which. Country pays the maximum average salary. 
This helps you to place your candidates IN those countries.*/

select job_title,
company_location,
average_salary
 from(
select *, dense_rank() over(partition by job_title order by average_salary desc) as rnk from(
select  job_title, company_location, avg(salary_in_usd) as average_salary from salary 
group by job_title, company_location) t) q where rnk=1;


/* AS a data-driven Business consultant, you've been hired by a multinational corporation to analyze salary 
trends across different company Locations. Your goal is to Pinpoint Locations WHERE the average salary 
Has consistently Increased over the Past few years (Countries WHERE data is available 
for 3 years Only(present year and past two years) providing Insights into Locations experiencing Sustained salary growth.*/

WITH t AS
(
 SELECT * FROM  salary WHERE company_location IN
		(
			SELECT company_location FROM
			(
				SELECT company_location, AVG(salary_IN_usd) AS AVG_salary,COUNT(DISTINCT work_year) AS num_years FROM salary WHERE work_year >= YEAR(CURRENT_DATE()) - 2
				GROUP BY  company_location HAVING  num_years = 3 
			)m
		)
)  
SELECT 
    company_location,
    MAX(CASE WHEN work_year = 2022 THEN  average END) AS AVG_salary_2022,
    MAX(CASE WHEN work_year = 2023 THEN average END) AS AVG_salary_2023,
    MAX(CASE WHEN work_year = 2024 THEN average END) AS AVG_salary_2024
FROM 
(
SELECT company_locatiON, work_year, AVG(salary_IN_usd) AS average FROM  t GROUP BY company_locatiON, work_year 
)q GROUP BY company_locatiON  havINg AVG_salary_2024 > AVG_salary_2023 AND AVG_salary_2023 > AVG_salary_2022; 


/*  Picture yourself AS a workforce strategist employed by a global HR tech startup. Your Mission is to Determine the percentage of 
fully remote work for each experience level IN 2021 and compare it WITH the corresponding figures for 2024, 
Highlighting any significant Increases or decreases IN remote work Adoption over the years.*/


WITH t1 AS 
 (
		SELECT a.experience_level, total_remote ,total_2021, ROUND((((total_remote)/total_2021)*100),2) AS '2021 remote %' FROM
		( 
		   SELECT experience_level, COUNT(experience_level) AS total_remote FROM salary WHERE work_year=2021 and remote_ratio = 100 GROUP BY experience_level
		)a
		INNER JOIN
		(
		  SELECT  experience_level, COUNT(experience_level) AS total_2021 FROM salary WHERE work_year=2021 GROUP BY experience_level
		)b ON a.experience_level= b.experience_level
  ),
  t2 AS
     (
		SELECT a.experience_level, total_remote ,total_2024, ROUND((((total_remote)/total_2024)*100),2)AS '2024 remote %' FROM
		( 
		SELECT experience_level, COUNT(experience_level) AS total_remote FROM salary WHERE work_year=2024 and remote_ratio = 100 GROUP BY experience_level
		)a
		INNER JOIN
		(
		SELECT  experience_level, COUNT(experience_level) AS total_2024 FROM salary WHERE work_year=2024 GROUP BY experience_level
		)b ON a.experience_level= b.experience_level
  ) 
  SELECT * FROM t1 INNER JOIN t2 ON t1.experience_level = t2.experience_level;
  
  
  /* AS a Compensation specialist at a Fortune 500 company, you're tasked WITH analyzing salary trends over time.
  Your objective is to calculate the average salary increase percentage for each experience level and job title between 
  the years 2023 and 2024, helping the company stay competitive IN the talent market.
 */
  
  WITH t AS
(
SELECT experience_level, job_title ,work_year, round(AVG(salary_in_usd),2) AS 'average'  FROM salary WHERE work_year IN (2023,2024) GROUP BY experience_level, job_title, work_year
)  
SELECT *,round((((AVG_salary_2024-AVG_salary_2023)/AVG_salary_2023)*100),2)  AS changes
FROM
(
	SELECT 
		experience_level, job_title,
		MAX(CASE WHEN work_year = 2023 THEN average END) AS AVG_salary_2023,
		MAX(CASE WHEN work_year = 2024 THEN average END) AS AVG_salary_2024
	FROM  t GROUP BY experience_level , job_title 
)a WHERE (((AVG_salary_2024-AVG_salary_2023)/AVG_salary_2023)*100)  IS NOT NULL 









 
 
 
 
 