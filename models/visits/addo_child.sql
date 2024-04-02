{%- set fields = [
    {"name":"start", "type": "timestamp","rename":"start_time"}, 
    {"name":"end", "type": "timestamp","rename":"end_time"},
    {"name":"deviceid"},
    {"name":"simserial"},
    {"name":"subscriberid"},
    {"name":"service_provider"},
    {"name":"chw_link"},
    {"name":"save_n_refer"},
    {"name":"referral_status"},
    {"name":"dispense_options"},
    {"name":"condition_urgency"},
    {
        "name":"all_meds_dispensed",
        "rename":"is_all_medicine_dispensed",
        "type": "boolean",
        "translate": "true"
    },
    {"name":"addo_actions"},
    {"name":"danger_signs_captured"},
    {
        "name":"child_present",
        "rename":"is_child_present",
        "type": "boolean",
        "translate": "true"
    },
    {"name":"medications_selected"},
    {"name":"medicine_dispensed", "type": "string_agg"},
    {"name":"linkage_recommendation"},
    {"name":"addo_medication_to_give"},
    {"name":"addo_visit_date"},
    {"name":"child_conditions"},
    {"name":"danger_signs_present_child", "type": "string_agg"}, 
    {"name": "encounter_type", "type":"text" }
    ] 
-%}
{{- flattern_obs('child_addo_visit',fields) -}}