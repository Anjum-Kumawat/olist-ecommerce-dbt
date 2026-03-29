# 🛒 Olist E-Commerce — End-to-End Data Pipeline

![Stack](https://img.shields.io/badge/Stack-Snowflake%20%7C%20dbt%20%7C%20Power%20BI-blue)
![dbt](https://img.shields.io/badge/dbt-1.11.7-orange)
![Models](https://img.shields.io/badge/Models-15%20PASS-brightgreen)
![Tests](https://img.shields.io/badge/Tests-15%20PASS-brightgreen)

## 📌 Project Overview

End-to-end data pipeline built on the **Olist Brazilian E-Commerce** dataset (Kaggle).
Raw CSV data ingested into Snowflake, transformed via dbt into a Star Schema, and
visualized in a 3-page Power BI dashboard connected via DirectQuery.

## 🏗️ Architecture
```
CSV Files (9 datasets, 100K+ orders)
        ↓
Snowflake RAW schema (9 tables, ~600K rows)
        ↓
dbt STAGING layer (9 views — cleaning & renaming)
        ↓
dbt MARTS layer (Star Schema — 1 fact + 5 dims)
        ↓
Power BI Dashboard (3 pages, DirectQuery)
```

## 🗂️ Star Schema
```
                    dim_customer
                    dim_product
fact_orders    →    dim_seller
                    dim_date
                    dim_payment
```

| Table | Rows | Description |
|---|---|---|
| `fact_orders` | 112,650 | Grain: one row per order item |
| `dim_customer` | 99,441 | Customer + geolocation |
| `dim_product` | 32,951 | Product + English category |
| `dim_seller` | 6,190 | Seller + geolocation |
| `dim_date` | 634 | Date spine from order timestamps |
| `dim_payment` | 103,886 | Payment type + installments |

## 🛠️ Tech Stack

| Layer | Tool |
|---|---|
| Cloud DWH | Snowflake (eu-central-2) |
| Transformation | dbt-core 1.11.7 + dbt-snowflake |
| Orchestration | Manual (Airflow-ready) |
| Visualization | Power BI Desktop (DirectQuery) |
| Language | SQL, DAX |
| Version Control | Git + GitHub |

## 📁 Project Structure
```
olist_dbt/
├── models/
│   ├── staging/          ← 9 stg_* views (cleaning)
│   │   ├── sources.yml
│   │   ├── stg_orders.sql
│   │   ├── stg_customers.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_order_payments.sql
│   │   ├── stg_order_reviews.sql
│   │   ├── stg_products.sql
│   │   ├── stg_sellers.sql
│   │   ├── stg_geolocation.sql
│   │   └── stg_product_category_translation.sql
│   └── marts/            ← Star schema tables
│       ├── schema.yml
│       ├── fact_orders.sql
│       ├── dim_customer.sql
│       ├── dim_product.sql
│       ├── dim_seller.sql
│       ├── dim_date.sql
│       └── dim_payment.sql
├── macros/
│   └── generate_schema_name.sql
├── packages.yml          ← dbt_utils 1.3.0
└── dbt_project.yml
```

## 📊 Power BI Dashboard (3 Pages)

### Page 1 — Sales Overview
- Total Revenue, Total Orders, Avg Order Value, Avg Delivery Days *(KPI Cards)*
- Total Orders by Date *(Line Chart)*
- Total Orders by Product Category *(Bar Chart)*
- Total Orders by Payment Type *(Donut Chart)*

### Page 2 — Customer Analysis
- Total Orders by Customer State *(Bar Chart)*
- Total Orders by Order Status *(Bar Chart)*
- Total Orders by Month *(Line Chart)*
- Total Revenue *(KPI Card)*

### Page 3 — Product & Seller Performance
- Total Revenue by Product Category *(Bar Chart)*
- Total Revenue by Seller State *(Bar Chart)*
- Avg Delivery Days vs Review Score *(Scatter Chart)*
- Avg Delivery Days, Total Orders *(KPI Cards)*

## 🔑 Key Insights

- **São Paulo (SP)** accounts for the largest share of both customers and sellers
- **Credit card** is the dominant payment method at ~74.5% of orders
- **Health & Beauty** is the top revenue-generating product category
- **Average delivery time** is 12.41 days across all orders
- Order volume peaks in **late 2017 / early 2018**

## ▶️ How to Run
```bash
# Install dependencies
pip install dbt-snowflake

# Navigate to project
cd olist_dbt

# Test connection
dbt debug

# Run all models
dbt run

# Run tests
dbt test
```

## 📦 Dataset

- **Source**: [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size**: 9 CSV files, 100K+ orders, 2016–2018
- **License**: CC BY-NC-SA 4.0

## 👤 Author

**Anjum Kumawat** — Data Analyst & Engineer
[GitHub](https://github.com/Anjum-Kumawat) · [LinkedIn](https://linkedin.com/in/anjum-kumawat)