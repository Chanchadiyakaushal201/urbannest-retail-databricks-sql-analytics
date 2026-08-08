/*
===============================================================================
Project      : UrbanNest Retail Analytics with Databricks SQL
Script       : 02_data_quality_checks.sql
Author       : Kaushal Chanchadiya
Created On   : 2026-08-07

Description:
    This script validates the quality and integrity of the UrbanNest Retail
    Gold-layer dataset before business analysis. It checks row counts,
    primary-key uniqueness, missing values, foreign-key integrity,
    date ranges, and key business rules.

Tables Used:
    - dim_customers
    - dim_products
    - fact_sales

Execution:
    Run this script inside the 'workspace.salesdb' schema in Databricks SQL.

===============================================================================
*/

USE CATALOG workspace;
USE SCHEMA salesdb;

-- ============================================================================
-- 1. Row count validation
-- ============================================================================

SELECT 
    COUNT(*) AS total_customers
FROM dim_customers;

SELECT 
    COUNT(*) AS total_products
FROM dim_products;

SELECT 
    COUNT(*) AS total_sales_rows
FROM fact_sales;

-- ============================================================================
-- 2. Primary key uniqueness checks
-- ============================================================================

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_key) AS unique_customer_keys
FROM dim_customers;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_key) AS unique_product_keys
FROM dim_products;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT sales_key) AS unique_sales_keys
FROM fact_sales;

-- ============================================================================
-- 3. NULL Value Validation
-- ============================================================================

-- Customers
-- Expected Result : 0

SELECT
    SUM(
        CASE
            WHEN customer_key IS NULL THEN 1 ELSE 0 END
    ) AS null_customer_key,
    SUM(
        CASE
            WHEN customer_name IS NULL THEN 1 ELSE 0 END 
    ) AS null_customer_name
FROM dim_customers;

-- Products
-- Expected Result : 0

SELECT
    SUM(
        CASE
            WHEN product_key IS NULL THEN 1 ELSE 0 END
    ) AS null_product_key,
    SUM(
        CASE
            WHEN product_name IS NULL THEN 1 ELSE 0 END 
    ) AS null_product_name
FROM dim_products;

-- Sales
-- Expected Result : 0

SELECT
    SUM(
        CASE
            WHEN sales_key IS NULL THEN 1 ELSE 0 END
    ) AS null_sales_key,
    SUM(
        CASE
            WHEN order_date IS NULL THEN 1 ELSE 0 END 
    ) AS null_order_date,
    SUM(
        CASE
            WHEN customer_key IS NULL THEN 1 ELSE 0 END 
    ) AS null_customer_key,
    SUM(
        CASE
            WHEN product_key IS NULL THEN 1 ELSE 0 END 
    ) AS null_product_key
FROM fact_sales;

-- ============================================================================
-- 4. Foreign Key Integrity Validation
-- ============================================================================

-- Expected Result : 0

SELECT
    COUNT(*) AS orphan_customer_records
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
WHERE 
    c.customer_key IS NULL;   

SELECT
    COUNT(*) AS orphan_product_records
FROM fact_sales AS s
LEFT JOIN dim_products AS p
       ON s.product_key = p.product_key
WHERE 
    p.product_key IS NULL;

-- ============================================================================
-- 5. Date Range Validation
-- ============================================================================

SELECT  
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    COUNT(DISTINCT YEAR(order_date)) AS total_years
FROM fact_sales;

SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_sales_rows
FROM fact_sales
GROUP BY 
    YEAR(order_date)
ORDER BY
    order_year;

-- ============================================================================
-- 6. Business Data Validation
-- ============================================================================

-- Gross Sales should never be negative

SELECT  
    COUNT(*) AS negative_gross_sales
FROM fact_sales
WHERE gross_sales < 0;

-- Net Sales should never be negative

SELECT  
    COUNT(*) AS negative_net_sales
FROM fact_sales
WHERE net_sales < 0;

-- Cost Amount should never be negative

SELECT  
    COUNT(*) AS negative_cost_amount
FROM fact_sales
WHERE cost_amount < 0;

-- Quantity should always be greater than zero

SELECT  
    COUNT(*) AS invalid_quantity
FROM fact_sales
WHERE quantity <= 0;

-- Check records with negative profit

SELECT  
    COUNT(*) AS negative_profit_records
FROM fact_sales
WHERE profit_amount < 0;

-- Validate Order Status

SELECT  
    order_status,
    COUNT(*) AS total_rows
FROM fact_sales
GROUP BY
    order_status
ORDER BY
    total_rows DESC;

-- -- Validate Sales Channel

SELECT
    sales_channel,
    COUNT(*) AS total_rows
FROM fact_sales
GROUP BY
    sales_channel
ORDER BY
    total_rows DESC; 