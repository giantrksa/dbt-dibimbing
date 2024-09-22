{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT
    sales_channel
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['sales_channel']) }} AS sales_channel_id, 
  sales_channel
FROM t_data
