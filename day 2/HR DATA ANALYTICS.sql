-- DAY 2 OF 100 DAY OF SQL CHALLENGE

-- -------------------------HR DATA ANALYTICS ------------

-- ----------------------LETS CREATE NEW DATABASE HR-------

create database Hr;

-- SELECT HR DATABASE TO USE FURTHER-----------------------
USE HR;

-- I HAVE A DATASET NAMELY AS HR DATA SO LETS CREATE TABLE HR DATA AND INSERT DATA INTO HR DATA TABLE

-- RETRIEVE ENTIRE DATA FROM HR DATA TABLE ----------------------
select * from hrdata;

-- Q1. PRINT EMPLOYEE COUNT IN THE TABLE 

select sum(employee_count) as 'employee count' from hrdata;

-- Q2. Employee count for each education category

select education, sum(employee_count) as 'Employee_count' from hrdata
group by education;

-- Q3. Count of Employee of each department

select department, sum(employee_count) as 'Employee_count' from hrdata
group by department;

-- Q4. count of employee for each education field

select education_field, sum(employee_count) as 'Employee_count' from hrdata
group by education_field;

-- Q5. Attrition count

select count(attrition) as 'Attrition Count' from hrdata
where attrition ='yes';

-- Q6. Attrition rate

 select  round(((select count(attrition) from hrdata where attrition='Yes')/
 sum(employee_count))*100,2) as 'Attrition rate' from hrdata;

-- Q7. Attriton rate for sales department

  select  round(((select count(attrition) from hrdata where attrition='Yes' and 
  department='Sales' )/
 sum(employee_count))*100,2) as 'Attrition rate' from hrdata
 where department='Sales';

-- Q8. Active employee

select sum(employee_count) - (select count(attrition) from hrdata where attrition='yes')
as "active employee" from hrdata;

-- Q9. Active Male Employee

select sum(employee_count) - (select count(attrition) from hrdata where attrition='yes' and
gender='Male')
as "active male employee" from hrdata where gender='Male';

-- Q10. Active Female Employee

select sum(employee_count) - (select count(attrition) from hrdata where attrition='yes' and
gender='Female')
as "active Female employee" from hrdata where gender='Female';

