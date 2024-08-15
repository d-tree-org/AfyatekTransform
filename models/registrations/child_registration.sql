{%- set fields = [
    {"name": "start", "type": "timestamp","rename":"start_time"},
    {"name": "end", "type": "timestamp","rename":"end_time"},
    {"name": "deviceid"},
    {"name": "simserial"},
    {"name": "subscriberid"},
    {"name": "service_provider"},
    {"name": "fam_name"},
    {"name": "age_calculated"},
    {"name": "dob_calculated"},
    {"name": "wra"},
    {"name": "mra"},
    {"name": "is_primary_caregiver"},
    {"name": "last_interacted_with"},
    {"name": "member_consent"},
    {"name": "same_as_fam_name"},
    {"name": "finger_print"},
    {"name": "dob_unknown"},
    {"name": "preferred_name"},
    {"name": "disabilities"},
    {"name": "nutrition_status"},
    {"name": "rhc_card"},
    {"name": "fam_consent"}
] 
-%}
{{- flattern_obs('child_registration',fields) -}}