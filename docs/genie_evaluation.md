# Databricks Genie – Evaluation & Monitoring

## Overview

After configuring and testing the UrbanNest Retail Analytics Genie,
the agent was evaluated using Databricks' built-in Benchmark and
Monitoring capabilities.

The goal of this stage was to assess how Genie's generated analysis
compared with predefined SQL ground-truth queries and to review the
quality of responses produced during business-question testing.

---

## Benchmark Evaluation

A benchmark set of five representative business questions was created
to evaluate the Genie Agent against predefined SQL ground-truth answers.

The benchmark covered multiple analytical areas, including:

- Overall sales and profit
- Product category sales
- Product category profitability
- Regional sales performance
- Customer acquisition channel performance

For each benchmark question, a ground-truth SQL query was defined so
that Databricks could compare Genie's generated analysis with an
expected result.

---

## Benchmark Questions

### 1. Overall Business Performance

**Question:** What are the Total Sales and Total Profit?

**Evaluation Goal:** Verify that Genie correctly calculates the overall
sales and profit values from the sales transactions.

---

### 2. Product Category Sales

**Question:** Which product category generates the highest total sales?

**Evaluation Goal:** Verify that Genie identifies the highest-selling
product category and reports its corresponding sales value.

---

### 3. Regional Sales Performance

**Question:** Which region generates the highest total sales?

**Evaluation Goal:** Verify that Genie identifies the strongest
revenue-generating region.

---

### 4. Product Category Profitability

**Question:** Which product category has the lowest profit margin?

**Evaluation Goal:** Verify that Genie correctly calculates category-level
profit margin and identifies the category with the lowest margin.

---

### 5. Acquisition Channel Performance

**Question:** Which acquisition channel brings in customers who generate
the most sales?

**Evaluation Goal:** Verify that Genie identifies the acquisition channel
associated with the highest total customer sales.

---

## Benchmark Result

The initial benchmark evaluation reported an accuracy score of:

**20% (1 of 5 benchmark questions passed)**

At first glance, this appears to indicate poor agent performance.
However, reviewing the individual benchmark failures showed that the
result required additional interpretation.

Several Genie responses returned the correct business insight while
also providing additional analytical context beyond the narrowly
defined ground-truth query.

For example, a benchmark might expect only:

- The highest-performing acquisition channel
- Its total sales value

Genie could instead return:

- Sales for multiple acquisition channels
- Customer counts
- Average sales per customer
- Order counts
- Additional filtering or analytical context

Because benchmark evaluation compares the generated result against the
defined ground-truth logic, these differences can cause an answer to
receive a poor benchmark assessment even when the response remains
useful from a business-analysis perspective.

---

## Interpreting the Benchmark

The 20% score therefore should not be interpreted as meaning that
Genie answered only 20% of the business questions correctly.

Instead, the evaluation highlighted an important distinction between:

**Strict benchmark accuracy**

and

**Exploratory analytical usefulness**

The benchmark validates whether Genie follows a predefined analytical
definition closely, while the interactive Genie conversations showed
that the agent could provide broader supporting information that may
be useful to an analyst or business stakeholder.

This also demonstrates why benchmark design is important. Ground-truth
SQL, business definitions, filtering rules, and expected output should
be aligned with the intended behavior of the Genie space.

---

## Monitoring

Databricks Monitoring was used to review activity generated during
testing of the UrbanNest Retail Analytics Genie.

The monitoring interface provided visibility into:

- Total questions asked
- Unique users
- User feedback
- Individual conversations
- Generated responses
- Agent usage patterns

During the initial project testing period, the Genie space recorded:

- **10 questions**
- **1 unique user**
- **9 thumbs-up ratings**
- **0 thumbs-down ratings**

The individual conversations could also be reviewed directly from the
monitoring interface, making it possible to inspect the questions,
generated analysis, visualizations, and feedback associated with each
interaction.

---

## Evaluation Takeaways

The evaluation stage demonstrated several important aspects of working
with an AI-powered analytics agent:

1. **Ground-truth definitions matter.**  
   Benchmark results depend heavily on how expected SQL logic and
   business rules are defined.

2. **Correct insight and exact benchmark matching are not always the
   same thing.**  
   An agent may produce a useful analytical response while differing
   from a narrowly defined benchmark output.

3. **Additional context can be valuable.**  
   Genie often supplemented direct answers with supporting metrics that
   helped explain the business result.

4. **Monitoring complements benchmarking.**  
   Benchmarks provide structured evaluation, while monitoring helps
   review actual usage, responses, and user feedback.

5. **Evaluation is iterative.**  
   Benchmark failures can reveal opportunities to improve instructions,
   metric definitions, filters, or the benchmark itself.

---

## Conclusion

Benchmarking and monitoring added an evaluation layer to the UrbanNest
Retail Analytics Genie implementation.

Rather than relying only on whether the agent could generate an answer,
the project also examined how those answers compared with predefined
business logic and how the agent performed during real conversational
analysis.

This provides a more realistic representation of how an analytics
agent can be tested, reviewed, and improved before broader business use.