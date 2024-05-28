SELECT
    sum(coalesce(chvm.using_medication::INT, 0))::DECIMAL AS med_use_yes,
    chvm.client_type,
    chvm.location_id,
    chvm.ward_id,
    chvm.ward_name,
    chvm.district_id,
    chvm.district_name,
    sum((chvm.using_medication IS NOT null)::INT) AS med_use_asked,
    date_trunc('day', chvm.event_date::DATE) AS reported_date
FROM
    {{ ref('chw_home_visit_meds') }} AS chvm
WHERE chvm.using_medication IS NOT null
GROUP BY
    chvm.location_id,
    reported_date,
    chvm.client_type,
    client_type,
    location_id,
    ward_id,
    ward_name,
    district_id,
    district_name
