with source as (
      select * from {{ source('postgres', 'products') }}
),
Product AS (
	SELECT 
    	p."productID",
    	p."productName", 
    	p."supplierID",
    	s."companyName",
    	p."categoryID",
    	c."categoryName",
    	p."quantityPerUnit",
    	p."unitsInStock",
    	p."unitsOnOrder",
    	p."reorderLevel",
    	p."discontinued"
    FROM source p
    LEFT JOIN suppliers s
    ON p."supplierID" = s."supplierID"
    LEFT JOIN categories c 
    ON p."categoryID" = c."categoryID"
    ORDER BY 1
)
select * from Products
  