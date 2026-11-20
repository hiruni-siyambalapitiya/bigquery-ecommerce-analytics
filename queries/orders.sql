SELECT *
FROM `hiruni-bigquery-learning.olist_ecommerce.orders`
LIMIT 10;

SELECT
  COUNT(*) AS total_orders
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders`;

  #Check the order statuses

  SELECT
  order_status,
  COUNT(*) AS total_orders
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders`
GROUP BY
  order_status
ORDER BY
  total_orders DESC;

  SELECT
  table_name
FROM
  `hiruni-bigquery-learning.olist_ecommerce.INFORMATION_SCHEMA.TABLES`;

 #Calculate the total number of orders by status
SELECT
  order_status,
  COUNT(*) AS total_orders,
  ROUND(
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders`
GROUP BY
  order_status
ORDER BY
  total_orders DESC;

#Analyse monthly order trends

SELECT
  FORMAT_DATE(
    '%Y-%m',
    DATE_TRUNC(DATE(order_purchase_timestamp), MONTH)
  ) AS order_month,
  COUNT(*) AS total_orders
FROM
  `hiruni-bigquery-learning.olist_ecommerce.orders`
GROUP BY
  order_month
ORDER BY
  order_month;