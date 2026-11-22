CREATE OR REPLACE VIEW `hiruni-bigquery-learning.olist_ecommerce.products_english` AS
SELECT
  p.*,
  COALESCE(t.product_category_name_english,
           p.product_category_name,
           'Unknown') AS category
FROM `hiruni-bigquery-learning.olist_ecommerce.products` AS p
LEFT JOIN `hiruni-bigquery-learning.olist_ecommerce.product_category_name_translation` AS t
  ON p.product_category_name = t.product_category_name;


  SELECT * FROM `hiruni-bigquery-learning.olist_ecommerce.product_category_name_translation` LIMIT 5;


CREATE OR REPLACE VIEW `hiruni-bigquery-learning.olist_ecommerce.products_english` AS
SELECT
  p.*,
  COALESCE(t.string_field_1,
           p.product_category_name,
           'Unknown') AS category
FROM `hiruni-bigquery-learning.olist_ecommerce.products` AS p
LEFT JOIN (
  SELECT string_field_0, string_field_1
  FROM `hiruni-bigquery-learning.olist_ecommerce.product_category_name_translation`
  WHERE string_field_0 <> 'product_category_name'
) AS t
  ON p.product_category_name = t.string_field_0;

SELECT COUNT(*) FROM `hiruni-bigquery-learning.olist_ecommerce.products`;
SELECT COUNT(*) FROM `hiruni-bigquery-learning.olist_ecommerce.products_english`;

SELECT category, COUNT(*) AS products
FROM `hiruni-bigquery-learning.olist_ecommerce.products_english`
GROUP BY category
ORDER BY products DESC
LIMIT 10;