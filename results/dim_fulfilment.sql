{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT 
    fulfilment, 
    fulfilled_by
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['fulfilment', 'fulfilled_by']) }} AS fulfilment_id, 
  *
FROM t_data
