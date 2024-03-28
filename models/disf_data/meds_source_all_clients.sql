SELECT
    chvm.location_id,
    chvm.event_date,
    chvm.client_type,
    chvm.ward_id,
    chvm.ward_name,
    chvm.district_id,
    chvm.district_name,
    coalesce(t.english, chvm.source_medicine) AS source_medicine,
    count(*) AS frequency
FROM
    {{ ref('chw_home_visit_meds') }} AS chvm
LEFT JOIN translations.translations AS t
    ON
        chvm.source_medicine = t.swahili
WHERE
    chvm.event_date >= '2024-03-01'
GROUP BY
    coalesce(t.english, chvm.source_medicine),
    chvm.location_id,
    chvm.event_date,
    chvm.client_type,
    chvm.ward_id,
    chvm.ward_name,
    chvm.district_id,
    chvm.district_name
