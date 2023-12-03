## Data Processing
SELECT * FROM pizza_sales;
UPDATE pizza_sales
SET pizza_size = CASE
	WHEN pizza_size = 'S' THEN 'Small'
    WHEN pizza_size = 'M' THEN 'Medium'
    WHEN pizza_size = 'L' THEN 'Large'
    WHEN pizza_size = 'XL' THEN 'X-Large'
    WHEN pizza_size = 'XXL' THEN 'XX-Large'
    ELSE pizza_size
END;
-----------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------KEY PERFORMANCE INDICATORS--------------------------------------------------------------------------------
## Looking the whole data
SELECT * FROM pizza_sales;

## Toral Revenue
SELECT ROUND(SUM(total_price),2) AS Total_revenue
FROM pizza_sales;

## Average order value
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS Average_order_value
FROM pizza_sales;

## Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

## Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;


## Average Pizzas Per Order
SELECT ROUND(SUM(quantity)/COUNT(DISTINCT order_id),2) AS Average_Pizzas_per_Order
FROM pizza_sales;

--------------------------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------CHARTS REQUIREMENT------------------------------------------------------------------------------------------
## Hourly Trends for Total Pizzas Sold
SELECT HOUR(order_time) AS Order_hour, 
SUM(quantity) AS Total_Order
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

## Weekly Trends for Total Orders
SELECT YEAR(order_date) AS Year,
WEEK(order_date, 3) AS Week_Number,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY YEAR(order_date), WEEK(order_date,3)
ORDER BY YEAR(order_date),WEEK(order_date,3);

## Percentage of Sales by Pizza Category:
SELECT pizza_category, SUM(total_price) AS Total_revenue, FORMAT(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

## Percentage of Sales by Pizza Size:
SELECT pizza_size, SUM(total_price) AS Total_revenue, FORMAT(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_size;

## Total Pizzas Sold by Pizza Category:
SELECT pizza_category, SUM(Quantity) AS toal_Sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY toal_Sales DESC;

#------------Top 5 Best Sellers by Revenue, Total Quantity and Total Orders-------------------
## Top 5 Best Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC
LIMIT 5;

## Bottom 5 Pizzas by revenue
SELECT pizza_name, SUM(total_price) AS Total_revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue
LIMIT 5;

## Top 5 Best Sellers by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

#### Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity
LIMIT 5;

## Top 5 Best Sellers by Order
SELECT pizza_name, count(DISTINCT order_id) AS Total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_order DESC
LIMIT 5;

## Bottom 5 Pizzas by Order
SELECT pizza_name, count(DISTINCT order_id) AS Total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_order
LIMIT 5;

