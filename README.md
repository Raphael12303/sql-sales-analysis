# SQL Sales Analysis Project

## Overview
This project demonstrates core SQL skills using a small sales dataset.  
The focus is on data cleaning, aggregation, window functions, and trend analysis using MySQL.

## Dataset
The project uses two tables:
- `sales`: contains sales transactions with dates, products, customers, and amounts
- `customers`: contains customer details with some missing values

The data is intentionally small and includes duplicates and NULL values to simulate real-world scenarios.

## Key Concepts Used
- NULL handling using `COALESCE`
- Aggregation with `GROUP BY` and `SUM`
- Window functions (`AVG`, `LAG`, `RANK`)
- Rolling averages
- Trend detection using `CASE`
- Duplicate detection and removal
- Safe deletion using primary keys

## Analysis Performed
- Total sales per product
- Rolling average of daily sales
- Day-over-day sales trend (UP / DOWN)
- Ranking products by total sales
- Identifying and removing duplicate records

## Tools
- MySQL 8.0+
- MySQL Workbench

## How to Run
1. Create the tables and insert data using `sales_analysis.sql`
2. Run each query section step by step to see the results

## Notes
This project is intended as a learning and practice exercise to reinforce SQL fundamentals and analytical queries.

Related SQL project: https://github.com/yourusername/sql-sales-analysis
