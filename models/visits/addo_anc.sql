{%- set fields = [
    {"name": "start", "type": "timestamp", "rename": "start_time" },
    {"name": "end", "type": "timestamp", "rename": "end_time" },
    {"name": "deviceid" },
    {"name": "simserial" },
    {"name": "subscriberid" },
    {"name": "service_provider" },
    {"name": "danger_signs_present" },
    {"name": "minor_illness_captured" },
    {"name": "chw_link" },
    {"name": "referral_status" },
    {"name": "save_n_refer" },
    {"name": "dispense_options" },
    {"name": "select_facility" },
    {
        "name": "all_meds_dispensed",
        "rename": "is_all_medicine_dispensed",
        "type": "boolean",
        "translate": "true"
    },
    {"name": "danger_signs_captured" },
    {"name": "medications_selected" },
    {"name": "medicine_dispensed" },
    {"name": "minor_illnesses" },
    {
        "name": "pregnant_woman_present",
        "rename": "is_pregnant_woman_present",
        "type": "boolean",
        "translate": "true",
    },
    {"name": "client_commodities_dispensed" },
    {"name": "addo_medication_to_give" },
    {"name": "addo_visit_date" },
    {"name": "linkage_recommendation" },
    {"name": "encounter_type" }
] -%}
{{- flattern_obs('anc_addo_visit',fields) }}
