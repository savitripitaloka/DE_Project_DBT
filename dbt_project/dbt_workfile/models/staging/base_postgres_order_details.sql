with source as (
      select * from {{ source('postgres', 'order_details') }}
),
Orderdetail AS (
	SELECT* FROM source
)
select * from Orderdetail
  