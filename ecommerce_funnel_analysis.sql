--1. Funnel Stage Count

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `ecommerce-analysis-499916.ecommerce_table.user_events`
)

SELECT *
FROM funnel_stages;

--2. Funnel Conversion Rates

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `ecommerce-analysis-499916.ecommerce_table.user_events`
)

SELECT
    *,
    ROUND(100.0 * carts / views, 2) AS view_to_cart_rate,
    ROUND(100.0 * checkouts / carts, 2) AS cart_to_checkout_rate,
    ROUND(100.0 * payments / checkouts, 2) AS checkout_to_payment_rate,
    ROUND(100.0 * purchases / payments, 2) AS payment_to_purchase_rate,
    ROUND(100.0 * purchases / views, 2) AS overall_conversion_rate
FROM funnel_stages;

--3. Funnel by Traffic Source

WITH source_funnel AS (
    SELECT
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `ecommerce-analysis-499916.ecommerce_table.user_events`
    GROUP BY traffic_source
)

SELECT
    *,
    ROUND(100.0 * carts / NULLIF(views,0), 2) AS view_to_cart_rate,
    ROUND(100.0 * checkouts / NULLIF(carts,0), 2) AS cart_to_checkout_rate,
    ROUND(100.0 * payments / NULLIF(checkouts,0), 2) AS checkout_to_payment_rate,
    ROUND(100.0 * purchases / NULLIF(payments,0), 2) AS payment_to_purchase_rate
FROM source_funnel
ORDER BY purchases DESC;

--4. Cart Abandonment

WITH user_funnel AS (
    SELECT
        user_id,
        MAX(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS carted,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM `ecommerce-analysis-499916.ecommerce_table.user_events`
    GROUP BY user_id
)

SELECT
    COUNT(CASE WHEN carted = 1 THEN 1 END) AS users_entered_cart,
    COUNT(CASE WHEN carted = 1 AND purchased = 1 THEN 1 END) AS purchased_after_cart,
    COUNT(CASE WHEN carted = 1 AND purchased = 0 THEN 1 END) AS cart_abandonment_users,
    ROUND(
        100.0 * COUNT(CASE WHEN carted = 1 AND purchased = 0 THEN 1 END)
        / COUNT(CASE WHEN carted = 1 THEN 1 END),
        2
    ) AS cart_abandonment_rate
FROM user_funnel;

--5. Checkout Abandonment

WITH user_funnel AS (
    SELECT
        user_id,
        MAX(CASE WHEN event_type = 'checkout_start' THEN 1 ELSE 0 END) AS checkouted,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM `ecommerce-analysis-499916.ecommerce_table.user_events`
    GROUP BY user_id
)

SELECT
    COUNT(CASE WHEN checkouted = 1 THEN 1 END) AS users_entered_checkout,
    COUNT(CASE WHEN checkouted = 1 AND purchased = 1 THEN 1 END) AS purchased_after_checkout,
    COUNT(CASE WHEN checkouted = 1 AND purchased = 0 THEN 1 END) AS checkout_abandonment_users,
    ROUND(
        100.0 * COUNT(CASE WHEN checkouted = 1 AND purchased = 0 THEN 1 END)
        / COUNT(CASE WHEN checkouted = 1 THEN 1 END),
        2
    ) AS checkout_abandonment_rate
FROM user_funnel;
