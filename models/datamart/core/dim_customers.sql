
WITH customers              AS (

    SELECT
        id                                                      AS customer_id,
        first_name,
        last_name

    FROM {{ ref('src_customers') }}

),

orders                      AS (

    SELECT
        id                                                      AS order_id,
        customer_id,
        order_date,
        status
    FROM {{ ref('src_orders') }}

),

payments_stripe             AS (
    SELECT 
          order_id,
          amount
    FROM {{ ref('src_payments_stripe') }}

),
customer_payments           AS (
    SELECT
        c.customer_id,
        SUM(amount)                                             AS total_spent 
    FROM customers c
    LEFT JOIN orders o 
        ON c.customer_id = o.customer_id
    LEFT JOIN payments_stripe ps
        ON o.order_id = ps.order_id
    GROUP BY 1
),

customer_orders             AS (

    SELECT
        customer_id,

        min(order_date)                                         AS first_order_date,
        max(order_date)                                         AS most_recent_order_date,
        count(order_id)                                         AS number_of_orders

    FROM orders

    GROUP BY 1

),


final                       AS (

    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0)           AS number_of_orders,
        coalesce(customer_payments.total_spent,  0)             AS total_spent
    FROM customers
    LEFT JOIN customer_orders USING (customer_id)
    LEFT JOIN customer_payments USING (customer_id)

)

SELECT * FROM final                