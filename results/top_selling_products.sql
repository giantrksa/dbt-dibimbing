-- models/top_selling_products.sql

{{ config(materialized='table') }}

WITH fact_sales AS (
  SELECT 
    product_id,
    quantity
  FROM {{ ref('fact_salesorder') }}
),
product_details AS (
  SELECT 
    product_id,
    sku,
    style,
    category
  FROM {{ ref('dim_product') }}
)

SELECT 
  dp.sku,
  dp.style,
  dp.category,
  SUM(fs.quantity) AS total_quantity_sold
FROM fact_sales fs
JOIN product_details dp ON fs.product_id = dp.product_id
GROUP BY 
  dp.sku,
  dp.style,
  dp.category
ORDER BY total_quantity_sold DESC
