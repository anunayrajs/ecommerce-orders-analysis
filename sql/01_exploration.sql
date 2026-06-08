-- ================================================
-- PROJECT: E-Commerce Orders Analysis (Olist)
-- FILE: 01_exploration.sql
-- DESCRIPTION: Data exploration and basic counts
-- ================================================

-- Verify all tables loaded correctly
SELECT 'customers'                    AS table_name, COUNT(*) AS total_rows FROM customers                     UNION ALL
SELECT 'orders',                                     COUNT(*)               FROM orders                        UNION ALL
SELECT 'order_items',                                COUNT(*)               FROM order_items                   UNION ALL
SELECT 'order_payments',                             COUNT(*)               FROM order_payments                UNION ALL
SELECT 'order_reviews',                              COUNT(*)               FROM order_reviews                 UNION ALL
SELECT 'products',                                   COUNT(*)               FROM products                      UNION ALL
SELECT 'sellers',                                    COUNT(*)               FROM sellers                       UNION ALL
SELECT 'product_category_translation', COUNT(*)                             FROM product_category_translation;