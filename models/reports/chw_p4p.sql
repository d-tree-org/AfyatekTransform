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
    chw.provider_id,
    chw."name",
    chw.phone_number,
    chw.network,
    chw.district_name,
    chw.village_name,
    chv_performance.*,
    v_breakdown.percentage,
    v_breakdown.amount
FROM {{ ref("chw_details") }} AS chw
LEFT JOIN {{ ref("chw_perfomance") }} as perfomance
    ON chw.provider_id=perfomance.provider_id
LEFT JOIN breakdown AS v_breakdown
    ON perfomance.visits BETWEEN v_breakdown.low AND v_breakdown.up
LEFT JOIN breakdown AS r_breakdown
    ON perfomance.registration BETWEEN r_breakdown.low AND r_breakdown.up
