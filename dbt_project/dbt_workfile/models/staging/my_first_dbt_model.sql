
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

-- datamart_monthly_supplier_gross_revenue
WITH supplier_orders AS (
  SELECT
    p."supplierID",
    p."companyName",
    o."orderDate"::timestamp,
    oi."unitPrice",
    oi."quantity",
    oi."discount",
    (oi."unitPrice" - (oi."unitPrice" * oi."discount")) * oi."quantity" AS gross_revenue
  FROM
    dwh.dim_products p
    JOIN dwh.fact_orderdetails oi ON oi."productID" = p."productID"
    JOIN dwh.fact_orders o ON oi."orderID" = o."orderID"
)
SELECT
  s."supplierID",
  s."companyName",
  DATE_TRUNC('month', "orderDate") AS month,
  SUM(gross_revenue) AS total_gross_revenue
FROM
  supplier_orders s
GROUP BY
  1,2,3
ORDER BY 
  2


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
