

    WITH stg_payments_stripe AS (
        SELECT *
        FROM {{ ref('stg_payments_stripe') }}
    ),
    stg_orders              AS (
        SELECT *
        FROM {{ ref('stg_orders') }}
    ),
    fact_orders             AS (
        SELECT 
            o.order_id,
            o.customer_id,
            sum(case when status = 'success' then ps.amount end)
        FROM stg_orders o
        LEFT JOIN stg_payments_stripe ps 
            ON o.order_id = ps.order_id
        GROUP BY 1,2
    )
    SELECT * 
    FROM fact_orders