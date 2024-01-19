--create database
CREATE DATABASE Spotify;

--select database
USE Spotify;


-- import the table using flat file 
-- let's display all the data
select * from Spotify_2023;


-- LET'S SOLVE SOME QUESTIONS  

-- EASY LEVEL

-- 1. Retrieve the names of all tracks released in the year 2021.
SELECT * FROM Spotify_2023 WHERE released_year=2021;

-- 2. Find the total number of streams for all tracks in the dataset
SELECT track_name,streams FROM spotify_2023;

-- 3. List the distinct musical keys present in the dataset.
SELECT DISTINCT(sp.[key]) AS 'musical key' FROM Spotify_2023 AS sp;


-- 4. Count the number of tracks that are present in Spotify playlists.
SELECT COUNT(COALESCE(in_spotify_playlists,0)) AS 'number of tracks in spotify playlist' FROM Spotify_2023;


-- 5. Find the tracks with the highest danceability percentage.
SELECT track_name FROM Spotify_2023
WHERE danceability=(SELECT MAX(danceability) FROM Spotify_2023);


-- INTERMEDIATE LEVEL 

-- 1. Calculate the average energy percentage for tracks released in 2020.
SELECT AVG(energy) AS 'AVERAGE_ENERGY' FROM Spotify_2023
WHERE released_year=2020;

-- 2. Identify the top 5 artists with the most tracks in Spotify charts.
SELECT TOP 5 artist_s_name,SUM(in_spotify_charts) AS'Most_tracks' FROM Spotify_2023
GROUP BY artist_s_name
ORDER BY 2 DESC;

-- 3. List the tracks with the highest instrumentalness percentage.
SELECT track_name FROM Spotify_2023
WHERE instrumentalness=(SELECT MAX(instrumentalness) FROM Spotify_2023); 


-- 4. Find the total number of streams for tracks in both Spotify and Apple Music playlists.
SELECT  track_name,SUM(in_spotify_playlists+in_apple_playlists) AS 'Total Streams' FROM Spotify_2023
GROUP BY track_name
ORDER BY 2 DESC;

--5. Retrieve the tracks released in the month of May.
SELECT track_name FROM Spotify_2023 WHERE released_month=5;

-- ADVANCE LEVEL 

-- 1. Identify the artist(s) with the highest average valence percentage.
WITH artist_with_high_avg_valence AS(
SELECT artist_s_name ,AVG(valence) AS Average_valence,
DENSE_RANK() OVER(ORDER BY AVG(valence) DESC) as rnk FROM Spotify_2023
GROUP BY artist_s_name)

SELECT artist_s_name,Average_valence AS 'Average Valence'
from artist_with_high_avg_valence WHERE rnk=1; 

-- 2. List the top 10 tracks with the most streams in Spotify charts.
SELECT TOP 10 track_name, streams
FROM Spotify_2023
ORDER BY in_spotify_charts DESC;


-- 3. Find the tracks with danceability percentage above 80% and energy percentage below 60%
SELECT track_name FROM Spotify_2023
WHERE danceability>80 AND energy<60;

-- 4. Calculate the average acousticness percentage for tracks in Deezer charts.
SELECT AVG(acousticness) AS average_acousticness
FROM Spotify_2023
WHERE in_deezer_charts IS NOT NULL;

--5. Retrieve the tracks released on a weekend (Saturday or Sunday).
SELECT track_name
FROM Spotify_2023
WHERE DATEPART(dw, CAST(CONCAT(released_year, '-', released_month, '-', released_day) AS DATE)) IN (1, 7);



-- EXPERT LEVEL

-- 1. Identify the artist(s) with the highest total streams across all their tracks.
WITH cte AS(
SELECT artist_s_name,sum(streams) AS Total_streams,
DENSE_RANK() OVER(ORDER BY SUM(streams) DESC) AS rnk
FROM Spotify_2023
GROUP BY artist_s_name)
SELECT artist_s_name,Total_streams 
FROM cte
WHERE rnk=1;

-- 2. Find the tracks that are present in both Apple Music and Deezer charts.
SELECT track_name FROM Spotify_2023
WHERE
in_apple_charts IS NOT NULL AND in_deezer_charts IS NOT NULL;

-- 3. Calculate the median danceability percentage for all tracks.
WITH OrderedDanceability AS (
    SELECT
        track_name,
        danceability,
        ROW_NUMBER() OVER (ORDER BY danceability) AS RowAsc,
        COUNT(*) OVER () AS TotalRows
    FROM Spotify_2023
)
SELECT
    track_name,
    danceability AS MedianDanceability
	,RowAsc
FROM OrderedDanceability
WHERE RowAsc = (TotalRows + 1) / 2;


-- 4. Identify the tracks with the highest liveness percentage in Spotify playlists.
SELECT
    track_name,
    liveness AS HighestLivenessPercentage
FROM Spotify_2023
WHERE liveness = (SELECT MAX(liveness) FROM Spotify_2023);

-- 5. Find the tracks with the highest speechiness percentage in Shazam charts.
SELECT
    track_name,
    speechiness AS HighestSpeechinessPercentage
FROM Spotify_2023
WHERE speechiness = (SELECT MAX(speechiness) FROM Spotify_2023) AND in_shazam_charts IS NOT NULL;

