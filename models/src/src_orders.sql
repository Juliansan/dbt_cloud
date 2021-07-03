{{ config(
	schema = 'source'
) }}



WITH orders AS (
	SELECT *
	FROM {{ source('RAW','raw_orders') }}
	--{{ target.schema }} 
)
SELECT id,
		user_id,
		order_date,
		status
FROM orders
