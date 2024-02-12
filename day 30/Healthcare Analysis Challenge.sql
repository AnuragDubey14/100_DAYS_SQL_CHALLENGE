use practice;

------------------------
CREATE TABLE Patients (
patient_id INT PRIMARY KEY,
patient_name VARCHAR(50),
age INT,
gender VARCHAR(10),
city VARCHAR(50)
);

------------------------

CREATE TABLE Symptoms (
symptom_id INT PRIMARY KEY,
symptom_name VARCHAR(50)
);

------------------------
CREATE TABLE Diagnoses (
diagnosis_id INT PRIMARY KEY,
diagnosis_name VARCHAR(50)
);

------------------------
CREATE TABLE Visits (
visit_id INT PRIMARY KEY,
patient_id INT,
symptom_id INT,
diagnosis_id INT,
visit_date DATE,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (symptom_id) REFERENCES Symptoms(symptom_id),
FOREIGN KEY (diagnosis_id) REFERENCES Diagnoses(diagnosis_id)
);


-- Insert data into Patients table
INSERT INTO Patients (patient_id, patient_name, age, gender, city)
VALUES
(1, 'John Smith', 45, 'Male', 'Seattle'),
(2, 'Jane Doe', 32, 'Female', 'Miami'),
(3, 'Mike Johnson', 50, 'Male', 'Seattle'),
(4, 'Lisa Jones', 28, 'Female', 'Miami'),
(5, 'David Kim', 60, 'Male', 'Chicago');


-- Insert data into Symptoms table
INSERT INTO Symptoms (symptom_id, symptom_name)
VALUES
(1, 'Fever'),
(2, 'Cough'),
(3, 'Difficulty Breathing'),
(4, 'Fatigue'),
(5, 'Headache');


-- Insert data into Diagnoses table
INSERT INTO Diagnoses (diagnosis_id, diagnosis_name)
VALUES
(1, 'Common Cold'),
(2, 'Influenza'),
(3, 'Pneumonia'),
(4, 'Bronchitis'),
(5, 'COVID-19');


-- Insert data into Visits table
INSERT INTO Visits (visit_id, patient_id, symptom_id, diagnosis_id, visit_date)
VALUES
(1, 1, 1, 2, '2022-01-01'),
(2, 2, 2, 1, '2022-01-02'),
(3, 3, 3, 3, '2022-01-02'),
(4, 4, 1, 4, '2022-01-03'),
(5, 5, 2, 5, '2022-01-03'),
(6, 1, 4, 1, '2022-05-13'),
(7, 3, 4, 1, '2022-05-20'),
(8, 3, 2, 1, '2022-05-20'),
(9, 2, 1, 4, '2022-08-19'),
(10, 1, 2, 5, '2022-12-01');


-----------------------------------
select * from Patients;
select * from Visits;
select * from Symptoms;
select * from Diagnoses;

-------------------------------------

-- 1. Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
select p.patient_name,p.age,p.city,p.gender,
v.visit_date from Visits v inner join Diagnoses d on
d.diagnosis_id=v.diagnosis_id and d.diagnosis_name='COVID-19'
inner join Patients p on p.patient_id=v.patient_id;



-- 2. Write a SQL query to retrieve the number of visits made by each patient, ordered by the number of visits in descending order.
select p.patient_name,
COUNT(v.visit_id) as 'Number of Visit'
from Visits v inner join Patients p on v.patient_id=p.patient_id
group by p.patient_name
order by 2 desc; 



-- 3. Write a SQL query to calculate the average age of patients who have been diagnosed with Pneumonia.
select AVG(p.age) as 'Average age of Pneumonia patients'
from Patients p inner join Visits v on p.patient_id=v.patient_id
inner join Diagnoses d on d.diagnosis_id=v.diagnosis_id and d.diagnosis_name='Pneumonia';



-- 4. Write a SQL query to retrieve the top 3 most common symptoms among all visits.
select TOP 3 s.symptom_name, COUNT(v.visit_id) as 'Number of Visit'
from Visits v inner join Symptoms s on s.symptom_id=v.symptom_id
group by s.symptom_name
order by 2 desc;


-- 5. Write a SQL query to retrieve the patient who has the highest number of different symptoms reported.
select top 1 p.patient_name,COUNT(s.symptom_id) as 'Number of Sympotms Reported'
from Patients p inner join Visits v on p.patient_id=v.patient_id
inner join Symptoms s on s.symptom_id=v.symptom_id
group by p.patient_name
order by 2 desc;


--6.Write a SQL query to calculate the percentage of patients who have been diagnosed with COVID-19 out of the total number of patients.
select
(COUNT(CASE WHEN d.diagnosis_name = 'COVID-19' THEN 1 END)* 100.0 / COUNT(*) ) AS Covid_patient_percentage
from Patients p inner join Visits v on p.patient_id=v.patient_id
inner join Diagnoses d on d.diagnosis_id=v.diagnosis_id 



-- 7. Write a SQL query to retrieve the top 5 cities with the highest number of visits, along with the count of visits in each city.
select Top 5 p.city,count(v.visit_id) as 'Number of Visits'
from Visits v inner join Patients p on v.patient_id=p.patient_id
group by p.city
order by 2 desc;


--8. Write a SQL query to find the patient who has the highest number of visits in a single day, along with the corresponding visit date.
select TOP 1 v.visit_date,p.patient_name,
count(v.visit_id) as 'Number of visit'
from Visits v inner join Patients p on v.patient_id=p.patient_id
group by v.visit_date,p.patient_name
order by 3 desc;


-- 9. Write a SQL query to retrieve the average age of patients for each diagnosis, ordered by the average age in descending order.
select d.diagnosis_name,AVG(p.age) as average_age
from Patients p inner join Visits v on p.patient_id=v.patient_id
inner join Diagnoses d on v.diagnosis_id=d.diagnosis_id
group by d.diagnosis_name 
order by 2 desc;


-- 10. Write a SQL query to calculate the cumulative count of visits over time, ordered by the visit date.
select visit_date,
COUNT(visit_id) over(order by visit_date) as 'Cummulative Count of Visits over time'
from Visits;