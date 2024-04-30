{{- config(
    materialized="materialized_view",
    on_configuration_change="apply",
    indexes=[{
        "columns": ['location_id','ward_id','district_id','ward_name','district_name','event_date','base_entity_id','provider_id', 'client_type'],
            "unique": true, 'type': 'btree' }]
) -}}

SELECT
    loc.ward_id,
    loc.ward_name,
    loc.district_id,
    loc.district_name,
    coalesce(anc.base_entity_id, pnc.base_entity_id, child.base_entity_id, adsc.base_entity_id) AS base_entity_id,
    coalesce(anc.event_date, pnc.event_date, child.event_date, adsc.event_date) AS event_date,
    coalesce(anc.team, pnc.team, child.team, adsc.team) AS team,
    coalesce(anc.location_id, pnc.location_id, child.location_id, adsc.location_id) AS location_id,
    coalesce(
        anc.child_location_id, pnc.child_location_id, child.child_location_id, adsc.child_location_id
    ) AS child_location_id,
    coalesce(anc.provider_id, pnc.provider_id, child.provider_id, adsc.provider_id) AS provider_id,
    coalesce(anc.date_created, pnc.date_created, child.date_created, adsc.date_created) AS date_created,
    coalesce(
        anc.using_medication, pnc.using_medication, child.using_medication, adsc.using_medication
    ) AS using_medication,
    coalesce(
        anc.medication_used_currently,
        pnc.medication_used_currently,
        child.medication_used_currently,
        adsc.medication_used_currently
    ) AS medication_used_currently,
    coalesce(anc.source_medicine, pnc.source_medicine, child.source_medicine, adsc.source_medicine) AS source_medicine,
    coalesce(
        anc.not_get_all_meds_reason,
        pnc.not_get_all_meds_reason,
        child.not_get_all_meds_reason,
        adsc.not_get_all_meds_reason
    ) AS not_get_all_meds_reason,
    coalesce(
        anc.not_get_all_meds_reason_other,
        pnc.not_get_all_meds_reason_other,
        child.not_get_all_meds_reason_other,
        adsc.not_get_all_meds_reason_other
    ) AS not_get_all_meds_reason_other,
    coalesce(
        anc.expensive_medication_list,
        pnc.expensive_medication_list,
        child.expensive_medication_list,
        adsc.expensive_medication_list
    ) AS expensive_medication_list,
    coalesce(
        anc.out_of_stock_medication_list,
        pnc.out_of_stock_medication_list,
        child.out_of_stock_medication_list,
        adsc.out_of_stock_medication_list
    ) AS out_of_stock_medication_list,
    coalesce(
        anc.other_reason_medication_list,
        pnc.other_reason_medication_list,
        child.other_reason_medication_list,
        adsc.other_reason_medication_list
    ) AS other_reason_medication_list,
    coalesce(anc.get_all_meds, pnc.get_all_meds, child.get_all_meds, adsc.get_all_meds) AS get_all_meds,
    CASE
        WHEN child.source_medicine = 'health_facility' THEN child.source_selection_reason_hf
        WHEN child.source_medicine = 'addo' THEN child.source_selection_reason_addo
        WHEN child.source_medicine = 'phamarcy' THEN child.source_selection_reason_pharmacy
        WHEN child.source_medicine = 'other_commodities_shop' THEN child.source_selection_reason_commodities_shop
        WHEN anc.base_entity_id IS NOT null THEN anc.source_selection_medicine
        WHEN pnc.base_entity_id IS NOT null THEN pnc.source_selection_medicine
        WHEN adsc.base_entity_id IS NOT null THEN pnc.source_selection_medicine
    END AS source_selection_medicine,
    CASE
        WHEN anc.base_entity_id IS NOT null THEN 'anc'
        WHEN pnc.base_entity_id IS NOT null THEN 'pnc'
        WHEN child.base_entity_id IS NOT null THEN 'child'
        WHEN adsc.base_entity_id IS NOT null THEN 'adolescent'
    END AS client_type,
    coalesce(anc.event_ids, pnc.event_ids, child.event_ids, adsc.event_ids) AS event_ids

FROM {{ ref('home_anc') }} AS anc
FULL JOIN {{ ref('home_pnc') }} AS pnc
    ON anc.event_ids = pnc.event_ids
FULL JOIN {{ ref('home_child') }} AS child
    ON anc.event_ids = child.event_ids
FULL JOIN {{ ref('home_adolescent') }} AS adsc
    ON anc.event_ids = adsc.event_ids
LEFT JOIN
    {{ source('location_data', 'openmrs_location_mapping_final') }} AS loc
    ON loc.location_id = coalesce(anc.location_id, pnc.location_id, child.location_id, adsc.location_id)
