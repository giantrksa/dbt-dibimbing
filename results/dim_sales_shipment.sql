{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT
    ship_city,
    ship_state,
    ship_country,
    ship_postal_code
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['ship_city', 'ship_state', 'ship_country', 'ship_postal_code']) }} AS shipment_id, 
  *
FROM t_data
