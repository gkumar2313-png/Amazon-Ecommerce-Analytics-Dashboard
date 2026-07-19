-- SQL Analysis phase - PART3(ADVANCE Queries)
USE amazon_ecommerce;

-- 23: Which products generate the highest revenue, and what is their rank?
SELECT t2.product_name, SUM(t1.total_sales_inr) AS revenue,
RANK() OVER(ORDER BY SUM(t1.total_sales_inr) DESC) AS Product_rank
FROM orders t1
JOIN products t2
ON t1.product_id=t2.product_id
GROUP BY t2.product_name;

-- 24: Who are the highest spending customers?
SELECT customer_id,SUM(total_sales_inr) AS spending,
DENSE_RANK() OVER (ORDER BY SUM(total_sales_inr) DESC) AS customer_rank
FROM orders
GROUP BY customer_id;


-- 25: What percentage of total revenue comes from each product category?
SELECT t2.product_category, SUM(t1.total_sales_inr) AS Revenue,
SUM(t1.total_sales_inr)*100/(SELECT SUM(total_sales_inr)
FROM orders) AS Revenue_Percentage 
FROM orders t1
JOIN products t2
ON t1.product_id=t2.product_id
GROUP BY t2.product_category
ORDER BY Revenue DESC;

-- 26: Which are the top 3 revenue-generating products in every category?
WITH ProductRevenue AS
( SELECT
    p.product_category,p.product_name,
    ROUND(SUM(o.total_sales_inr),2) AS Revenue,
    ROW_NUMBER() OVER(PARTITION BY p.product_category ORDER BY SUM(o.total_sales_inr) DESC) AS rn

	FROM orders o
	JOIN products p
	ON o.product_id=p.product_id

	GROUP BY
	p.product_category,
	p.product_name
)
SELECT * FROM ProductRevenue
WHERE rn<=3;


-- 27: How does cumulative revenue grow month by month?
WITH MonthlySales AS
(SELECT
	DATE_FORMAT(order_date,'%Y-%m') AS Month,
	SUM(total_sales_inr) AS Revenue
	FROM orders
	GROUP BY DATE_FORMAT(order_date,'%Y-%m')
)
SELECT Month,Revenue,
SUM(Revenue) OVER(ORDER BY Month) AS Running_Total
FROM MonthlySales;


-- 28: Create Sales Summary View
CREATE VIEW sales_summary AS
SELECT p.product_category, COUNT(o.order_id) AS Orders,
SUM(o.total_sales_inr) AS Revenue,
AVG(o.review_rating) AS Avg_Rating
FROM orders o
JOIN products p
ON o.product_id=p.product_id
GROUP BY p.product_category;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM sales_summary;