{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT 
    promotion_ids
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['promotion_ids']) }} AS promotion_id, 
  promotion_ids
FROM t_data
