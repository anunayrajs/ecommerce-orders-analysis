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

-- Q10. Which months have revenue above the overall monthly average? (use HAVING)
SELECT
	TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS year_month,
	ROUND(SUM(p.payment_value)::NUMERIC,2) AS monthly_revenue
FROM orders o
INNER JOIN order_payments p
	ON o.order_id = p.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp,'YYYY-MM')
HAVING SUM(p.payment_value) > (SELECT AVG(monthly_total) 
	FROM (
		SELECT SUM(p2.payment_value) AS monthly_total
		FROM orders o2
		INNER JOIN order_payments p2
			ON o2.order_id = p2.order_id
		GROUP BY TO_CHAR(o2.order_purchase_timestamp,'YYYY-MM')
	) AS subquery 
)
ORDER BY year_month;

-- Q11. What is the % revenue contribution of each payment type? (credit_card, boleto, voucher, debit_card)
SELECT payment_type,
	ROUND(SUM(payment_value)::NUMERIC,2) AS type_revenue,
	ROUND(SUM(payment_value) *100 / SUM(SUM(payment_value)) OVER() ::NUMERIC,2) AS pct_contribution
FROM order_payments
GROUP BY payment_type;