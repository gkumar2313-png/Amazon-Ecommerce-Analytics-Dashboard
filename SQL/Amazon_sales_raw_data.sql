USE amazon_ecommerce;
SELECT * FROM amazon_ecommerce.raw_sales;

SELECT COUNT(*) AS Total_Records
FROM raw_sales;

SELECT Order_ID, COUNT(*) AS Count_Order
FROM raw_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;

SELECT *
FROM raw_sales
WHERE Order_ID IS NULL
   OR Customer_ID IS NULL
   OR Product_Name IS NULL;
   
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM raw_sales;

SELECT COUNT(DISTINCT Product_Name) AS Total_Products
FROM raw_sales;

SELECT COUNT(DISTINCT Product_Category) AS Total_Categories
FROM raw_sales;

SELECT DISTINCT Product_Category
FROM raw_sales;

SELECT DISTINCT Payment_Method
FROM raw_sales;

SELECT DISTINCT Delivery_Status
FROM raw_sales;

SELECT *
FROM raw_sales
WHERE Total_Sales_INR <> Quantity * Unit_Price_INR;


SELECT Total_Sales_INR,Quantity * Unit_Price_INR as 'check_total'
FROM raw_sales
WHERE Total_Sales_INR != Quantity * Unit_Price_INR;


SELECT *
FROM raw_sales
WHERE CAST(Total_Sales_INR AS DECIMAL(12,2))
    !=
      CAST(Quantity * Unit_Price_INR AS DECIMAL(12,2));
      
SELECT
    Product_Name,
    COUNT(DISTINCT Unit_Price_INR) AS price_count
FROM raw_sales
GROUP BY Product_Name
HAVING COUNT(DISTINCT Unit_Price_INR) > 1;

SELECT
    Order_ID,
    COUNT(*) AS product_count
FROM raw_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;