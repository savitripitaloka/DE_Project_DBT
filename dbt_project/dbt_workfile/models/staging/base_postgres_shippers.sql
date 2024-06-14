with source as (
      select * from {{ source('postgres', 'shippers') }}
),
Shipper AS (
	SELECT* FROM source
)
select * from Shipper
  