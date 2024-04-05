{%- macro flattern_obs(table_name,fields) %}
WITH translation AS (
    SELECT json_object_agg(lower(swahili), english) AS "get" FROM translations.addo
),

value_cte AS(
    SELECT
        tb.base_entity_id,
        tb.event_date::TIMESTAMP,
        tb.team,
        tb.child_location_id,
        tb.location_id,
        tb.provider_id,
        tb.server_version,
        tb.date_created::TIMESTAMP,
        tb.id,
        coalesce( obs._value -> 'humanReadableValues' ->> 0, obs._value -> 'values' ->> 0) AS _val,
        obs._value ->> 'formSubmissionField' AS _col 
    FROM {{ source('afyatek_data', table_name) }} AS tb,
    LATERAL  jsonb_array_elements(tb.obs) AS obs (_value)
)

SELECT
    obs.base_entity_id,
    obs.event_date::TIMESTAMP,
    obs.team,
    obs.child_location_id,
    obs.location_id,
    obs.provider_id,
    obs.server_version,
    obs.date_created::TIMESTAMP,
{%- for field in fields %}
    {{ obs_column(field) }}
{%- endfor %}
    obs.id
FROM value_cte AS obs
    INNER JOIN translation AS dict ON TRUE
GROUP BY obs.base_entity_id, obs.event_date, obs.team, obs.child_location_id,
    obs.location_id, obs.provider_id, obs.server_version, obs.date_created, obs.id
{%- endmacro %}
