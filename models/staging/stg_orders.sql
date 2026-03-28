with source as (
    select * from {{ source('raw', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        -- computed fields
        datediff('day',
            order_purchase_timestamp,
            order_delivered_customer_date
        ) as delivery_days,

        datediff('day',
            order_purchase_timestamp,
            order_estimated_delivery_date
        ) as estimated_delivery_days

    from source
    where order_purchase_timestamp is not null
)

select * from renamed