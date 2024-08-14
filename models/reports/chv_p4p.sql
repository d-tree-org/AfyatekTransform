WITH breakdown(
    low,
    up,
    visit_percentage,
    visit_amount,
    registration_percentage,
    registration_amounts
) AS (
    VALUES
    (81, 100000000, '100%', '60,000', '100%', '60,000'),
    (61, 80, '80%', '45,000', '75%', '45,000'),
    (41, 60, '60%', '30,000', '50%', '30,000'),
    (21, 40, '40%', '15,000', '25%', '15,000'),
    (11, 20, '20%', '5,000', 'Below 20%', '0'),
    (0, 19, '0%', '0', 'Below 20%', '0')
)

SELECT
    chv_performance.*,
    v_breakdown.percentage,
    v_breakdown.amount
FROM {{ ref("chv_performance") }}
LEFT JOIN breakdown AS v_breakdown
    ON chv_performance.visits BETWEEN v_breakdown.low AND v_breakdown.up
LEFT JOIN breakdown AS r_breakdown
    ON chv_performance.registration BETWEEN r_breakdown.low AND r_breakdown.up
