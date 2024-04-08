{%- macro flattern_obs(table_name,fields) %}
    {%- set columns=['base_entity_id','event_date','team','child_location_id','location_id','provider_id',
    'date_created'] -%}
WITH translation AS (
    SELECT json_object_agg(lower(swahili), english) AS "get" FROM translations.addo
),

value_cte AS(
    SELECT
    {%- for column in columns %}
        tb.{{ column ~ ('::DATE' if 'date' in column ) }},
    {%- endfor %}
        tb.id,
        coalesce( obs._value -> 'humanReadableValues' ->> 0, obs._value -> 'values' ->> 0) AS _val,
        obs._value ->> 'formSubmissionField' AS _col 
    FROM {{ source('afyatek_data', table_name) }} AS tb,
    LATERAL  jsonb_array_elements(tb.obs) AS obs (_value)
    WHERE
        tb.event_date >= '2024-03-01'::date
)

SELECT
    {%- for field in fields %}
        {{ obs_column(field) }}
    {%- endfor %}
    {{ '\tobs.' ~ ',\n\tobs.'.join(columns) }},
    array_agg(distinct obs.id) AS event_ids
FROM value_cte AS obs
    INNER JOIN translation AS dict ON TRUE
GROUP BY {{ 'obs.' ~ ', obs.'.join(columns) }}
{%- endmacro %}
