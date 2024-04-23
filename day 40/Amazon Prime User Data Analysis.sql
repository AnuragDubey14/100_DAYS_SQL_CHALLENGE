select * from dbo.amazon_user;

-- Retrieve the names and email addresses of all users.
select Name, Email_Address from dbo.amazon_user;

-- Find the number of users by gender.
select Gender,count(*) as "Total Count" from amazon_user
group by Gender;



-- Get the usernames and membership start dates of users who joined before a certain date.
select Username,Membership_Start_Date from amazon_user
where Membership_Start_Date<'2024-01-10';


-- Count the number of users from a specific location.
select Location,count(*) as "Total Users" from amazon_user
where Location='Carlbury'
group by Location;



-- List the subscription plans along with the count of users subscribed to each plan.
select Subscription_Plan,Count(*) as "Total User" from amazon_user
group by Subscription_Plan;


-- Find the usernames and their corresponding payment information.
select Username,Payment_Information from amazon_user;


-- Identify the renewal status of each user's subscription.
select Name,Renewal_Status from amazon_user;


-- Determine the number of users with a specific purchase history.
select Purchase_History,count(*) as "Total User" from amazon_user 
where Purchase_History='Books'
group by Purchase_History;




-- List the favorite genres of users along with the count of users for each genre.
select  Favorite_Genres,count(*) as "Favourite Genre of Users"from amazon_user
group by Favorite_Genres
order by 2 desc;



-- Retrieve the distinct devices used by users.
select distinct(Devices_Used) as "Devices Used" from amazon_user;



-- Get the engagement metrics for users who gave feedback ratings high.
select Name,Engagement_Metrics from amazon_user where Feedback_Ratings>4;


-- Find the usernames of users who had customer support interactions.
select Username from amazon_user where Customer_Support_Interactions<>0;



-- Identify the users who have memberships ending within a certain date range.
select * from amazon_user where Membership_End_Date<'2025-01-01';



-- List the users who have used a specific device.
select * from amazon_user where Devices_Used='Smartphone'




-- Calculate the total feedback or ratings given by users.
select sum(Feedback_Ratings) as "Total Feedback or Ratings" from amazon_user;



-- Identify the most frequently used device among users.
select top 1 Devices_Used, count(*) as "Frequency of Used" from amazon_user
group by Devices_Used 
order by 2 desc;



-- List the usernames and their corresponding locations for users who are highly engaged.
select Username,Location from amazon_user
where Engagement_Metrics='High';