{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT
    style,
    sku,
    category,
    size
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['sku']) }} AS product_id, 
  *
FROM t_data
