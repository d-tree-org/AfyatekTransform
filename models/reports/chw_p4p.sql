{{- config(
    materialized="materialized_view",
    on_configuration_change="apply",
    indexes=[{
        "columns": ['provider_id','phone_number','location_id','reported_week'],
            "unique": true, 'type': 'btree' }]
) -}}
SELECT
    chw.provider_id,
    chw.location_id,
    chw."name",
    chw.phone_number,
    chw.network,
    chw.district_name,
    chw.village_name,
    performance.visits,
    performance.visits_targed_reached,
    v_breakdown.amount AS visit_amount,
    performance.registrations,
    performance.registration_targed_reached,
    r_breakdown.amount AS registration_amount,
    performance.reported_week,
    coalesce(r_breakdown.amount, 0)
    + coalesce(v_breakdown.amount, 0) AS total_amount
FROM {{ ref("chw_details") }} AS chw
LEFT JOIN {{ ref("chw_performance") }} AS performance
    ON chw.provider_id = performance.provider_id
LEFT JOIN {{ ref("p4p_breakdown") }} AS v_breakdown
    ON performance.visits BETWEEN v_breakdown.lower_limit
        AND v_breakdown.upper_limit
        AND v_breakdown.category = 'visit'
LEFT JOIN {{ ref("p4p_breakdown") }} AS r_breakdown
    ON performance.registrations BETWEEN r_breakdown.lower_limit
        AND r_breakdown.upper_limit
        AND r_breakdown.category = 'registration'
