SELECT
  column_name,
  data_type
FROM
  `hiruni-bigquery-learning.olist_ecommerce.INFORMATION_SCHEMA.COLUMNS`
WHERE
  table_name = 'customers'
ORDER BY
  ordinal_position;


  SELECT
  o.order_id,
  o.customer_id,
  o.order_status,
  c.customer_city,
  c.customer_state
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
INNER JOIN
  `hiruni-bigquery-learning.olist_ecommerce.customers` AS c
ON
  o.customer_id = c.customer_id
LIMIT 10;

#Analyse orders by customer state


SELECT
  c.customer_state,
  COUNT(o.order_id) AS total_orders
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
INNER JOIN
  `hiruni-bigquery-learning.olist_ecommerce.customers` AS c
ON
  o.customer_id = c.customer_id
GROUP BY
  c.customer_state
ORDER BY
  total_orders DESC;
  #Count unique customers by state

  SELECT
  c.customer_state,
  COUNT(DISTINCT c.customer_unique_id) AS unique_customers
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
INNER JOIN
  `hiruni-bigquery-learning.olist_ecommerce.customers` AS c
ON
  o.customer_id = c.customer_id
GROUP BY
  c.customer_state
ORDER BY
  unique_customers DESC;

#Analyse repeat customers

WITH customer_orders AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
  FROM
    `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
  INNER JOIN
    `hiruni-bigquery-learning.olist_ecommerce.customers` AS c
  ON
    o.customer_id = c.customer_id
  GROUP BY
    c.customer_unique_id
)

SELECT
  COUNT(*) AS total_customers,
  COUNTIF(total_orders > 1) AS repeat_customers,
  ROUND(
    COUNTIF(total_orders > 1) * 100.0 / COUNT(*),
    2
  ) AS repeat_customer_percentage
FROM
  customer_orders;

#Understand customer purchasing frequency  

WITH customer_orders AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
  FROM
    `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
  INNER JOIN
    `hiruni-bigquery-learning.olist_ecommerce.customers` AS c
  ON
    o.customer_id = c.customer_id
  GROUP BY
    c.customer_unique_id
)

SELECT
  CASE
    WHEN total_orders = 1 THEN 'One-time customer'
    WHEN total_orders = 2 THEN 'Two orders'
    ELSE 'Three or more orders'
  END AS customer_type,
  COUNT(*) AS customer_count
FROM
  customer_orders
GROUP BY
  customer_type
ORDER BY
  customer_count DESC;