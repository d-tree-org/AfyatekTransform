SELECT
    ahvfm.location_id,
    ahvfm.event_date,
    ahvfm.client_type,
    ahvfm.ward_id,
    ahvfm.ward_name,
    ahvfm.district_id,
    ahvfm.district_name,
    coalesce(t2.english, ahvfm.source_selection_medicine) AS reason_for_selecting_addo,
    coalesce(t.english, ahvfm.source_medicine) AS source_of_meds,
    count(*) AS count
FROM
    afyatek_disf_data.chw_home_visit_meds AS ahvfm
LEFT JOIN translations.translations AS t
    ON
        ahvfm.source_medicine = t.swahili
LEFT JOIN translations.translations AS t2
    ON
        ahvfm.source_selection_medicine = t2.swahili
WHERE
    ahvfm.event_date >= '2024-03-01'
    AND ahvfm.source IS NOT null
GROUP BY
    reason_for_selecting_addo,
    source_of_meds,
    ahvfm.location_id,
    ahvfm.event_date,
    ahvfm.client_type,
    ahvfm.ward_id,
    ahvfm.ward_name,
    ahvfm.district_id,
    ahvfm.district_name
