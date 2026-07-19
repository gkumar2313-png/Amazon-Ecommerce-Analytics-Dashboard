-- SQL Analysis phase - PART2(intermediate Queries)
USE amazon_ecommerce;


-- 13.What is the monthly sales trend?
SELECT MONTH(order_date) AS Month_No,
    MONTHNAME(order_date) AS 'Month_Name',
    SUM(total_sales_inr) AS 'Total_Sales'
FROM orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- 14.Which are the Top 10 Customers by Total Spending?
SELECT customer_id, SUM(total_sales_inr) AS Total_Spending
FROM orders
GROUP BY customer_id
ORDER BY Total_Spending DESC
LIMIT 10;

-- 15. Which are the Top 10 Best-Selling Products by Quantity?
SELECT t2.product_name, SUM(t1.quantity) AS Total_Quantity_Sold
FROM orders t1
JOIN products t2
ON t1.product_id = t2.product_id
GROUP BY t2.product_name
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- 16. Which states generated the highest revenue?
SELECT state,SUM(total_sales_inr) AS revenue FROM orders
GROUP BY state 
ORDER BY revenue DESC;

-- 17. What is the average spending per customer?
SELECT customer_id,AVG(total_sales_inr) AS avg_spending 
FROM orders
GROUP BY customer_id
ORDER BY avg_spending DESC;

-- 18. Which customers placed more than one order?
SELECT customer_id,COUNT(order_id) AS Total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>1
ORDER BY Total_orders DESC;


-- 19. Which payment method generated the highest revenue?
SELECT payment_method, SUM(total_sales_inr) AS Revenue
FROM orders
GROUP BY payment_method
ORDER BY Revenue DESC;


-- 20. Which products have the highest average rating?
SELECT t2.product_name,AVG(t1.review_rating) AS Avg_rating 
FROM orders t1
JOIN products t2
ON t1.product_id=t2.product_id
GROUP BY t2.product_name
ORDER BY Avg_rating DESC
LIMIT 10;

-- 21. Which products have the lowest average rating?
SELECT t2.product_name,AVG(t1.review_rating) AS Avg_rating 
FROM orders t1
JOIN products t2
ON t1.product_id=t2.product_id
GROUP BY t2.product_name
ORDER BY Avg_rating ASC
LIMIT 10;

-- 22. What is the return rate by product category?
SELECT
    t2.product_category,
    COUNT(CASE WHEN t1.delivery_status = 'Returned' THEN 1 END) AS Returned_Orders,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(CASE WHEN t1.delivery_status = 'Returned' THEN 1 END) * 100.0 / COUNT(*),2) AS Return_Rate_Percentage
FROM orders t1
JOIN products t2
ON t1.product_id = t2.product_id
GROUP BY t2.product_category
ORDER BY Return_Rate_Percentage DESC;
