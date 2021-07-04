
WITH stg_payments_stripe AS (
	SELECT *
	FROM {{ ref('src_payments_stripe') }}
)
SELECT id,
		order_id,
		payment_method,
		amount
FROM stg_payments_stripe