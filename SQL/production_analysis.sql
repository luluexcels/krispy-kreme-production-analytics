-- 1. Production and inventory summary by donut variety

SELECT
    p.donut_variety,

    SUM(op.trays_produced * p.tray_capacity)
        AS total_units_produced,

    SUM(op.trays_leftover * p.tray_capacity)
        AS total_units_leftover,

    ROUND(
        100.0 * SUM(op.trays_leftover)
        / NULLIF(SUM(op.trays_produced), 0),
        2
    ) AS first_shift_leftover_percentage

FROM fact_daily_operations op

JOIN dim_products p
    ON op.product_id = p.product_id

GROUP BY p.donut_variety

ORDER BY total_units_produced DESC;

-- 2. Daily production trends

SELECT
    op.date,

    SUM(op.trays_produced * p.tray_capacity)
        AS total_units_produced,

    SUM(op.trays_leftover * p.tray_capacity)
        AS total_units_leftover

FROM fact_daily_operations op

JOIN dim_products p
    ON op.product_id = p.product_id

GROUP BY op.date

ORDER BY op.date;

-- 3. First-shift leftover analysis by donut variety

SELECT
    p.donut_variety,

    SUM(op.trays_produced) AS total_trays_produced,

    SUM(op.trays_leftover) AS total_trays_leftover,

    ROUND(
        100.0 * SUM(op.trays_leftover)
        / NULLIF(SUM(op.trays_produced), 0),
        2
    ) AS leftover_percentage

FROM fact_daily_operations op

JOIN dim_products p
    ON op.product_id = p.product_id

GROUP BY p.donut_variety

ORDER BY leftover_percentage DESC;

