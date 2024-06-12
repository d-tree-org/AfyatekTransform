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
    {"name": "addo_actions","translate":"true", "type":"tag_delimited"},
    {"name": "danger_signs_captured","type":"tag_delimited","translate":"true"},
    {"name": "medications_selected", "translate":"true", "type":"tag_delimited"},
    {"name": "medicine_dispensed", "translate":"true", "type":"options"},
    {"name": "addo_medication_to_give","translate":"true", "type":"tag_delimited"},
    {"name": "adolescent_condition_present_other"},
    {"name": "addo_referral_options"},
    {"name": "addo_visit_date"},
    {"name": "adolescent_condition_present"},
    {"name": "linkage_recommendation"},

    { "name":"no_medicine_selected"},
    { "name":"medication_description"},
    { "name":"not_dispensed_meds","type":"options"},
    {
        "name":"reason_not_dispensed_meds",
        "translate":"true",
        "type":"options"
    },
    {"name": "encounter_type","type":"options" },
    {"name": "gps", "type": "gps", "rename":"location_point"}
    ] 
 -%}
{{- flattern_obs('adolescent_addo_visit',fields) -}}
