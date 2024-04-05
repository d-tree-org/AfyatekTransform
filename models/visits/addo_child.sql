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
    {"name":"addo_actions","translate":"true", "type":"tag_delimited" },
    {"name":"danger_signs_captured","translate":"true", "type":"tag_delimited" },
    {
        "name":"child_present",
        "rename":"is_child_present",
        "type": "boolean",
        "translate": "true"
    },
    {"name":"medications_selected","translate":"true", "type":"tag_delimited"},
    {"name":"medicine_dispensed", "type": "options"},
    {"name":"linkage_recommendation"},
    {"name":"addo_medication_to_give","translate":"true", "type":"tag_delimited"},
    {"name":"addo_visit_date"},
    {"name":"child_conditions"},
    {
        "name":"danger_signs_present_child"
        ,"translate":"true"
        ,"type": "options"
    }, 
    {"name": "encounter_type", "type":"text" }
    ] 
-%}
{{- flattern_obs('child_addo_visit',fields) -}}