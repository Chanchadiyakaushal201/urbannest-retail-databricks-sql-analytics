/*
===============================================================================
Project      : UrbanNest Retail Analytics with Databricks SQL
Script       : 01_data_exploration.sql
Author       : Kaushal Chanchadiya
Created On   : 2026-08-07

Description:
    Initial exploration of the Gold-layer dataset.
    Understand table structure, key business dimensions,
    and validate data before starting analysis.

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

-- List all tables in the current schema
SHOW TABLES;

-- ============================================================================
-- Explore table structure
-- ============================================================================

DESCRIBE TABLE dim_customers;
DESCRIBE TABLE dim_products;
DESCRIBE TABLE fact_sales;

-- ============================================================================
-- Preview sample data
-- ============================================================================

SELECT *
FROM dim_customers
LIMIT 100;

SELECT *
FROM dim_products
LIMIT 100;

SELECT *
FROM fact_sales
LIMIT 100;