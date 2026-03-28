with orders as (
    select * from {{ ref('stg_orders') }}
),
order_items as (
    select * from {{ ref('stg_order_items') }}
),
reviews as (
    select
        order_id,
        review_score,
        review_answer_timestamp,
        row_number() over (partition by order_id order by review_answer_timestamp desc) as rn
    from {{ ref('stg_order_reviews') }}
    qualify rn = 1
),
payments as (
    select
        order_id,
        sum(payment_value)          as payment_value,
        max(payment_installments)   as payment_installments,
        max(payment_type)           as payment_type
    from {{ ref('stg_order_payments') }}
    group by order_id
)
select
    -- keys
    {{ dbt_utils.generate_surrogate_key(['oi.order_id', 'oi.order_item_id']) }}
                                        as order_key,
    o.customer_id                       as customer_key,
    oi.product_id                       as product_key,
    oi.seller_id                        as seller_key,
    cast(o.order_purchase_timestamp as date) as date_key,

    -- measures
    oi.price,
    oi.freight_value,
    p.payment_value,
    p.payment_installments,
    p.payment_type,
    o.order_status,
    r.review_score,
    o.delivery_days,
    o.estimated_delivery_days

from order_items oi
left join orders o          on oi.order_id = o.order_id
left join reviews r         on oi.order_id = r.order_id
left join payments p        on oi.order_id = p.order_id