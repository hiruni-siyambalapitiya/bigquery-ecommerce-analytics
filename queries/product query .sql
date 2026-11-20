#Check the product table

SELECT *
FROM
  `hiruni-bigquery-learning.olist_ecommerce.products`
LIMIT 10;

#Analyse sales by product category

SELECT
  COALESCE(p.product_category_name, 'Unknown / Not Available') AS product_category,
  COUNT(*) AS items_sold,
  COUNT(DISTINCT oi.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_sales,
  ROUND(AVG(oi.price), 2) AS average_item_price
FROM
  `hiruni-bigquery-learning.olist_ecommerce.order_items` AS oi
LEFT JOIN
  `hiruni-bigquery-learning.olist_ecommerce.products` AS p
ON
  oi.product_id = p.product_id
GROUP BY
  product_category
ORDER BY
  total_sales DESC
LIMIT 15;

#Prepare our dashboard KPIs

SELECT
  FORMAT_DATE(
    '%Y-%m',
    DATE(o.order_purchase_timestamp)
  ) AS sales_month,
  COUNT(DISTINCT oi.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_sales,
  ROUND(AVG(oi.price), 2) AS average_item_price
FROM
  `hiruni-bigquery-learning.olist_ecommerce.order_items` AS oi
INNER JOIN
  `hiruni-bigquery-learning.olist_ecommerce.orders` AS o
ON
  oi.order_id = o.order_id
GROUP BY
  sales_month
ORDER BY
  sales_month;