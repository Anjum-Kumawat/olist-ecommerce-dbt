with sellers as (
    select * from {{ ref('stg_sellers') }}
),
geolocation as (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as geolocation_lat,
        avg(geolocation_lng) as geolocation_lng
    from {{ ref('stg_geolocation') }}
    group by geolocation_zip_code_prefix
)
select
    s.seller_id                     as seller_key,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    g.geolocation_lat,
    g.geolocation_lng
from sellers s
left join geolocation g
    on s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
qualify row_number() over (partition by s.seller_id order by s.seller_id) = 1