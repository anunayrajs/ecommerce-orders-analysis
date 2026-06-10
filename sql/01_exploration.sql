-- ================================================
-- PROJECT: E-Commerce Orders Analysis (Olist)
-- FILE: 01_exploration.sql
-- DESCRIPTION: Data exploration and basic counts
-- ================================================

-- Verify all tables loaded correctly
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers UNION ALL
SELECT 'orders', COUNT(*) FROM orders UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews UNION ALL
SELECT 'products', COUNT(*) FROM products UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers UNION ALL
SELECT 'product_category_translation', COUNT(*) FROM product_category_translation;


-- Q1. How many total orders are in the dataset?
SELECT COUNT(*) AS total_orders FROM orders;

-- Q2. What is the date range of orders — earliest and latest order purchase date?
SELECT MIN(order_purchase_timestamp) AS earliest_purchase_date, MAX(order_purchase_timestamp) AS latest_purchase_date
FROM orders;

-- Q3. How many unique customers, sellers and product categories are there?
SELECT
(SELECT COUNT(DISTINCT(customer_id)) FROM customers) AS unique_customers,
(SELECT COUNT(DISTINCT(seller_id )) FROM sellers) AS unique_sellers ,
(SELECT COUNT(DISTINCT(product_category_name)) FROM products) AS unique_product_category;

-- Q4. What is the order status breakdown — how many orders per status?
SELECT order_status, COUNT(*) AS orders_per_status FROM orders
GROUP BY order_status
ORDER BY orders_per_status DESC;

-- Q5. Which are the top 10 states by number of customers?
SELECT customer_state, COUNT(*) AS total_cusotmers FROM customers
GROUP BY customer_state
ORDER BY total_cusotmers DESC
LIMIT 10;
