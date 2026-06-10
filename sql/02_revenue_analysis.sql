-- Q6. What is the total revenue generated across all orders? (table: order_payments, column: payment_value)
SELECT ROUND(SUM (payment_value):: NUMERIC,2) AS total_revenue FROM order_payments

-- Q7. What is the monthly revenue trend? Extract month and year from order_purchase_timestamp (tables: orders + order_payments)
SELECT 
	TO_CHAR(o.order_purchase_timestamp,'YYYY-MM') AS year_month,
	ROUND(SUM(p.payment_value):: NUMERIC, 2) AS monthly_revenue
FROM orders o
INNER JOIN order_payments p
	ON o.order_id = p.order_id
GROUP BY year_month
ORDER BY monthly_revenue;

-- Q8. What is the average order value — overall and per payment type? (table: order_payments)
SELECT 
	payment_type,
	ROUND(AVG(payment_value):: NUMERIC,2) AS average_order_value
FROM order_payments
GROUP BY payment_type
ORDER BY average_order_value DESC;

-- Q9. What are the top 10 product categories by total revenue? (tables: order_items + products + product_category_translation)
SELECT 
	t.product_category_name_english,
	ROUND(SUM(oi.price)::NUMERIC,2) AS total_revenue
FROM order_items oi
INNER JOIN products p
	ON oi.product_id = p.product_id
INNER JOIN product_category_translation t
	ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;