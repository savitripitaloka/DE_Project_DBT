with source as (
      select * from {{ source('postgres', 'employees') }}
),
EmployeeDetails AS (
    SELECT 
    	e."employeeID",
    	CONCAT(e."lastName",' ',e."firstName") AS fullName, 
    	MIN(e."title") AS title,
    	e."birthDate",
    	MIN(e."hireDate") AS hireDate,
    	MIN(e."address") AS address,
    	MIN(t."territoryID") AS territoryID,
    	MIN(e."city") AS city,
    	MIN(r."regionID") AS regionID,
    	MIN(r."regionDescription") AS regionDescription  
    FROM source e
    LEFT JOIN employee_territories et 
    ON e."employeeID" = et."employeeID"
    LEFT JOIN territories t 
    ON et."territoryID" = t."territoryID"
    LEFT JOIN regions r 
    ON t."regionID" = r."regionID"
    GROUP BY  e."employeeID",
    		  CONCAT(e."lastName",' ',e."firstName"),
    		  e."birthDate",
    		  e."city"
    ORDER BY e."employeeID"
)
select * from EmployeeDetails
  