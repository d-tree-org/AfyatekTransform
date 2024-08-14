WITH visits AS (
    SELECT
        provider_id,
        count(*) AS visits,
        date_trunc('month', event_date) AS reported_month
    FROM {{ ref("all_home_visits") }}
    GROUP BY provider_id, reported_month
),

registration AS (
    SELECT
        provider_id,
        count(*) AS registrations,
        date_trunc('month', event_date) AS reported_month
    FROM {{ ref("all_registration") }}
    GROUP BY provider_id, reported_month
)

SELECT *
FROM  visits 
FULL JOIN  registration 
    USING (provider_id, reported_month)
