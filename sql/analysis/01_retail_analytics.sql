/*
===============================================================================
Project      : UrbanNest Retail Analytics with Databricks SQL
Script       : 01_retail_analytics.sql
Author       : Kaushal Chanchadiya
Created On   : 2026-08-08

Description:
    This script performs focused retail analysis on the UrbanNest Gold-layer
    dataset. It covers core business KPIs, customer and product exploration,
    sales trends, and queries used later for Databricks dashboards.

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
-- 1. Customer & Product Exploration
-- ============================================================================

-- Explore Customer Geographic Coverage

SELECT DISTINCT
    region,
    state,
    city
FROM dim_customers
ORDER BY
    region,
    state,
    city;

-- Explore Product Categories, Subcategories, and Products

SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM dim_products
ORDER BY
     category,
    subcategory,
    product_name;

 -- ============================================================================
-- 2. Core Business KPIs
-- =============================================================================

SELECT
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(DISTINCT product_key) AS total_products
FROM fact_sales;

-- ============================================================================
-- 3. Sales Trend Analysis
-- ============================================================================

-- Sales Trend by Month

SELECT
    CAST(DATE_TRUNC('month', order_date) AS DATE) AS sales_month,
    ROUND(SUM(net_sales), 2) AS total_sales
FROM fact_sales
GROUP BY 
     DATE_TRUNC('month', order_date)
ORDER BY 
    sales_month;

-- Sales by Product Category

SELECT
    p.category,
    ROUND(SUM(s.net_sales), 2) AS total_sales
FROM fact_sales AS s
LEFT JOIN dim_products AS p
       ON s.product_key = p.product_key
GROUP BY
    p.category
ORDER BY
    total_sales DESC;

-- Yearly Sales & Profit Analysis

WITH yearly_performance AS (
    SELECT
        YEAR(order_date) AS sales_year,
        ROUND(SUM(net_sales), 2) AS total_sales,
        ROUND(SUM(profit_amount), 2) AS total_profit
    FROM fact_sales
    GROUP BY
        YEAR(order_date)
)
SELECT  
    sales_year,
    total_sales,
    total_profit,
    ROUND( 
          (total_sales - LAG(total_sales) OVER (ORDER BY sales_year)) / NULLIF(LAG(total_sales) OVER (ORDER BY sales_year), 0) * 100, 2
         ) AS sales_growth_pct,
    ROUND(
          (total_profit - LAG(total_profit) OVER (ORDER BY sales_year)) / NULLIF(LAG(total_profit) OVER (ORDER BY sales_year), 0) * 100, 2
         ) AS profit_growth_pct
FROM yearly_performance
ORDER BY 
    sales_year;

-- Discount Impact : Gross Sales vs Net Sales

SELECT
    YEAR(order_date) AS sales_year,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(SUM(net_sales), 2) AS total_net_sales,
    ROUND(SUM(discount_amount), 2) AS total_discounts,
    ROUND(SUM(discount_amount) / NULLIF(SUM(gross_sales), 0) * 100, 2) AS discount_pct
FROM fact_sales
GROUP BY
    YEAR(order_date)
ORDER BY
    sales_year;

-- ============================================================================
-- 4. Product & Customer Highlights
-- ============================================================================

-- Sales by Product

SELECT
    p.product_name,
    ROUND(SUM(s.net_sales), 2) AS total_sales
FROM fact_sales AS s 
LEFT JOIN dim_products AS p
       ON s.product_key = p.product_key
GROUP BY
    p.product_name
ORDER BY
    total_sales DESC
LIMIT 10;

-- Orders by Customer Age Group

SELECT
    c.age_group,
    COUNT(DISTINCT s.order_id) AS total_orders
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
GROUP BY
    c.age_group
ORDER BY
    total_orders DESC;

-- Top 10 Customers by Sales

SELECT
    c.customer_name,
    ROUND(SUM(s.net_sales), 2) AS total_sales
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
GROUP BY 
    c.customer_name
ORDER BY
    total_sales DESC
LIMIT 10;

-- Sales Performance by Region

SELECT
    c.region,
    COUNT(DISTINCT s.order_id) AS total_orders,
    ROUND(SUM(s.net_sales), 2) AS total_sales,
    ROUND(SUM(s.profit_amount), 2) AS total_profit
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
GROUP BY
    c.region
ORDER BY
    total_sales DESC;

-- Customer Segment Performance

SELECT
    c.customer_segment,
    COUNT(DISTINCT s.customer_key) AS total_customers,
    COUNT(DISTINCT s.order_id) AS total_orders,
    ROUND(SUM(s.net_sales), 2) AS total_sales,
    ROUND(SUM(s.profit_amount), 2) AS total_profit
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
GROUP BY
    c.customer_segment
ORDER BY
    total_sales DESC;

-- Membership-Level Analysis

SELECT
    c.membership_level,
    COUNT(DISTINCT s.customer_key) AS total_customers,
    COUNT(DISTINCT s.order_id) AS total_orders,
    ROUND(SUM(s.net_sales), 2) AS total_sales,
    ROUND(SUM(s.profit_amount), 2) AS total_profit,
    ROUND(SUM(s.profit_amount) / NULLIF(SUM(s.net_sales), 0) * 100, 2) AS profit_margin_pct
FROM fact_sales AS s
LEFT JOIN dim_customers AS c
       ON s.customer_key = c.customer_key
GROUP BY
    c.membership_level
ORDER BY
    total_sales DESC;

-- ============================================================================
-- 5. Channel & Profitability Analysis
-- ============================================================================

-- Sales and Profit by Sales Channel

SELECT
    sales_channel,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit
FROM fact_sales
GROUP BY
    sales_channel
ORDER BY
    total_sales DESC; 

-- Profitability by Product Category

SELECT
    p.category,
    ROUND(SUM(s.net_sales), 2) AS total_sales,
    ROUND(SUM(s.profit_amount), 2) AS total_profit,
    ROUND(SUM(s.profit_amount) / NULLIF(SUM(s.net_sales), 0) * 100, 2) AS profit_margin_pct
FROM fact_sales AS s
JOIN dim_products AS p
  ON s.product_key = p.product_key
GROUP BY
    p.category
ORDER BY
    profit_margin_pct DESC;

-- Order Status Distribution

SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_sales), 2) AS total_sales
FROM fact_sales
GROUP BY
    order_status
ORDER BY 
    total_orders DESC;

-- Paymment Method Performance

SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit
FROM fact_sales
GROUP BY
    payment_method
ORDER BY 
    total_orders DESC;