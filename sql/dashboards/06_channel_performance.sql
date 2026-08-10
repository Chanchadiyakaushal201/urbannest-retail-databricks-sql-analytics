-- ============================================================
-- Dataset: Sales Channel Performance
-- Purpose: Compare sales and profit performance across
--          different sales channels.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

SELECT
    sales_channel,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit
FROM fact_sales
GROUP BY
    sales_channel
ORDER BY
    total_sales DESC; 