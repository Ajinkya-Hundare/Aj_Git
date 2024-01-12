
-- --------------------------------------Analyzing Census 2011 data-----------------------------------------------------
drop database census;
create database census;
use census;

-- Total number of record in a dataset
select count(*) from census;

-- Distinct State that is present in our data
select distinct state_name from census;

-- Count the number of district present in each state
select State_name,count(District_name) as "Total number of District"
from census group by State_name;

-- Total population in 2011
select sum(population) as Total_Popululation2011 from census;

-- Average population in each state
select state_name,avg(population) as Avg_Population 
from census 
group by state_name;

-- Top 3 states with most number of population
select state_name,population from census as c
where 3 >= (select count(distinct(Population)) from census d 
where c.population<=d.population) 
order by population desc;

-- Alternate way of finding top 3 highest populated state 
SELECT STATE_NAME,POPULATION 
FROM CENSUS 
ORDER BY POPULATION DESC 
LIMIT 3;

-- State that have population more than average population
select State_name , Population,(select avg(population) from census) 
from census where population > 
(select avg(population) as Avg_population from census)
order by population desc;

-- literate percentage of each states
SELECT state_name, ROUND((SUM(Literate) / SUM(Population) * 100), 2) AS Literate_percentage
FROM census
GROUP BY state_name;


-- Top and bottom 3 state in literacy rate
select * from (select state_name,avg(literate) as Avg_Literate
from census
group by state_name
order by avg_literate desc limit 3) as a
union
select * from (select state_name,avg(literate) as Avg_Literate
from census
group by state_name
order by avg_literate asc limit 3) as b;

-- percentage of male literate in each state

SELECT distinct state_name, SUM(Male) AS Total_Male, ROUND((SUM(Literate) / SUM(Male) * 100), 2) AS Literacy_percentage
FROM census
GROUP BY state_name;

select * from census;

-- percentage of female of literate in each state

SELECT distinct state_name, SUM(Female) AS Total_Female, ROUND((SUM(Literate) / SUM(Female) * 100), 2) AS Literacy_percentage
FROM census
GROUP BY state_name;


-- Top 5 states with the highest number of male workers
SELECT state_name, SUM(male_workers) AS Total_Male_Workers
FROM census
GROUP BY state_name
ORDER BY Total_Male_Workers DESC
LIMIT 5;


-- top 5 states where female worker are maximum
select distinct state_name,Female_workers from census order by Female_workers desc limit 5;

-- Top 3 hindus dominant states according to census 2011
select state_name,sum(hindus) as TotalHinduspresent 
from census 
group by state_name 
order by TotalHinduspresent desc 
limit 3;

-- Top 3 muslims dominant states 
select state_name,sum(muslims) as TotalMuslimspresent 
from census 
group by state_name 
order by Totalmuslimspresent desc 
limit 3;

-- Check percentage of people available in each state according to age group 
 
 SELECT 
    state_name,
    (SUM(age_group_0_29) / SUM(SUM(age_group_0_29)) OVER ()) * 100 AS 'Age between 0 to 29',
    (SUM(age_group_30_49) / SUM(SUM(age_group_30_49)) OVER ()) * 100 AS 'Age between 30 to 49',
    (SUM(age_group_50) / SUM(SUM(age_group_50)) OVER ()) * 100 AS 'Age 50'
FROM census 
GROUP BY state_name;

 
-- regional diversity percentage of each state  
 SELECT 
    state_name,
    ROUND((SUM(hindus) / SUM(Population) * 100), 2) AS 'Hindus percentage',
    ROUND((SUM(muslims) / SUM(Population) * 100), 2) AS 'Muslims percentage',
    ROUND((SUM(sikhs) / SUM(Population) * 100), 2) AS 'Sikhs percentage',
    ROUND((SUM(christians) / SUM(Population) * 100), 2) AS 'Christians percentage',
    ROUND((SUM(Buddhists) / SUM(Population) * 100), 2) AS 'Buddhists percentage',
    ROUND((SUM(jains) / SUM(Population) * 100), 2) AS 'Jains percentage'
FROM census 
GROUP BY state_name;





