create database big_fm;
use big_fm;


CREATE TABLE Stations (
	StationID INT PRIMARY KEY,
	StationName VARCHAR(255),
	Location VARCHAR(255),
	Frequency DECIMAL(5,2),
	LaunchDate DATE
);
                            
                            
CREATE TABLE Hosts (
	HostID INT PRIMARY KEY,
	HostName VARCHAR(255),
	ShowCount INT,
	JoinDate DATE
);
                            
                            
CREATE TABLE Shows (
	ShowID INT PRIMARY KEY,
	ShowName VARCHAR(255),
	HostID INT, -- Foreign key referencing Hosts table
	StationID INT, -- Foreign key referencing Stations table
	LaunchDate DATE,
	CONSTRAINT fk_Shows_HostID FOREIGN KEY (HostID) REFERENCES Hosts(HostID),
	CONSTRAINT fk_Shows_StationID FOREIGN KEY (StationID) REFERENCES Stations(StationID)
);
                            
                            
CREATE TABLE Partnerships (
	PartnershipID INT PRIMARY KEY,
	PartnerName VARCHAR(255),
	PartnershipType VARCHAR(100),
	StartDate DATE,
	EndDate DATE
);
                            
                            
CREATE TABLE ShowPartnerships (
	ShowID INT,
	PartnershipID INT,
	CONSTRAINT fk_ShowPartnerships_ShowID FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
	CONSTRAINT fk_ShowPartnerships_PartnershipID FOREIGN KEY (PartnershipID) REFERENCES Partnerships(PartnershipID)
);

                            
CREATE TABLE Awards (
	AwardID INT PRIMARY KEY,
	AwardName VARCHAR(255),
	Year INT,
	ShowID INT, -- Foreign key referencing Shows table
	CONSTRAINT fk_Awards_ShowID FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

                            
CREATE TABLE OnlinePresence (
	PresenceID INT PRIMARY KEY,
	PlatformName VARCHAR(255),
	Link VARCHAR(255),
	LaunchDate DATE
);

                            
                            
INSERT INTO Stations (StationID, StationName, Location, Frequency, LaunchDate)
VALUES
	(1, 'Asansol', 'East', 92.7, '2006-09-01'),
	(2, 'Bhubaneswar', 'East', 92.7, '2006-09-01'),
	(3, 'Guwahati', 'East', 92.7, '2006-09-01'),
	(4, 'Jamshedpur', 'East', 92.7, '2006-09-01'),
	(5, 'Kolkata', 'East', 92.7, '2006-09-01'),
	(6, 'Ranchi', 'East', 92.7, '2006-09-01'),
	(7, 'Rourkela', 'East', 92.7, '2006-09-01'),
	(8, 'Solapur', 'West', 92.7, '2006-09-01'),
	(9, 'Nashik', 'West', 92.7, '2006-09-01'),
	(10, 'Pune', 'West', 92.7, '2006-09-01'),
	(11, 'Vadodara', 'West', 92.7, '2006-09-01'),
	(12, 'Bhopal', 'West', 92.7, '2006-09-01'),
	(13, 'Gwalior', 'West', 92.7, '2006-09-01'),
	(14, 'Indore', 'West', 92.7, '2006-09-01'),
	(15, 'Mumbai', 'West', 92.7, '2006-09-01'),
	(16, 'Rajkot', 'West', 92.7, '2006-09-01'),
	(17, 'Srinagar', 'North 1', 92.7, '2006-09-01'),
	(18, 'Jammu', 'North 1', 92.7, '2006-09-01'),
	(19, 'Shimla', 'North 1', 92.7, '2006-09-01'),
	(20, 'Jhansi', 'North 2', 92.7, '2006-09-01'),
	(21, 'Allahabad', 'North 2', 92.7, '2006-09-01'),
	(22, 'Aligarh', 'North 2', 92.7, '2006-09-01'),
	(23, 'Bareilly', 'North 2', 92.7, '2006-09-01'),
	(24, 'Agra', 'North 2', 92.7, '2006-09-01'),
	(25, 'Ajmer', 'North 2', 92.7, '2006-09-01'),
	(26, 'Delhi', 'North 2', 92.7, '2006-09-01'),
	(27, 'Patiala', 'North 2', 92.7, '2006-09-01'),
	(28, 'Chandigarh', 'North 2', 92.7, '2006-09-01'),
	(29, 'Hisar', 'North 2', 92.7, '2006-09-01'),
	(30, 'Shillong', 'North 2', 92.7, '2006-09-01'),
	(31, 'Agartala', 'North 2', 92.7, '2006-09-01'),
	(32, 'Itanagar', 'North 2', 92.7, '2006-09-01'),
	(33, 'Aizawl', 'North 2', 92.7, '2006-09-01'),
	(34, 'Nagpur', 'South', 92.7, '2006-09-01'),
	(35, 'Aurangabad', 'South', 92.7, '2006-09-01'),
	(36, 'Ahmednagar', 'South', 92.7, '2006-09-01'),
	(37, 'Kolhapur', 'South', 92.7, '2006-09-01'),
	(38, 'Mangalore', 'South', 92.7, '2006-09-01'),
	(39, 'Mysore', 'South', 92.7, '2006-09-01'),
	(40, 'Hyderabad', 'South', 92.7, '2006-09-01'),
	(41, 'Bangalore', 'South', 92.7, '2006-09-01'),
	(42, 'Chennai', 'South', 92.7, '2006-09-01'),
	(43, 'Trivandrum', 'South', 92.7, '2006-09-01'),
	(44, 'Pondicherry', 'South', 92.7, '2006-09-01'),
	(45, 'Lucknow', 'South', 92.7, '2006-09-01'),
	(46, 'Gorakhpur', 'South', 92.7, '2006-09-01'),
	(47, 'Varanasi', 'South', 92.7, '2006-09-01'),
	(48, 'Patna', 'South', 92.7, '2006-09-01'),
	(49, 'Muzaffarpur', 'South', 92.7, '2006-09-01'),
	(50, 'Kanpur', 'South', 92.7, '2006-09-01'),
	(51, 'Itanagar', 'New', 92.7, '2006-09-01'),
	(52, 'Kota', 'New', 92.7, '2006-09-01'),
	(53, 'Udaipur', 'New', 92.7, '2006-09-01'),
	(54, 'Shimla', 'New', 92.7, '2006-09-01'),
	(55, 'Delhi', 'New', 92.7, '2006-09-01'),
	(56, 'Tirupati', 'New', 92.7, '2006-09-01'),
	(57, 'Patna', 'New', 92.7, '2006-09-01'),
	(58, 'Varanasi', 'New', 92.7, '2006-09-01');

                            
                            
INSERT INTO Hosts (HostID, HostName, ShowCount, JoinDate)
VALUES
	(1, 'Vrajesh Hirjee', 2, '2006-09-01'),
	(2, 'Annu Kapoor', 3, '2006-09-01'),
	(3, 'Neelesh Misra', 2, '2006-09-01'),
	(4, 'Bhawana Somaaya', 1, '2006-09-01'),
	(5, 'Kamini Khanna', 1, '2006-09-01'),
	(6, 'Richa Anirudh', 2, '2006-09-01'),
	(7, 'RJ Khaas Koushik', 1, '2006-09-01'),
	(8, 'RJ Pat Pat Pataki Shruti', 2, '2006-09-01'),
	(9, 'RJ Rapid Rashmi', 3, '2006-09-01'),
	(10, 'RJ Rani', 1, '2006-09-01'),
	(11, 'RJ Khurafati Nitin', 2, '2006-09-01'),
	(12, 'RJ Sangram', 1, '2006-09-01'),
	(13, 'RJ Abhilash', 1, '2006-09-01');
	
                            
INSERT INTO Shows (ShowID, ShowName, HostID, StationID, LaunchDate)
VALUES
	(1, 'Suhaana Safar with Annu Kapoor', 2, 1, '2006-09-01'), -- Assuming HostID 2
	(2, 'Yaadon Ka Idiot Box with Neelesh Misra', 3, 2, '2006-09-01'),
	(3, 'Dhun Badal Ke Toh Dekho Season 1 (with Vidya Balan)', 4, 3, '2019-01-01'),
	(4, 'Dhun Badal Ke Toh Dekho Season 2 (with Sadhguru)', 5, 4, '2019-01-01'),
	(5, '21 Din Wellness In with Sunil Shetty', 1, 6, '2023-01-01'), -- Assuming HostID 1
	(6, 'Green Ganesha', 6, 7, '2023-01-01');
                            
                            
                            
                            
INSERT INTO Partnerships (PartnershipID, PartnerName, PartnershipType, StartDate, EndDate)
VALUES
	(1, 'Spotify', 'Music Streaming', '2006-09-01', NULL),
	(2, 'Gaana', 'Music Streaming', '2006-09-01', NULL),
	(3, 'JioSaavn', 'Music Streaming', '2006-09-01', NULL),
	(4, 'Hungama Music', 'Music Streaming', '2021-10-01', NULL),
	(5, 'Big Living Shop', 'E-commerce', '2023-01-01', NULL),
	(6, 'Blue Mic', 'Independent Artists Platform', '2021-10-01', NULL);

                            
                            
INSERT INTO ShowPartnerships (ShowID, PartnershipID)
VALUES
	(1, 1), -- ShowID 1 associated with PartnershipID 1
	(2, 2), -- ShowID 2 associated with PartnershipID 2
	(3, 3), -- ShowID 3 associated with PartnershipID 3
	(4, 4), -- ShowID 4 associated with PartnershipID 4
	(5, 5), -- ShowID 5 associated with PartnershipID 5
	(6, 6); -- ShowID 6 associated with PartnershipID 6
   
                                
                            
INSERT INTO Awards (AwardID, AwardName, Year, ShowID)
VALUES
	(1, 'IRF Gold', 2019, 1), -- Award for ShowID 1 in the year 2019
	(2, 'IRF Gold', 2018, 2), -- Award for ShowID 2 in the year 2018
	(3, 'ABBY', 2017, 3), -- Award for ShowID 3 in the year 2017
	(4, 'NYF Radio Award', 2014, 4), -- Award for ShowID 4 in the year 2014
	(5, 'Indian Radio Forum Gold', 2019, 5), -- Award for ShowID 5 in the year 2019
	(6, 'Indian Radio Forum Gold', 2018, 6); -- Award for ShowID 6 in the year 2018
	
                           
INSERT INTO OnlinePresence (PresenceID, PlatformName, Link, LaunchDate)
VALUES
	(1, 'Spotify', 'https://open.spotify.com/bigfm', '2020-01-01'),
	(2, 'Gaana', 'https://gaana.com/bigfm', '2020-01-01'),
	(3, 'JioSaavn', 'https://www.jiosaavn.com/bigfm', '2020-01-01'),
	(4, 'Hungama Music', 'https://www.hungama.com/bigfm', '2021-10-01'),
	(5, 'BIG Living Shop', 'https://bigliving.shop', '2023-01-01');                  

