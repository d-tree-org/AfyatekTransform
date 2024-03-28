WITH unnested_anc AS (
    SELECT
        ahvfm.location_id,
        ahvfm.event_date::date,
        ahvfm.client_type,
        ahvfm.ward_id,
        ahvfm.ward_name,
        ahvfm.district_id,
        ahvfm.district_name,
        unnest(string_to_array(
            ahvfm.medication_used_currently,
            '~'
        )) AS medicines
    FROM
        {{ ref('chw_home_visit_meds') }} AS ahvfm
    WHERE
        ahvfm.event_date >= '2024-03-2'
)

SELECT
    medicines,
    location_id,
    event_date,
    count(*) AS count
FROM
    unnested_anc
GROUP BY
    medicines,
    location_id,
    event_date,
    client_type,
    ward_id,
    ward_name,
    district_id,
    district_name
