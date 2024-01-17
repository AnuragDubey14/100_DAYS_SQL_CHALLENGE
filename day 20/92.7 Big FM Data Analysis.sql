select * from Stations;
select * from Hosts;
select * from Shows;
select * from Partnerships;
select * from ShowPartnerships;
select * from Awards;
select * from OnlinePresence;


-- 1)Retrieve all stations in the "East" region?
select * from stations where location='East';

-- 2)List all shows hosted by "Vrajesh Hirjee"?
select h.HostID,
h.HostName,
s.ShowName 
from hosts h left join shows s on h.HostID=s.HostID
where HostName="Vrajesh Hirjee";


-- 3)Count the number of awards each show has won?
select ShowName,Count(AwardID) as 'Number of Awards'
from awards a inner join shows s on a.ShowID=s.ShowID
group by ShowName
order by 2 desc;

-- 4)Find shows that have partnerships with "Spotify"?

select s.ShowName from Partnerships p
inner join ShowPartnerships as sp on p.PartnershipID=sp.PartnershipID
inner join shows s on s.ShowID=sp.ShowID
where PartnerName='Spotify';

-- 5)Retrieve hosts who joined before 2010?

select HostName,JoinDate from hosts
where YEAR(JoinDate)<2010;

-- 6)List the shows and their launch dates in descending order of launch date?

select ShowName,LaunchDate from shows
order by LaunchDate desc;

-- 7)Find the total count of shows for each host?
select HostName,ShowCount from hosts
order by 2 desc;


-- 8)Show the online presence platforms with their links?
select PlatformName,
Link 
from OnlinePresence;

-- 9)Retrieve the stations in the "South" region launched after 2010?
select * from stations
where Location='South' and YEAR(LaunchDate)>2010;


-- 10)Rank hosts based on the number of shows they have hosted?

select HostName,
ShowCount,
dense_rank() over(order by ShowCount desc) as host_rank from hosts;