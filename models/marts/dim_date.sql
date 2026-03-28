with orders as (
    select distinct
        cast(order_purchase_timestamp as date) as order_date
    from {{ ref('stg_orders') }}
    where order_purchase_timestamp is not null
)
select
    order_date                              as date_key,
    year(order_date)                        as year,
    month(order_date)                       as month,
    day(order_date)                         as day,
    quarter(order_date)                     as quarter,
    monthname(order_date)                   as month_name,
    dayname(order_date)                     as day_of_week,
    case when dayofweek(order_date) in (1,7)
         then true else false end           as is_weekend
from orders