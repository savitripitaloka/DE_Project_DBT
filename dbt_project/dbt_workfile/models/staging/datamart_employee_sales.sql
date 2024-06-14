
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

-- datamart_monthly_best_employee
WITH employee_sales AS (
  SELECT
    e."employeeID",
  	e."fullname",
    o."orderDate"::timestamp,
    (oi."unitPrice" - (oi."unitPrice" * oi."discount")) * oi."quantity" AS gross_revenue
  FROM
    dwh. dim_employees e
    JOIN dwh.fact_orders o ON e."employeeID" = o."employeeID"
    JOIN dwh.fact_orderdetails oi ON o."orderID" = oi."orderID"
)
SELECT
  "employeeID",
  "fullname",
  DATE_TRUNC('month', "orderDate") AS month,
  SUM(gross_revenue) AS total_gross_revenue
FROM
  employee_sales
GROUP BY
  1,2,3
ORDER BY
  total_gross_revenue DESC

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
