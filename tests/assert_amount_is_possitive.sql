
SELECT 
    order_id,
    SUM(amount)         AS total_amount
FROM {{ ref('stg_payments_stripe')}}
GROUP BY order_id
HAVING SUM(amount) < 0