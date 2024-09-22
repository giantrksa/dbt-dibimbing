{{ config(materialized='table') }}

WITH raw_data AS (
  SELECT
    order_id,
    date AS order_date,
    status AS order_status,
    fulfilment,
    fulfilled_by,
    style,
    sku,
    promotion_ids,
    sales_channel,
    ship_city,
    ship_state,
    ship_country,
    ship_postal_code,
    amount,
    qty AS quantity
  FROM `rapid-access-368009.dibimbing.amazon_sale_report`
),

fact_data AS (
  SELECT
    raw_data.order_id,
    raw_data.order_date,
    raw_data.order_status,
    df.fulfilment_id,
    dp.product_id,
    ds.shipment_id,
    dsc.sales_channel_id,
    dpr.promotion_id,
    raw_data.amount,
    raw_data.quantity
  FROM raw_data
  LEFT JOIN {{ ref('dim_fulfilment') }} df 
    ON raw_data.fulfilment = df.fulfilment 
    AND raw_data.fulfilled_by = df.fulfilled_by
  LEFT JOIN {{ ref('dim_product') }} dp 
    ON raw_data.sku = dp.sku
  LEFT JOIN {{ ref('dim_sales_shipment') }} ds 
    ON raw_data.ship_city = ds.ship_city
    AND raw_data.ship_state = ds.ship_state
    AND raw_data.ship_country = ds.ship_country
    AND raw_data.ship_postal_code = ds.ship_postal_code
  LEFT JOIN {{ ref('dim_sales_channel') }} dsc 
    ON raw_data.sales_channel = dsc.sales_channel
  LEFT JOIN {{ ref('dim_promotion') }} dpr 
    ON raw_data.promotion_ids = dpr.promotion_ids
)

SELECT * FROM fact_data
