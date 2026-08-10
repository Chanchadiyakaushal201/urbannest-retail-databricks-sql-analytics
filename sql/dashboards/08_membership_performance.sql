-- ============================================================
-- Dataset: Membership Performance
-- Purpose: Compare customer, order, sales, profit, and
--          profitability performance across membership levels.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

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