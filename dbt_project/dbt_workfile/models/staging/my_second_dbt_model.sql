
-- Use the `ref` function to select from other models

-- models/staging/my_second_dbt_model.sql

WITH my_first_dbt_model AS (
    SELECT *
    FROM {{ ref('my_first_dbt_model') }}
)
SELECT *
FROM my_first_dbt_model

