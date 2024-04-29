{{- config(
    materialized="materialized_view",
    on_configuration_change="apply",
    indexes=[{
        "columns": ['location_id','ward_id','district_id','ward_name','district_name','event_date','base_entity_id','provider_id','client_type'],
            "unique": false, 'type': 'btree' }]
) -}}

SELECT DISTINCT
    loc.ward_id,
    loc.ward_name,
    loc.district_id,
    loc.district_name,
    adolescent.addo_referral_options,
    adolescent.is_adolescent_present,
    child.child_conditions,
    child.is_child_present,
    child.condition_urgency,
    anc.danger_signs_present,
    child.danger_signs_present_child,
    pnc.danger_signs_present_mama,
    pnc.medication_description,
    pnc.is_mother_present,
    anc.is_pregnant_woman_present,
    coalesce(anc.base_entity_id, pnc.base_entity_id, child.base_entity_id, adolescent.base_entity_id) AS base_entity_id,
    coalesce(anc.event_date, pnc.event_date, child.event_date, adolescent.event_date) AS event_date,
    coalesce(anc.team, pnc.team, child.team, adolescent.team) AS team,
    coalesce(anc.location_id, pnc.location_id, child.location_id, adolescent.location_id) AS location_id,
    coalesce(
        anc.child_location_id,
        pnc.child_location_id,
        child.child_location_id,
        adolescent.child_location_id
    ) AS child_location_id,
    coalesce(anc.provider_id, pnc.provider_id, child.provider_id, adolescent.provider_id) AS provider_id,
    coalesce(anc.date_created, pnc.date_created, child.date_created, adolescent.date_created) AS date_created,
    coalesce(anc.event_ids, pnc.event_ids, child.event_ids, adolescent.event_ids) AS event_ids,
    coalesce(child.addo_actions, adolescent.addo_actions) AS actions,
    coalesce(
        pnc.addo_medication_to_give,
        child.addo_medication_to_give,
        anc.addo_medication_to_give,
        adolescent.addo_medication_to_give
    ) AS medication_to_give,
    coalesce(pnc.addo_visit_date, child.addo_visit_date, anc.addo_visit_date, adolescent.addo_visit_date) AS visit_date,
    coalesce(adolescent.adolescent_condition_present) AS adolescent_condition_present,
    coalesce(adolescent.adolescent_condition_present_other) AS adolescent_condition_present_other,
    coalesce(
        pnc.not_dispensed_meds,
        child.not_dispensed_meds,
        anc.not_dispensed_meds,
        adolescent.not_dispensed_meds
    ) AS not_dispensed_meds,
    coalesce(
        pnc.is_all_medicine_dispensed,
        child.is_all_medicine_dispensed,
        anc.is_all_medicine_dispensed,
        adolescent.is_all_medicine_dispensed
    ) AS is_all_medicine_dispensed,
    coalesce(pnc.chw_link, child.chw_link, anc.chw_link, adolescent.chw_link) AS chw_link,
    coalesce(pnc.client_commodities_dispensed, anc.client_commodities_dispensed) AS client_commodities_dispensed,
    coalesce(
        pnc.danger_signs_captured,
        child.danger_signs_captured,
        anc.danger_signs_captured,
        adolescent.danger_signs_captured
    ) AS danger_signs_captured,
    coalesce(pnc.deviceid, child.deviceid, anc.deviceid, adolescent.deviceid) AS deviceid,
    coalesce(
        pnc.dispense_options, child.dispense_options, anc.dispense_options, adolescent.dispense_options
    ) AS dispense_options,
    coalesce(pnc.encounter_type, child.encounter_type, anc.encounter_type, adolescent.encounter_type) AS encounter_type,
    coalesce(pnc.end_time, child.end_time, anc.end_time, adolescent.end_time) AS end_time,
    coalesce(
        pnc.linkage_recommendation,
        child.linkage_recommendation,
        anc.linkage_recommendation,
        adolescent.linkage_recommendation
    ) AS linkage_recommendation,
    coalesce(
        pnc.medications_selected, child.medications_selected, anc.medications_selected, adolescent.medications_selected
    ) AS medications_selected,
    coalesce(
        pnc.medicine_dispensed, child.medicine_dispensed, anc.medicine_dispensed, adolescent.medicine_dispensed
    ) AS medicine_dispensed,
    coalesce(pnc.minor_illness_captured, anc.minor_illness_captured) AS minor_illness_captured,
    coalesce(pnc.minorillness_description) AS minorillness_description,
    coalesce(
        pnc.referral_status, child.referral_status, anc.referral_status, adolescent.referral_status
    ) AS referral_status,
    coalesce(pnc.save_n_refer, child.save_n_refer, anc.save_n_refer, adolescent.save_n_refer) AS save_n_refer,
    coalesce(pnc.select_facility, anc.select_facility) AS select_facility,
    coalesce(
        pnc.service_provider, child.service_provider, anc.service_provider, adolescent.service_provider
    ) AS service_provider,
    coalesce(pnc.simserial, child.simserial, anc.simserial, adolescent.simserial) AS simserial,
    coalesce(pnc.start_time, child.start_time, anc.start_time, adolescent.start_time) AS start_time,
    coalesce(pnc.subscriberid, child.subscriberid, anc.subscriberid, adolescent.subscriberid) AS subscriberid,
    CASE
        WHEN anc.base_entity_id IS NOT null THEN 'anc'
        WHEN pnc.base_entity_id IS NOT null THEN 'pnc'
        WHEN child.base_entity_id IS NOT null THEN 'child'
        WHEN adolescent.base_entity_id IS NOT null THEN 'adolescent'
    END AS client_type
FROM {{ ref('addo_anc') }} AS anc
FULL JOIN {{ ref('addo_pnc') }} AS pnc
    ON anc.event_ids = pnc.event_ids
FULL JOIN {{ ref('addo_child') }} AS child
    ON anc.event_ids = child.event_ids
FULL JOIN {{ ref('addo_adolescent') }} AS adolescent
    ON anc.event_ids = adolescent.event_ids
LEFT JOIN
    {{ source('location_data', 'openmrs_location_mapping_final') }} AS loc
    ON loc.ward_id = coalesce(anc.location_id, pnc.location_id, child.location_id, adolescent.location_id)
