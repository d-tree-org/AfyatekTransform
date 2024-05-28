SELECT
    chvm.location_id,
    chvm.event_date,
    chvm.client_type,
    chvm.ward_id,
    chvm.ward_name,
    chvm.district_id,
    chvm.district_name,
    coalesce(t.english, chvm.not_get_all_meds_reason) AS reason_not_getting_meds,
    count(*) AS count
FROM
    {{ ref('chw_home_visit_meds') }} AS chvm
INNER JOIN translations.translations AS t ON t.swahili = chvm.not_get_all_meds_reason
WHERE
    NOT chvm.get_all_meds
GROUP BY
    chvm.location_id,
    chvm.event_date,
    chvm.client_type,
    chvm.ward_id,
    chvm.ward_name,
    chvm.district_id,
    chvm.district_name,
    reason_not_getting_meds
