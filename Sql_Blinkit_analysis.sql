CREATE TABLE bgdata (
    item_fat_content VARCHAR(50),
    item_identifier VARCHAR(50),
    item_type VARCHAR(100),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(50),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(50),
    outlet_type VARCHAR(100),
    item_visibility float,
    item_weight float,
    sales float,
    rating float
);

-- Easy Questions
-- 1. Retrieve all records where the "item_fat_content" is "Low Fat".

select * from bgdata 
where item_fat_content = 'Low Fat'

-- 2. Find the total number of unique "item_type" values.

select  count (distinct item_type) as unique_item_type  from bgdata

-- 3. List all outlets established after the year 2010.

select * from bgdata 
where outlet_establishment_year > 2010

-- 4. Retrieve the average weight of items.

select avg(item_weight) as avg_weight from bgdata 

-- 5. Find the maximum sales recorded in the dataset.

select max(sales) as max_sales from  bgdata 


-- 6. Count the total number of records in the table.

select count(item_identifier) as Total_records from bgdata

-- 7. List all unique values in the "outlet_size" column.
	
select distinct(outlet_size) as unique_outlet  from bgdata

-- 8. Retrieve items with "rating" equal to 5.
	
select * from bgdata where rating = 5

-- 9. Find the minimum visibility value.

select min(item_visibility) as min_visibility from bgdata   

-- 10. Get the total weight of all items.

select sum(item_weight) as total_weight  from bgdata 

-- Medium Questions
-- 11. Calculate the average sales for "Supermarket Type1" outlets.

select avg(sales) as avg_sales  from bgdata
where outlet_type = 'Supermarket_Type1'

-- 12. Identify the top 5 items with the highest sales.

select item_identifier, sales from bgdata
order by sales desc 
limit 5

-- 13. Find the total sales for items with "item_visibility" greater than 0.05.

select sum(sales) as total_sales  from bgdata
where item_visibility > 0.05

-- 14. Determine the number of outlets by their "outlet_location_type".

select outlet_location_type, count(*) as  outlets_count from bgdata
group by outlet_location_type

-- 15. Find the average visibility for each "item_fat_content" group.

select item_fat_content, avg(item_visibility) as avg_item_visibility from bgdata 
group by item_fat_content

-- 16. Retrieve the details of the outlet with the smallest size.

select * from bgdata where outlet_size = 'Small'

-- 17. Find the most frequent "item_type" in the dataset.

select item_type , count(*) as frequency from bgdata 
group by item_type
order by frequency desc 
limit 1 

-- 18. Calculate the total sales for each "outlet_type".

select outlet_type, sum(sales) as Total_sales from  bgdata
group by outlet_type

-- 19. Identify the outlets with average sales greater than 100.
	
SELECT outlet_identifier, AVG(sales) AS average_sales FROM bgdata 
GROUP BY outlet_identifier HAVING AVG(sales) > 100;
 
-- 20. Retrieve the average rating for each "outlet_size".

select outlet_size, avg(rating) as avg_rating from bgdata 
group by 1

-- Hard Questions
-- 21. Determine the average sales for each "item_type" grouped by "outlet_location_type".

select 	item_type, outlet_location_type, avg(sales) as avg_sales  from bgdata
group by 1,2 
order by 1

-- 22. Find the outlet with the highest total sales.

SELECT outlet_identifier, SUM(sales) AS total_sales
FROM bgdata
GROUP BY outlet_identifier
ORDER BY total_sales DESC
LIMIT 1;

-- 23. Compare the average ratings of "Low Fat" and "Regular" items.

select item_fat_content ,avg(rating) as avg_rating from bgdata 
group by item_fat_content

-- 24. Identify items with sales in the top 10% across all records.

SELECT * FROM bgdata WHERE sales > (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY sales) FROM bgdata);

-- 25. Find the outlet with the most diverse range of "item_type".

SELECT outlet_identifier, COUNT(DISTINCT item_type) AS unique_item_types
FROM bgdata
GROUP BY outlet_identifier
ORDER BY unique_item_types DESC
LIMIT 1;

-- 26. Calculate the median sales for each "outlet_type".

SELECT outlet_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales) AS median_sales
FROM bgdata
GROUP BY outlet_type;

-- 27. Identify the top 3 outlets with the highest average rating.

SELECT outlet_identifier, AVG(rating) AS average_rating
FROM bgdata
GROUP BY outlet_identifier
ORDER BY average_rating DESC
LIMIT 3;

-- 28. Find the correlation between "item_weight" and "sales".

select corr(item_weight, sales) as correlation from bgdata

-- 29. Determine the percentage contribution of each "outlet_type" to total sales.

select outlet_type, (sum(sales))*100.0/(select sum(sales) from bgdata) as percentage_contribution from bgdata 
group by 1

-- 30. Identify the least sold "item_type".

select item_type, sum(sales) as Total_sales from bgdata
group by 1
order by 2
limit 1

-- 31. Calculate the standard deviation of "sales" for "Supermarket Type1".

select stddev(sales) as sale_stddev from bgdata 
where outlet_type = 'Supermarket Type1'

-- 32. Determine the count of "item_type" in each "outlet_size" category.

SELECT outlet_size, item_type, COUNT(*) AS item_count
FROM bgdata
GROUP BY outlet_size, item_type
ORDER BY outlet_size, item_count DESC;

-- 33. Find the outlet with the highest total weight of items sold.

select outlet_identifier, sum(item_weight) as weight  from bgdata 
group by  1 
order by 2 desc
limit 1

-- 34. Retrieve the details of items with both high visibility (> 0.2) and high sales (> 150).

select * from bgdata where item_visibility >0.2 and sales>150

-- 35. Calculate the year-over-year growth in total sales for each outlet.

select outlet_identifier, outlet_establishment_year,sum(sales) as total_sales from bgdata 
group by 1,2 
order by 2
	
-- 36. Identify the top 5 "item_type" by their average rating.
	
select item_type, avg(rating) as avg_rating from bgdata 
group by 1
order by 2 desc
limit 5

-- 37. Calculate the total sales grouped by both "item_fat_content" and "outlet_location_type".

select item_fat_content,outlet_location_type, sum(sales) as totl_sales from bgdata 
group by 1,2 

-- 38. Determine the outlet with the highest average item visibility.

select outlet_identifier, avg(item_visibility) as avg_visibility from bgdata
group by 1 
order by  2 desc 
limit 1

-- 39. Identify the "item_type" with the lowest average weight.

select item_type, avg(item_weight) as avg_weight from bgdata 
group by 1 
order by 2 asc
limit 1

-- 40. Find the total sales for each year grouped by "outlet_type".

select outlet_type,outlet_establishment_year, sum(sales) as total_sales from bgdata
group by 1,2 
order by 1,2 

-- 41. Calculate the average sales per year for each "item_type".

SELECT item_type, outlet_establishment_year, AVG(sales) AS average_sales
FROM bgdata
GROUP BY item_type, outlet_establishment_year
ORDER BY item_type, outlet_establishment_year;

-- 42. Find outlets that have total sales above the overall average.

SELECT outlet_identifier, SUM(sales) AS total_sales
FROM bgdata
GROUP BY outlet_identifier
HAVING SUM(sales) > (SELECT AVG(sales) FROM bgdata);
	
-- 43. Determine the maximum rating given to "Regular" items.

SELECT MAX(rating) AS max_rating FROM bgdata 
WHERE item_fat_content = 'Regular';

-- 44. Compare total sales for "Tier 1" and "Tier 3" locations.

select outlet_location_type , sum(sales) as total_sales from bgdata
where outlet_location_type in('Tier 1', 'Tier 3')
group by 1

-- 45. Retrieve items that are among the bottom 10% by visibility.

SELECT * FROM bgdata WHERE item_visibility < (SELECT PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY item_visibility) FROM bgdata);

-- 46. Calculate the variance of sales for each "outlet_type".

SELECT outlet_type, VARIANCE(sales) AS sales_variance
FROM bgdata
GROUP BY outlet_type;

-- 47. Identify the "outlet_location_type" with the highest standard deviation in sales.

select outlet_location_type , stddev(sales) as stddev_sales from bgdata 
group by 1
order by 2 desc
limit 1

-- 48. Determine the top 3 "item_type" by total sales in "Tier 2" locations.

SELECT item_type, SUM(sales) AS total_sales
FROM bgdata
WHERE outlet_location_type = 'Tier 2'
GROUP BY item_type
ORDER BY total_sales DESC
LIMIT 3;

- 49. Find the average weight of items sold in "High"-sized outlets.
	
SELECT AVG(item_weight) AS average_weight FROM bgdata WHERE outlet_size = 'High';

-- 50. Calculate the total sales contribution of the top 10 items.

SELECT SUM(sales) AS top_10_sales FROM bgdata 
WHERE item_identifier IN (SELECT item_identifier FROM bgdata ORDER BY sales DESC LIMIT 10);



	



select * from bgdata

