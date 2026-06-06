-- ==========================================
-- Create Database
-- ==========================================
CREATE DATABASE sales_db;

-- Select the database for use
USE sales_db;

-- ==========================================
-- Create Customers Table
-- ==========================================
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,      -- Unique customer ID
    customer_name VARCHAR(100),               -- Customer name
    region VARCHAR(50),                       -- Customer region
    segment VARCHAR(50)                       -- Customer segment
);

-- ==========================================
-- Create Orders Table
-- ==========================================
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,         -- Unique order ID
    order_date DATE,                          -- Date of order
    customer_id VARCHAR(10),                  -- Customer ID linked to customers table
    product_category VARCHAR(50),             -- Product category
    sales DECIMAL(10,2),                      -- Sales amount
    quantity INT,                             -- Quantity sold
    profit DECIMAL(10,2),                     -- Profit earned
    discount DECIMAL(5,2)                     -- Discount provided
);

-- ==========================================
-- Query 1: Display Order Details with Customer Information
-- ==========================================
SELECT 
    o.Order_ID,                -- Order ID
    o.Order_Date,              -- Order Date
    c.Customer_Name,           -- Customer Name
    c.Region,                  -- Customer Region
    o.Product_Category,        -- Product Category
    o.Sales,                   -- Sales Amount
    o.Profit                   -- Profit Earned
FROM Orders o

-- Join Orders and Customers tables using Customer_ID
INNER JOIN Customers c 
    ON o.Customer_ID = c.Customer_ID;

-- ==========================================
-- Query 2: Region-wise Sales Analysis
-- ==========================================
SELECT 
       c.Region,                       -- Region Name
       SUM(o.Sales) AS Total_Sales     -- Total Sales per Region
FROM Orders o

-- Join Orders and Customers tables
JOIN Customers c 
  ON o.Customer_ID = c.Customer_ID

-- Group data by Region
GROUP BY c.Region;

-- ==========================================
-- Query 3: Profit Margin by Product Category
-- ==========================================
SELECT 
       Product_Category,                      -- Product Category
       SUM(Profit) / SUM(Sales) AS Profit_Margin
FROM Orders

-- Group data by Product Category
GROUP BY Product_Category;

-- ==========================================
-- Query 4: Monthly Sales Trend Analysis
-- ==========================================
SELECT
    MONTHNAME(order_date) AS Month,           -- Extract Month Name
    SUM(sales) AS Monthly_Sales               -- Total Sales for each Month
FROM orders

-- Group data by Month
GROUP BY MONTH(order_date), MONTHNAME(order_date)

-- Sort months in chronological order
ORDER BY MONTH(order_date);

-- ==========================================
-- Query 5: Top 5 Customers by Revenue
-- ==========================================
SELECT
    c.customer_name,                          -- Customer Name
    SUM(o.sales) AS Total_Revenue             -- Total Revenue Generated
FROM orders o

-- Join Orders and Customers tables
JOIN customers c
ON o.customer_id = c.customer_id

-- Group data by Customer Name
GROUP BY c.customer_name

-- Sort customers by Revenue in descending order
ORDER BY Total_Revenue DESC

-- Display only Top 5 Customers
LIMIT 5;