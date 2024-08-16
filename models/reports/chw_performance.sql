{{- config(
    materialized="materialized_view",
    on_configuration_change="apply",
    indexes=[{
        "columns": ['provider_id','visits','registrations','reported_week'],
            "unique": true, 'type': 'btree' }]
) -}}
WITH visits AS (
    SELECT
        provider_id,
        count(*) AS visits,
        date_trunc('week', event_date) AS reported_week
    FROM {{ ref("all_home_visits") }}
    GROUP BY provider_id, reported_week
),

registrations AS (
    SELECT
        provider_id,
        count(*) AS registrations,
        date_trunc('week', event_date) AS reported_week
    FROM {{ ref("all_registration") }}
    GROUP BY provider_id, reported_week
)

SELECT
    registrations.registrations,
    visits.visits,
    v_breakdown.achieved AS visits_targed_reached,
    r_breakdown.achieved AS registration_targed_reached,
    coalesce(visits.provider_id, registrations.provider_id) AS provider_id,
    coalesce(visits.reported_week, registrations.reported_week) AS reported_week

FROM visits
FULL JOIN registrations
    ON visits.provider_id = registrations.provider_id
        AND visits.reported_week = registrations.reported_week
LEFT JOIN {{ ref("p4p_breakdown") }} AS v_breakdown
    ON visits.visits BETWEEN v_breakdown.lower_limit
        AND v_breakdown.upper_limit
        AND v_breakdown.category = 'visit'
LEFT JOIN {{ ref("p4p_breakdown") }} AS r_breakdown
    ON registrations.registrations BETWEEN r_breakdown.lower_limit
        AND r_breakdown.upper_limit
        AND r_breakdown.category = 'registration'
