-- Creating a Database to store out dataset
CREATE DATABASE hotel_resv;

-- Using our created Database for further workings
USE hotel_resv;

-- Checking all columns of the dataset
SELECT * FROM hotel_resv_data;

-- Checking the datatypes of each column
DESC hotel_resv_data;

-- Updating arrival_date column to date format using str_to_date function
UPDATE hotel_resv.hotel_resv_data
SET arrival_date = str_to_date(arrival_date, '%d-%m-%Y');

-- ANALYSIS

-- 1. What is the total number of reservations in the dataset?

SELECT COUNT(DISTINCT booking_id) as number_of_reservations
FROM hotel_resv_data;

-- 2. Which meal plan is the most popular among guests?

SELECT type_of_meal_plan, COUNT(booking_id) as Number_of_reservations
FROM hotel_resv_data
GROUP BY type_of_meal_plan
ORDER BY Number_of_reservations DESC
LIMIT 1;

-- 3. What is the average price per room for reservations involving children?

SELECT ROUND(AVG(avg_price_per_room),2) as Avg_price_involving_children
FROM hotel_resv_data
WHERE no_of_children > 0;

-- 4. How many reservations were made for the year 20XX (replace XX with the desired year)?

SELECT EXTRACT(YEAR FROM arrival_date) as year, 
COUNT(*) as Number_of_reservations
FROM hotel_resv_data
GROUP BY EXTRACT(YEAR FROM arrival_date);

-- 5. What is the most commonly booked room type?

SELECT room_type_reserved, COUNT(*) as Number_of_reservations
FROM hotel_resv_data
GROUP BY room_type_reserved
ORDER BY Number_of_reservations DESC
LIMIT 1;

-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?

SELECT COUNT(*) as Reservations_on_weekend
FROM hotel_resv_data
WHERE no_of_weekend_nights > 0;

-- 7. What is the highest and lowest lead time for reservations?

SELECT MAX(lead_time) as Highest_lead_time, 
MIN(lead_time) as Lowest_lead_time
FROM hotel_resv_data;

-- 8. What is the most common market segment type for reservations?

SELECT market_segment_type, COUNT(*) as Number_of_reservations
FROM hotel_resv_data
GROUP BY market_segment_type
ORDER BY Number_of_reservations DESC
LIMIT 1;

-- 9. How many reservations have a booking status of "Confirmed"?

SELECT COUNT(booking_status) as Confirmed_bookings
FROM hotel_resv_data
WHERE booking_status = 'Not_Canceled';

-- 10. What is the total number of adults and children across all reservations?

SELECT SUM(no_of_adults) as Number_of_adults, 
SUM(no_of_children) as Number_of_children
FROM hotel_resv_data;

SELECT * FROM hotel_resv_data;

-- 11. What is the average number of weekend nights for reservations involving children?

SELECT ROUND(AVG(no_of_weekend_nights),0) as Avg_weeknd_nights_involv_children
FROM hotel_resv_data
WHERE no_of_children > 0;

-- 12. How many reservations were made in each month of the year?

SELECT EXTRACT(month from arrival_date) as month, 
EXTRACT(year from arrival_date) as year, 
COUNT(booking_id) as Number_of_reservations
FROM hotel_resv_data
GROUP BY month, year
ORDER BY year, month;

-- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?

SELECT room_type_reserved, 
ROUND(AVG(no_of_weekend_nights),0) as Avg_nights_weekend,
ROUND(AVG(no_of_week_nights),0) as Avg_nights_weekday,
ROUND(AVG(no_of_weekend_nights + no_of_week_nights),0) as Overall_avg
FROM hotel_resv_data
GROUP BY room_type_reserved
ORDER BY room_type_reserved;

-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?

SELECT room_type_reserved, COUNT(*) as Number_of_reservations, 
ROUND(AVG(avg_price_per_room),2) as Average_price_per_room
FROM hotel_resv_data
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY Number_of_reservations DESC
LIMIT 1;

-- 15. Find the market segment type that generates the highest average price per room.

SELECT market_segment_type, 
ROUND(AVG(avg_price_per_room),2) as Highest_average_price_per_room
FROM hotel_resv_data
GROUP BY market_segment_type
ORDER BY Highest_average_price_per_room DESC
LIMIT 1;
