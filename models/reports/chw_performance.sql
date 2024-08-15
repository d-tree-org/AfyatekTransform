WITH visits AS (
    SELECT
        provider_id,
        count(*) AS visits,
        date_trunc('week', event_date) AS reported_week
    FROM {{ ref("all_home_visits") }}
    GROUP BY provider_id, reported_week
),

registration AS (
    SELECT
        provider_id,
        count(*) AS registrations,
        date_trunc('month', event_date) AS reported_week
    FROM {{ ref("all_registration") }}
    GROUP BY provider_id, reported_week
)

SELECT *
FROM visits 
FULL JOIN  registration 
    USING (provider_id, reported_week)
