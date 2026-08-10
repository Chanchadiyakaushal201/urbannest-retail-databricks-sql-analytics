-- ============================================================
-- Dataset: Top 10 Products by Sales
-- Purpose: Identify the top 10 products based on total
--          sales performance.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

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