use practice;

-- Table to store information about destinations (Maldives and Lakshadweep)
    CREATE TABLE Destination (
        DestinationID INT PRIMARY KEY,
        Name VARCHAR(255),
        GeographicalLocation VARCHAR(255),
        NumberofIslands INT,
        CapitalCity VARCHAR(255),
        TourismRevenue DECIMAL(10,2),
        UnderwaterActivities VARCHAR(1000),
        Accessibility VARCHAR(255),
        Culture VARCHAR(1000),
        Language VARCHAR(255),
        BestTimeToVisit VARCHAR(255),
        VisaRequirements VARCHAR(255),
        Currency VARCHAR(255),
        Transportation VARCHAR(255),
        AverageBudgetPerDay DECIMAL(10,2),
        ShoppingOptions VARCHAR(1000),
        DurationOfStay VARCHAR(255),
        UniqueFeatures VARCHAR(1000)
    );
    
    -- Table to store tourist attractions information
    CREATE TABLE TouristAttractions (
        AttractionID INT PRIMARY KEY,
        DestinationID INT,
        Name VARCHAR(255),
        Description VARCHAR(1000),
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Table to store tourist arrival statistics
    CREATE TABLE TouristArrivals (
        ArrivalID INT PRIMARY KEY,
        DestinationID INT,
        Year INT,
        NumberofVisitors INT,
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Table to store information about the significance of Indian tourists
    CREATE TABLE IndianTourists (
        IndianTouristID INT PRIMARY KEY,
        DestinationID INT,
        Year INT,
        NumberofTourists INT,
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Inserting values into Destination table
    INSERT INTO Destination (DestinationID, Name, GeographicalLocation, NumberofIslands, CapitalCity, TourismRevenue, UnderwaterActivities, Accessibility, Culture, Language, BestTimeToVisit, VisaRequirements, Currency, Transportation, AverageBudgetPerDay, ShoppingOptions, DurationOfStay, UniqueFeatures)
    VALUES
    (1, 'Maldives', 'Indian Ocean, southwest of Sri Lanka', 1000, 'Malé', 11257.00, 'Diving with whale and sharks, Vibrant Coral Reefs, Banana Reef dives', 'Well-connected with international flights', 'Influenced by South Asian, Middle Eastern, and African cultures', 'Dhivehi', 'November to March (dry season)', '30-day visa on arrival', 'Maldivian Rufiyaa (MVR)', 'Seaplanes, speedboats, ferries', 17500.00, 'Vibrant markets in Male like Male Local Market and Majeedhee Magu', 'Ideal for 7-10 days', 'Overwater bungalows, extensive luxury resorts'),
    
    (2, 'Lakshadweep', 'Arabian Sea, off the southwest coast of India', 36, 'Kavaratti', 65.00, 'Snorkeling at Minicoy, Coral Reefs at Kadmat Island, Diving at Bangaram Atoll', 'Limited connectivity, primarily accessible by ships', 'Blend of Indian and Arabic influences', 'Malayalam, English', 'October to mid-May (avoiding monsoon)', 'No visa required for Indian tourists; foreign tourists need a visa', 'Indian Rupee (INR)', 'Limited to ships, boats, and ferries', 7300.00, 'Limited shopping options, with some markets like Agatti Island, Kavaratti', 'Ideal for 5-6 days', 'Less-commercialised atmosphere, pristine natural beauty');
    
    
    -- Inserting values into TouristAttractions table
    INSERT INTO TouristAttractions (AttractionID, DestinationID, Name, Description)
    VALUES
        (1, 1, 'Male', 'The vibrant capital is a gateway with colorful architectures and a hub for water sports.'),
        (2, 1, 'Maafushi', 'Known for its breathtaking beaches and versatile activities like snorkelling and sunbathing.'),
        (3, 1, 'Hithadhoo', 'A picturesque island in Addu City, celebrated globally for its natural reserves.'),
        (4, 2, 'Minicoy Island', 'A beach lover’s haven with numerous lagoons enhancing its charm.'),
        (5, 2, 'Kavaratti', 'The capital city is surrounded by abundant lagoons, offering scuba diving and aquarium tours.'),
        (6, 2, 'Kadmat Island', 'Famed for its beautiful coral reefs, an ideal spot for snorkelling and marine reserve tours.');
    
    
    -- Insert values for TouristArrivals table
    INSERT INTO TouristArrivals (ArrivalID, DestinationID, Year, NumberofVisitors) VALUES
    (1, 1, 2013, 4784),
    (2, 1, 2014, 7315),
    (3, 1, 2015, 17241),
    (4, 1, 2016, 8716),
    (5, 1, 2017, 6620),
    (6, 1, 2018, 10435),
    (7, 1, 2019, 6985),
    (8, 1, 2020, 3462),
    (9, 1, 2021, 13500),
    (10, 1, 2022, 22800),
    
    -- Values for Lakshadweep
    (11, 2, 2013, 1000),
    (12, 2, 2014, 2000),
    (13, 2, 2015, 4000),
    (14, 2, 2016, 2500),
    (15, 2, 2017, 1800),
    (16, 2, 2018, 3000),
    (17, 2, 2019, 2200),
    (18, 2, 2020, 1200),
    (19, 2, 2021, 3500),
    (20, 2, 2022, 6000);
    
    
    
    -- Inserting sample values into the IndianTourists table
    INSERT INTO IndianTourists (IndianTouristID, DestinationID, Year, NumberofTourists)
    VALUES
        (1, 1, 2021, 209198),  -- Maldives in 2021
        (2, 2, 2021, 50000),   -- Lakshadweep in 2021 (hypothetical value for illustration)
        (3, 1, 2022, 187000),  -- Maldives in 2022
        (4, 2, 2022, 60000),   -- Lakshadweep in 2022 (hypothetical value for illustration)
        (5, 1, 2023, 209198),  -- Maldives in 2023
        (6, 2, 2023, 100000);  -- Lakshadweep in 2023 (hypothetical value for illustration)



-- Let's see the data 
select * from Destination;
select * from TouristAttractions;
select * from IndianTourists;
select * from TouristArrivals;



-- Let's solve some questions

-- 1)Retrieve the number of visitors to the Maldives in 2019?
select d.Name,t.Year,t.NumberofVisitors 
from TouristArrivals t inner join Destination d
on t.DestinationID=d.DestinationID and d.Name='Maldives' and t.Year=2019;


--  2)Retrieve the average budget per day and best time to visit for destinations with more than 10,000 tourists in 2022?
select Name as DestinationName,
d.AverageBudgetPerDay,t.NumberofVisitors,
d.BestTimeToVisit from Destination d inner join TouristArrivals t on
d.DestinationID=t.DestinationID and t.NumberofVisitors>10000 and t.Year=2022;



-- 3)Retrieve the unique features of tourist attractions in Lakshadweep?
select name,UniqueFeatures from Destination
where Name='Lakshadweep';


-- 4)Retrieve the number of Indian tourists who visited the Maldives in 2021?
select d.Name,i.NumberofTourists,i.Year
from Destination d inner join IndianTourists  i 
on d.DestinationID=i.DestinationID and d.Name='Maldives' and i.Year=2021;



-- 5)Find the destinations with the highest tourism revenue in 2022?
select top 1 d.Name,MAX(d.TourismRevenue) as highest_tourism_revenue
from Destination d inner join TouristArrivals t on d.DestinationID=t.DestinationID and t.Year=2022
group by d.Name
order by 2 desc;



