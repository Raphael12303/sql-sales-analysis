-- ===============================
-- CREATE AND POPULATE SALES TABLE
-- ===============================

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    customer VARCHAR(50),
    product VARCHAR(50),
    amount INT,
    region VARCHAR(20)
);

INSERT INTO sales (sale_id, sale_date, customer, product, amount, region) VALUES
(1, '2024-01-01', 'John', 'Phone', 100, 'East'),
(2, '2024-01-02', 'Alice', 'Laptop', 150, 'West'),
(3, '2024-01-03', 'Bob', 'Tablet', 120, 'East'),
(4, '2024-01-04', 'John', 'Phone', 200, 'East'),
(5, '2024-01-05', 'Alice', 'Laptop', 180, 'West'),
(6, '2024-01-06', 'Bob', 'Tablet', 160, 'East');

-- ===============================
-- CREATE AND POPULATE CUSTOMERS TABLE
-- ===============================

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customers (customer_id, name, email) VALUES
(1, 'John', NULL),
(2, 'Alice', 'alice@gmail.com'),
(3, 'Bob', 'bob@gmail.com'),
(4, 'Emma', NULL);

-- ===============================
-- NULL HANDLING (COALESCE)
-- ===============================

SELECT 
    customer_id,
    name,
    COALESCE(email, 'no email') AS email
FROM customers;

-- ===============================
-- AGGREGATION (TOTAL SALES PER PRODUCT)
-- ===============================

SELECT 
    product,
    SUM(amount) AS total_sales
FROM sales
GROUP BY product;

-- ===============================
-- WINDOW FUNCTION (ROLLING AVERAGE)
-- ===============================

SELECT 
    sale_date,
    amount,
    AVG(amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS rolling_average
FROM sales;

-- ===============================
-- TREND ANALYSIS (LEAD / LAG + CASE)
-- ===============================

SELECT 
    sale_date,
    amount,
    CASE
        WHEN amount > LAG(amount) OVER (ORDER BY sale_date) THEN 'UP'
        WHEN amount < LAG(amount) OVER (ORDER BY sale_date) THEN 'DOWN'
        ELSE 'NONE'
    END AS trend
FROM sales;

-- ===============================
-- RANKING DATA (WINDOW FUNCTION)
-- ===============================

SELECT 
    product,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS `rank`
FROM (
    SELECT 
        product,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY product
) t;

-- ===============================
-- FIND DUPLICATE RECORDS
-- ===============================

SELECT 
    customer,
    product,
    COUNT(*) AS cnt
FROM sales
GROUP BY customer, product
HAVING COUNT(*) > 1;

-- ===============================
-- REMOVE DUPLICATE RECORDS
-- ===============================

DELETE
FROM sales
WHERE sale_id > 0
AND sale_id IN (
    SELECT sale_id
    FROM (
        SELECT s1.sale_id
        FROM sales s1
        JOIN sales s2
          ON s1.product = s2.product
         AND s1.customer = s2.customer
         AND s1.sale_id > s2.sale_id
    ) dup
);
