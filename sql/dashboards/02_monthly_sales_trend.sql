-- ============================================================
-- Dataset: Monthly Sales Trend
-- Purpose: Analyze monthly sales trends across 
--          the available reporting period.
-- Used In: UrbanNest Retail Performance Dashboard
-- ============================================================

SELECT
    CAST(DATE_TRUNC('month', order_date) AS DATE) AS sales_month,
    ROUND(SUM(net_sales), 2) AS total_sales
FROM fact_sales
GROUP BY 
     DATE_TRUNC('month', order_date)
ORDER BY 
    sales_month;