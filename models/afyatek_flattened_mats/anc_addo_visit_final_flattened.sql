SELECT
    anc_addo_visit_view.base_entity_id,
    anc_addo_visit_view.event_date,
    anc_addo_visit_view.team,
    anc_addo_visit_view.child_location_id,
    anc_addo_visit_view.location_id,
    anc_addo_visit_view.provider_id,
    anc_addo_visit_view.server_version,
    anc_addo_visit_view.date_created,
    anc_addo_visit_view.id,
    uuid_generate_v4() AS unique_id,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'start'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS start_time,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'end'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS end_time,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'deviceid'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS deviceid,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'simserial'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS simserial,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'subscriberid'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS subscriberid,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'service_provider'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS service_provider,
    string_agg(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'danger_signs_present'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END,
        ','
    ) AS danger_signs_present,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_
                = 'minor_illness_captured'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS minor_illness_captured,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'chw_link'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS chw_link,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'referral_status'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS referral_status,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'save_n_refer'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS save_n_refer,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'dispense_options'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS dispense_options,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'select_facility'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS select_facility,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'all_meds_dispensed'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS all_meds_dispensed,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_ = 'danger_signs_captured'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS danger_signs_captured,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'medications_selected'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS medications_selected,
    string_agg(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'medicine_dispensed'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END,
        ','
    ) AS medicine_dispensed,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'minor_illnesses'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS minor_illnesses,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_
                = 'pregnant_woman_present'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS pregnant_woman_present,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_
                = 'client_commodities_dispensed'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS client_commodities_dispensed,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_
                = 'addo_medication_to_give'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS addo_medication_to_give,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'asterisk_symbol'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS asterisk_symbol,
    max(
        CASE
            WHEN anc_addo_visit_view.formsubmissionfield_ = 'addo_visit_date'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS addo_visit_date,
    max(
        CASE
            WHEN
                anc_addo_visit_view.formsubmissionfield_
                = 'linkage_recommendation'::text
                THEN
                    coalesce(
                        anc_addo_visit_view.humanreadablevalues_, anc_addo_visit_view.value_
                    )
            ELSE null::text
        END
    ) AS linkage_recommendation
FROM {{ ref("anc_addo_visit_view") }} AS anc_addo_visit_view
GROUP BY
    anc_addo_visit_view.base_entity_id,
    anc_addo_visit_view.event_date,
    anc_addo_visit_view.team,
    anc_addo_visit_view.location_id,
    anc_addo_visit_view.child_location_id,
    anc_addo_visit_view.provider_id,
    anc_addo_visit_view.server_version,
    anc_addo_visit_view.date_created,
    anc_addo_visit_view.id
