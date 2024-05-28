WITH chw_combined_meds AS (
    SELECT
        ahv.base_entity_id,
        ahv.event_date,
        ahv.team,
        ahv.location_id,
        ahv.child_location_id,
        ahv.provider_id,
        ahv.server_version,
        ahv.date_created,
        ahv.id,
        ahv.unique_id,
        ahv.using_medication,
        ahv.medication_currently_using_anc AS medication_used_currently,
        ahv.source_medicine,
        ahv.not_get_all_meds_reason,
        ahv.not_get_all_meds_reason_other,
        ahv.expensive_medication_list,
        ahv.out_of_stock_medication_list,
        ahv.other_reason_medication_list,
        ahv.get_all_meds,
        'anc' AS client_type,
        ahv.source_selection_medicine
    FROM {{ ref('anc_home_visit_flat_mat') }} AS ahv
    WHERE ahv.event_date >= '2024-03-01'
    UNION ALL
    SELECT
        phv.base_entity_id,
        phv.event_date,
        phv.team,
        phv.location_id,
        phv.child_location_id,
        phv.provider_id,
        phv.server_version,
        phv.date_created,
        phv.id,
        phv.unique_id,
        phv.using_medication,
        phv.medication_currently_using_pnc AS medication_used_currently,
        phv.source_medicine,
        phv.not_get_all_meds_reason,
        phv.not_get_all_meds_reason_other,
        phv.expensive_medication_list,
        phv.out_of_stock_medication_list,
        phv.other_reason_medication_list,
        phv.get_all_meds,
        'pnc' AS client_type,
        phv.source_selection_medicine
    FROM {{ ref('pnc_home_visit_flat_mat') }} AS phv
    WHERE phv.event_date >= '2024-03-01'
    UNION ALL
    SELECT
        chv.base_entity_id,
        chv.event_date,
        chv.team,
        chv.location_id,
        chv.child_location_id,
        chv.provider_id,
        chv.server_version,
        chv.date_created,
        chv.id,
        chv.unique_id,
        chv.using_medication,
        chv.medication_currently_using_child AS medication_used_currently,
        chv.source_medicine,
        chv.not_get_all_meds_reason,
        chv.not_get_all_meds_reason_other,
        chv.expensive_medication_list,
        chv.out_of_stock_medication_list,
        chv.other_reason_medication_list,
        chv.get_all_meds,
        'child' AS client_type,
        CASE
            WHEN chv.source_medicine = 'health_facility' THEN chv.source_selection_reason_hf
            WHEN chv.source_medicine = 'addo' THEN chv.source_selection_reason_addo
            WHEN chv.source_medicine = 'phamarcy' THEN chv.source_selection_reason_pharmacy
            WHEN chv.source_medicine = 'other_commodities_shop' THEN chv.source_selection_reason_commodities_shop
            ELSE null::text
        END AS source_selection_medicine
    FROM {{ ref('child_home_visit_flat_mat') }} AS chv WHERE chv.event_date >= '2024-03-01'
)

SELECT
    chw_combined_meds.*,
    ld.ward_id,
    ld.ward_name,
    ld.district_id,
    ld.district_name
FROM chw_combined_meds
LEFT JOIN
    {{ source('location_data', 'openmrs_location_mapping_final') }} AS ld
    ON chw_combined_meds.location_id = ld.location_id
