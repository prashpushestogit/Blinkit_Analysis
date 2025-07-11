CREATE DATABASE blinkitdb;
SHOW DATABASES;
USE blinkitdb;
SHOW TABLES;
Select * FROM blinkit_table;
SELECT COUNT(*) FROM blinkit_table;

SET SQL_SAFE_UPDATES = 0;

#Cleaning and Updating Data

UPDATE blinkit_table
SET `ITEM FAT CONTENT`=
CASE
WHEN `ITEM FAT CONTENT` IN ('lf','LF','low fat') THEN 'Low Fat'
WHEN `ITEM FAT CONTENT` ='reg' THEN 'Regular'
ELSE `ITEM FAT CONTENT`
END;

#KPI REQUIREMENTS

#Total Sales

SELECT SUM(Sales) AS `Total Sales` FROM blinkit_table;

#Average Sales

Select CAST(AVG(Sales) AS DECIMAL(10,0)) AS `Average Sales` FROM blinkit_table;

#Total Items Sold

Select Count(*) AS `Total Items Sold` FROM blinkit_table;

#Average Rating

SELECT AVG(Rating) AS `Average Rating` FROM blinkit_table;


#GRANULAR REQUIREMENTS

#Total Sales by Fat Content

Select `Item Fat Content` , CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_sales
FROM blinkit_table
GROUP BY `Item Fat Content`
ORDER BY `Total_sales` Asc;

#Fat Content by Outlet for Total Sales

SELECT 
`Item Fat Content`,
`Outlet Identifier`,
SUM(Sales) AS Total_Sales
FROM blinkit_table
GROUP BY `Item Fat Content`,`Outlet Identifier`
ORDER BY Total_Sales DESC;

#Percentage of sales by outlet size

SELECT 
  `Outlet Size`,
  SUM(Sales) AS Total_Sales,
  (SUM(Sales)/(SELECT SUM(Sales) FROM blinkit_table))*100 AS Percentage_Sales
FROM blinkit_table
GROUP BY `Outlet Size`
ORDER BY Total_Sales , Percentage_Sales ASC;


