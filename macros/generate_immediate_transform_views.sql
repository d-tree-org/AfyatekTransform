{% macro generate_immediate_transform_views(table_name) %}
SELECT
    g.id,
    g.base_entity_id,
    g.entity_type,
    g.event_date,
    g.event_type,
    g.team,
    g.location_id,
    g.child_location_id,
    g.provider_id,
    g.server_version,
    g.date_created,
    uuid_generate_v4() AS unique_id,
    (observations.value -> 'values'::text) ->> 0 AS value_,
    observations.value ->> 'formSubmissionField'::text AS formsubmissionfield_,
    (observations.value -> 'humanReadableValues'::text) ->> 0 AS humanreadablevalues_,
    observations.value ->> 'set'::text AS set_,
    observations.value -> 'fieldCode'::text AS fieldcode,
    observations.value -> 'fieldType'::text AS fieldtype,
    observations.value -> 'parentCode'::text AS parentcode,
    observations.value -> 'fieldDataType'::text AS fielddatatype
FROM {{ source('afyatek_data', table_name) }} AS g,
    LATERAL jsonb_array_elements(g.obs) AS observations (value)
{% endmacro %}