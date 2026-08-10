-- ============================================================
-- Dataset: Monthly Sales Trend
-- Purpose: Analyze monthly sales performance over time
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

SELECT
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(DISTINCT product_key) AS total_products
FROM fact_sales;