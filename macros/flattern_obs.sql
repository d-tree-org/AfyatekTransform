{%- macro flattern_obs(table_name,fields) %}
WITH translation AS (
    SELECT json_object_agg(lower(swahili),english) as dict from translations.translations
)
SELECT
    tb.base_entity_id,
    tb.event_date::TIMESTAMP,
    tb.team,
    tb.child_location_id,
    tb.location_id,
    tb.provider_id,
    tb.server_version,
    tb.date_created::TIMESTAMP,
{%- for field in fields %}
    {{ obs_column(field,'obs._value') }}
{%- endfor %}
    tb.id
FROM {{ source('afyatek_data', table_name) }} AS tb,
    LATERAL  jsonb_array_elements(tb.obs) as obs (_value)
    INNER JOIN translation ON TRUE
GROUP BY tb.base_entity_id, tb.event_date, tb.team, tb.child_location_id,
    tb.location_id, tb.provider_id, tb.server_version, tb.date_created, tb.id
{%- endmacro %}
