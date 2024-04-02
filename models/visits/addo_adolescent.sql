{% set fields = [
    {"name": "start", "type": "timestamp","rename":"start_time"}, 
    {"name": "end", "type": "timestamp","rename":"end_time"},
    {"name": "deviceid"},
    {"name": "simserial"},
    {"name": "subscriberid"},
    {"name": "service_provider"},
    {"name": "chw_link"},
    {"name": "referral_status"},
    {"name": "save_n_refer"},
    {"name": "dispense_options"},
    {
        "name": "adolescent_present",
        "rename": "is_adolescent_present",
        "type": "boolean",
        "translate": "true"
    },
    {
        "name": "all_meds_dispensed",
        "rename": "is_all_medicine_dispensed",
        "type": "boolean",
        "translate": "true",
    },
    {"name": "addo_actions"},
    {"name": "danger_signs_captured"},
    {"name": "medications_selected"},
    {"name": "medicine_dispensed"},
    {"name": "addo_medication_to_give"},
    {"name": "adolescent_condition_present_other"},
    {"name": "addo_referral_options"},
    {"name": "addo_visit_date"},
    {"name": "adolescent_condition_present"},
    {"name": "linkage_recommendation"}
    ] 
 -%}
{{- flattern_obs('adolescent_addo_visit',fields) -}}
