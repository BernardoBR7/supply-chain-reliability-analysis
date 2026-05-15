# supply-chain-reliability-analysis
Operational reliability analysis of a global supply chain dataset focused on delivery performance, SLA adherence, and systemic fulfillment challenges using PostgreSQL and Power BI.
# Supply Chain Performance Analytics — Project Pipeline

## 1. Data Acquisition
- Source: DataCo Supply Chain dataset (CSV, 180,519 rows × 53 columns)
- Encoding: cp1252 (Windows Latin, Spanish special characters)

## 2. Data Ingestion (Python)
- Loaded CSV into pandas DataFrame via `pd.read_csv()`
- Pushed raw data to PostgreSQL via `df.to_sql()` using SQLAlchemy
- Database: `supply_chain`, Table: `orders`

## 3. Data Cleaning (PostgreSQL)
- Created `orders_clean` table with the following fixes:
  - Dates cast from `text` → `timestamp`
  - `Late_delivery_risk` cast from `bigint` → `boolean`
  - Dropped: `Product Status` (constant 0), `Product Description` (empty), `Customer Zipcode`, `Order Zipcode` (incomplete, US only)
  - Added `shipping_mode_order` for custom sort logic
  - Renamed all columns to `snake_case`

## 4. Data Modeling & Analytical Preparation (PostgreSQL)  
  
- Built a star-schema-inspired analytical layer as PostgreSQL views on top of `orders_clean`:
  - `v_fact_orders` — central operational fact view with calculated fields (`profit_margin`, `shipping_delay_days`)
  - `v_dim_customers` — customer segments and geography
  - `v_dim_products` — product catalog and categories
  - `v_dim_shipping` — delivery performance

- Prepared cleaned and structured analytical views for direct Power BI integration

## 5. KPI Development & Dashboard Analytics (Power BI + DAX)
- Developed operational KPIs in Power BI using DAX, including:
  - Total Orders
  - Late Deliveries
  - Actual Late Delivery Rate
  - Average Shipping Delay
  - Expected vs Actual Shipping Time
- Iteratively refined KPIs and dashboard structure while investigating:
  - shipping-mode reliability
  - SLA adherence
  - operational persistence across business contexts
  - delivery risk versus actual delivery outcomes
- Used visual analytics to determine whether operational issues were:
  - localized
  - seasonal
  - category-specific
  - or systemic across the network

## 6. Key Findings
- 55% of all orders arrive late globally
- First Class shipping: 95% actual late delivery rate
- Late delivery rate flat at ~54-56% for 3 consecutive years
- Late delivery risk model predicts failures accurately — operational execution is the bottleneck, not data visibility

## Technologies Used
- Python · Pandas · SQLAlchemy
- PostgreSQL · SQL
- Power BI · DAX
