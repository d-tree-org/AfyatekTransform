SELECT
    perfomance.*,
    chw.provider_id,
    chw."name",
    chw.phone_number,
    chw.network,
    chw.district_name,
    chw.village_name,
    v_breakdown.percentage,
    v_breakdown.amount
FROM {{ ref("chw_details") }} AS chw
LEFT JOIN {{ ref("chw_performance") }} AS perfomance
    ON chw.provider_id = perfomance.provider_id
LEFT JOIN {{ ref("p4p_breakdown") }} AS v_breakdown
    ON perfomance.visits BETWEEN v_breakdown.low AND v_breakdown.up
        AND v_breakdown.category = 'visit'
LEFT JOIN {{ ref("p4p_breakdown") }} AS r_breakdown
    ON perfomance.registration BETWEEN r_breakdown.low AND r_breakdown.up
        AND v_breakdown.category = 'registration'
