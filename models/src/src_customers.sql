WITH customers AS (
	SELECT *
	FROM "RAW".raw_customers
)
SELECT id,
		first_name,
		last_name
FROM customers