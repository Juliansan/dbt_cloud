{{ config(
	schema = 'source'
) }}



WITH customers AS (
	SELECT *
	FROM {{ source('RAW','raw_customers') }}
	--{{ target.schema }} 
)
SELECT id,
		first_name,
		last_name
FROM customers
