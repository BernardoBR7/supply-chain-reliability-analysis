ALTER TABLE orders_clean ADD COLUMN shipping_mode_order integer;

UPDATE orders_clean SET shipping_mode_order = 
    CASE shipping_mode
        WHEN 'Standard Class' THEN 1
        WHEN 'Second Class' THEN 2
        WHEN 'First Class' THEN 3
        WHEN 'Same Day' THEN 4
    END;


DROP VIEW v_fact_orders;
CREATE VIEW v_fact_orders AS
SELECT
order_id,
order_date,
shipping_date,
sales,
order_profit_per_order as profit,
order_item_total,
order_item_quantity,
order_profit_per_order / NULLIF(sales,0) AS profit_margin,
(days_shipping_real - days_shipping_scheduled) AS shipping_delay_days,
days_shipping_real,
days_shipping_scheduled,
delivery_status,
late_delivery_risk,
shipping_mode,
shipping_mode_order,
order_region,
order_country,
market,
category_name,
department_name,
product_name,
order_status,
customer_id,
product_card_id
FROM orders_clean;

SELECT * FROM v_fact_orders LIMIT 5;

--
--SELECT * FROM v_fact_orders LIMIT 5;

/*
CREATE VIEW v_dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_segment,
    customer_city,
    customer_country,
    customer_state
FROM orders_clean;

CREATE VIEW v_dim_products AS
SELECT DISTINCT
    product_card_id,
    product_name,
    category_name,
    department_name,
    product_price
FROM orders_clean;


SELECT * FROM v_dim_customers LIMIT 5;
SELECT * FROM v_dim_products LIMIT 5;

SELECT COUNT(order_id), COUNT(DISTINCT order_id) FROM v_fact_orders;
--Puedo ver que los order id son para ordenes que pueden contener mas de un 
--producto, debo usar los distintos para la visualizacion si no lo estoy haciendo
--por producto

SELECT DISTINCT delivery_status FROM orders_clean;