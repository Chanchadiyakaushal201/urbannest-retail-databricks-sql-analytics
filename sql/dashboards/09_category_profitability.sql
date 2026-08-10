-- ============================================================
-- Dataset: Category Profitability
-- Purpose: Analyze sales, profit, and profit margin across
--          product categories.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

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