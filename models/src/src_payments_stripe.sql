{{ config(
	schema = 'source'
) }}



WITH payments_stripe AS (
	SELECT *
	FROM {{ source('RAW','raw_payments') }}
)
SELECT id,
		order_id,
		payment_method,
		amount
FROM payments_stripe
