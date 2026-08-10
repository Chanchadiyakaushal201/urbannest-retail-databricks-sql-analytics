-- ============================================================
-- Dataset: Sales by Product Category
-- Purpose: Compare sales performance across product
--          categories.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

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