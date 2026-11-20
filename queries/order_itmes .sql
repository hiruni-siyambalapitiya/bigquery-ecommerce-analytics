#Check the order_items table

SELECT
  column_name,
  data_type
FROM
  `hiruni-bigquery-learning.olist_ecommerce.INFORMATION_SCHEMA.COLUMNS`
WHERE
  table_name = 'order_items'
ORDER BY
  ordinal_position;

#Calculate total sales revenue

SELECT
  COUNT(*) AS total_order_items,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT product_id) AS unique_products,
  ROUND(SUM(price), 2) AS total_sales_revenue,
  ROUND(SUM(freight_value), 2) AS total_freight_value,
  ROUND(AVG(price), 2) AS average_item_price
FROM
  `hiruni-bigquery-learning.olist_ecommerce.order_items`;

#Identify the top 10 products by sales value  

SELECT
  product_id,
  COUNT(*) AS items_sold,
  ROUND(SUM(price), 2) AS total_sales,
  ROUND(AVG(price), 2) AS average_price
FROM
  `hiruni-bigquery-learning.olist_ecommerce.order_items`
GROUP BY
  product_id
ORDER BY
  total_sales DESC
LIMIT 10;