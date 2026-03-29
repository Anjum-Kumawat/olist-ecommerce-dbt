# 🛒 Olist E-Commerce — Star Schema Pipeline

A production-grade data engineering project implementing a **Star Schema Architecture** 
on the Olist Brazilian E-Commerce dataset — Snowflake + dbt + Power BI, with an 
interactive Power BI dashboard connected via **DirectQuery**.

---

## 🔍 Project Overview

This project builds a fully automated data pipeline that ingests 9 CSV datasets 
(100K+ orders), transforms them through staging and marts layers using dbt, and 
delivers analytics-ready data in a Power BI dashboard.

Key questions answered by this project:
- Which product categories generate the most revenue?
- Which Brazilian states have the most customers and sellers?
- What is the average delivery time and how does it affect review scores?
- How do payment methods distribute across orders?

---

## 🏗️ Architecture
```
CSV Files (9 datasets)
        ↓
Snowflake RAW Schema (9 tables · 600K+ rows)
        ↓
dbt STAGING Layer (9 views · cleaning & renaming)
        ↓
dbt MARTS Layer (Star Schema · 1 fact + 5 dims)
        ↓
Power BI Dashboard (3 pages · DirectQuery)
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Cloud DWH | Snowflake (eu-central-2, Switzerland) |
| Transformation | dbt-core 1.11.7 + dbt-snowflake 1.11.3 |
| Packages | dbt_utils 1.3.0 |
| Visualization | Power BI Desktop (DirectQuery) |
| Language | SQL, DAX |
| Version Control | Git + GitHub |

---

## ⭐ Star Schema
```
                    dim_customer  (99,441 rows)
                    dim_product   (32,951 rows)
fact_orders    →    dim_seller    (6,190 rows)
(112,650 rows)      dim_date      (634 rows)
                    dim_payment   (103,886 rows)
```

**Fact table grain:** one row per order item

---

## 📁 Project Structure
```
olist_dbt/
├── models/
│   ├── staging/
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
│   └── marts/
│       ├── schema.yml
│       ├── fact_orders.sql
│       ├── dim_customer.sql
│       ├── dim_product.sql
│       ├── dim_seller.sql
│       ├── dim_date.sql
│       └── dim_payment.sql
├── macros/
│   └── generate_schema_name.sql
├── dashboard/
│   └── Olist_Ecommerce_Dashboard.pbix
├── packages.yml
└── dbt_project.yml
```

---

## 📊 Power BI Dashboard

Dashboard connected to Snowflake via DirectQuery.

| Page | Key Visuals |
|---|---|
| Sales Overview | KPI cards, Revenue trend, Category bar chart, Payment donut |
| Customer Analysis | Orders by state, Order status, Monthly trend |
| Product & Seller Performance | Top categories, Seller revenue, Delivery vs Review scatter |

---

## 🔑 Key Findings

- **São Paulo (SP)** dominates both customers and sellers
- **Credit card** is used in ~74.5% of all orders
- **Health & Beauty** is the top revenue-generating category
- Average delivery time is **12.41 days**
- Order volume peaked in **late 2017 / early 2018**

---

## ▶️ How to Run

**Prerequisites:**
- Snowflake account (free trial available)
- Python 3.11+
- Power BI Desktop (free download)

**Steps:**

1. Clone the repo
```bash
git clone https://github.com/Anjum-Kumawat/olist-ecommerce-dbt.git
cd olist-ecommerce-dbt
```

2. Install dbt
```bash
pip install dbt-snowflake
```

3. Configure your profile at `~/.dbt/profiles.yml`
```yaml
olist_dbt:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your-account>
      user: <your-user>
      password: <your-password>
      role: ACCOUNTADMIN
      warehouse: COMPUTE_WH
      database: OLIST_DB
      schema: STAGING
      threads: 4
```

4. Run dbt
```bash
dbt debug    # test connection
dbt run      # build all 15 models
dbt test     # run 15 data tests
```

5. Open Power BI Dashboard
```
dashboard/Olist_Ecommerce_Dashboard.pbix
```

---

## 👤 Author

**Anjum Kumawat**
- M.Sc. Data Engineering & Cloud Computing — Aivancity Paris
- Ex-IIIT Bangalore
- 📧 anjumkumawat04@gmail.com
- [LinkedIn](https://linkedin.com/in/anjum-kumawat) · [GitHub](https://github.com/Anjum-Kumawat)

---

## 📦 Dataset

- **Source**: [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size**: 9 CSV files · 100K+ orders · 2016–2018
- **License**: CC BY-NC-SA 4.0

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
