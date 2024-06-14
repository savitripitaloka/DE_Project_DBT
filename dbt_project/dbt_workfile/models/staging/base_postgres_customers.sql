with source as (
      select * from {{ source('postgres', 'customers') }}
),
Customer AS (
	SELECT* FROM source
)
select * from Customer
  