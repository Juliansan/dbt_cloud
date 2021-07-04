
WITH stg_orders AS (
	SELECT *
	FROM {{ ref('src_orders') }}
)
SELECT id               AS order_id,
		customer_id,
		order_date,
		status
FROM stg_orders