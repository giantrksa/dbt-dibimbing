{{ config(materialized='table') }}

SELECT 
  index, 
  order_id, 
  date,
  status,
  {{ dbt_utils.generate_surrogate_key(['sku']) }} AS product_id,
  {{ dbt_utils.generate_surrogate_key(['fulfilment', 'fulfilled_by']) }} AS fulfilment_id,
  qty,
  amount
FROM `rapid-access-368009.dibimbing.amazon_sale_report`
