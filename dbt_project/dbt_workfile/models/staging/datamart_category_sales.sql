
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

-- datamart_monthly_category_sold
WITH category_sales AS (
  SELECT
    p."categoryID",
  	p."categoryName",
    o."orderDate"::timestamp,
    oi."quantity"
  FROM
    dwh.dim_products p
    JOIN dwh.fact_orderdetails oi ON p."productID" = oi."productID"
    JOIN dwh.fact_orders o ON oi."orderID" = o."orderID"
)
SELECT
  "categoryID",
  "categoryName",
  DATE_TRUNC('month', "orderDate") AS month,
  SUM("quantity") AS total_quantity_sold
FROM
  category_sales
GROUP BY
  1,2,3
ORDER BY 
  total_quantity_sold DESC

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
