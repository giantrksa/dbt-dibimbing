# Proyek Data Warehouse Skema Bintang

## Deskripsi Proyek

Proyek ini bertujuan untuk membangun sebuah **Data Warehouse** menggunakan **skema bintang (Star Schema)** yang berfokus pada data penjualan Amazon. Proyek ini melibatkan pembuatan tabel fakta dan tabel dimensi, serta melakukan berbagai analisis terkait penjualan, seperti identifikasi produk terlaris, analisis saluran penjualan, dan efektivitas promosi.

## Struktur Tabel

### 1. **Tabel Fakta:**

#### `fact_salesorder`
- **Deskripsi:** Menyimpan informasi transaksi penjualan.
- **Kolom Utama:**
  - `order_id` (Primary Key)
  - `order_date`
  - `order_status`
  - `amount`
  - `quantity`
- **Foreign Key:**
  - `product_id` (Referensi ke `dim_product`)
  - `fulfilment_id` (Referensi ke `dim_fulfilment`)
  - `promotion_id` (Referensi ke `dim_promotion`)
  - `shipment_id` (Referensi ke `dim_sales_shipment`)
  - `sales_channel_id` (Referensi ke `dim_sales_channel`)

### 2. **Tabel Dimensi:**

#### `dim_product`
- **Deskripsi:** Menyimpan informasi detail tentang produk.
- **Kolom Utama:**
  - `product_id` (Primary Key)
  - `style`
  - `sku`
  - `category`
  - `size`

#### `dim_fulfilment`
- **Deskripsi:** Menyimpan informasi metode pemenuhan pesanan.
- **Kolom Utama:**
  - `fulfilment_id` (Primary Key)
  - `fulfilment`
  - `fulfilled_by`

#### `dim_promotion`
- **Deskripsi:** Menyimpan informasi tentang promosi yang diterapkan pada pesanan.
- **Kolom Utama:**
  - `promotion_id` (Primary Key)
  - `promotion_ids`

#### `dim_sales_shipment`
- **Deskripsi:** Menyimpan informasi pengiriman.
- **Kolom Utama:**
  - `shipment_id` (Primary Key)
  - `ship_city`
  - `ship_state`
  - `ship_country`
  - `ship_postal_code`

#### `dim_sales_channel`
- **Deskripsi:** Menyimpan informasi tentang saluran penjualan.
- **Kolom Utama:**
  - `sales_channel_id` (Primary Key)
  - `sales_channel`

## Skema ERD

## Berikut adalah representasi skema bintang yang menghubungkan tabel fakta dengan tabel dimensi.

                            +----------------+
                            |  dim_product   |
                            +----------------+
                                    ^
                                    |
+----------------+ +----------------+ +---------------------+ +--------------------+ 
| dim_fulfilment | | dim_promotion | | dim_sales_shipment | | dim_sales_channel | 
+----------------+ +----------------+ +---------------------+ +--------------------+ 
                                ^ ^ ^ ^ 
                                | | | | 
                            +------------------+ 
                            | fact_salesorder  | 
                            +------------------+

