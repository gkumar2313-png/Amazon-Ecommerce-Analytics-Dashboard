CREATE DATABASE amazon_ecommerce;

USE amazon_ecommerce;
-- Create tables 

CREATE TABLE raw_sales;
-- use to create normalized table from it 

CREATE TABLE customers (
	customer_id Varchar(20) PRIMARY KEY
);

DESCRIBE customers;

INSERT INTO customers (customer_id)
SELECT DISTINCT Customer_ID
FROM raw_sales;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL
);
DESCRIBE products;

INSERT INTO products (product_name, product_category)
SELECT DISTINCT
    Product_Name,
    Product_Category
FROM raw_sales;

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id INT,
    order_date DATE,
    quantity INT,
    unit_price_inr DECIMAL(10,2),
    total_sales_inr DECIMAL(12,2),
    payment_method VARCHAR(30),
    delivery_status VARCHAR(30),
    review_rating TINYINT,
    review_text VARCHAR(255),
    state VARCHAR(50),
    country VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
DESCRIBE orders;
INSERT INTO orders
(
order_id,
customer_id,
product_id,
order_date,
quantity,
unit_price_inr,
total_sales_inr,
payment_method,
delivery_status,
review_rating,
review_text,
state,
country
)

SELECT
r.Order_ID,
r.Customer_ID,
p.product_id,
STR_TO_DATE(r.Date,'%d-%m-%Y'),
r.Quantity,
r.Unit_Price_INR,
r.Total_Sales_INR,
r.Payment_Method,
r.Delivery_Status,
r.Review_Rating,
r.Review_Text,
r.State,
r.Country
FROM raw_sales r
JOIN products p
ON r.Product_Name = p.product_name;
