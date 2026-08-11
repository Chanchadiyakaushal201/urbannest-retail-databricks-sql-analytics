# Databricks Genie – Business Questions

## Overview

The UrbanNest Retail Analytics Genie was tested with a structured set
of natural-language business questions covering sales performance,
profitability, customers, products, geography, and sales channels.

These questions were designed to simulate the types of analytical
questions a business stakeholder could ask without writing SQL.

---

## Business Questions

### 1. Overall Sales Performance
**Question:** What are the Total Sales and Total Profit?

**Purpose:** Establish a high-level view of overall business performance
using the core sales and profitability KPIs.

---

### 2. Monthly Sales Trend
**Question:** How have monthly sales changed over time?

**Purpose:** Analyze sales performance over time and identify growth
patterns or changes in monthly revenue.

---

### 3. Regional Sales Performance
**Question:** Which region generates the highest total sales?

**Purpose:** Compare regional performance and identify the strongest
revenue-generating market.

---

### 4. Customer Age Group Analysis
**Question:** Which age group generates the highest average sales per order?

**Purpose:** Understand whether customer age groups differ in their
average order value.

---

### 5. Product Category Performance
**Question:** Which product categories have high sales but relatively
low profit margins?

**Purpose:** Identify categories where strong revenue does not translate
into equally strong profitability.

---

### 6. Product Category Profitability
**Question:** Which product category has the lowest profit margin?

**Purpose:** Identify the weakest-performing category from a
profitability perspective.

---

### 7. Acquisition Channel Performance
**Question:** Which acquisition channel brings in customers who generate
the most sales?

**Purpose:** Determine which customer acquisition source contributes
the greatest sales value.

---

### 8. State-Level Profitability
**Question:** Which states have high sales but relatively low profit margins?

**Purpose:** Identify high-revenue states where profitability remains
below the overall business benchmark.

---

## Context-Aware Follow-up Analysis

The final two questions were intentionally asked within the same Genie
conversation to test whether Genie could retain analytical context.

### 9. Product Drill-Down
**Question:** Within the highest-selling product category, what are the
top 5 products by sales?

**Purpose:** Drill down from category-level performance to the strongest
individual products.

### 10. Year-over-Year Follow-up
**Question:** How did sales for those products change from 2024 to 2025?

**Purpose:** Test whether Genie could understand that "those products"
referred to the top five products identified in the previous question
and perform a year-over-year comparison without requiring the products
to be specified again.

---

## Analysis Coverage

The Genie testing covered:

- Overall business KPIs
- Time-series sales analysis
- Regional performance
- Customer demographic analysis
- Product category performance
- Profitability analysis
- Acquisition channel performance
- Geographic profitability
- Product-level drill-down
- Year-over-year analysis
- Conversational context retention

---

## Key Takeaway

The business-question testing demonstrates how Databricks Genie can
provide a natural-language interface over the UrbanNest Gold-layer
analytics model. Business users can move from high-level KPIs to more
specific diagnostic questions and continue the analysis through
context-aware follow-up questions without directly writing SQL.