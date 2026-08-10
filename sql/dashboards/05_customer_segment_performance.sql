-- ============================================================
-- Dataset: Customer Segment Performance
-- Purpose: Compare sales performance across customer
--          segments.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

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