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
    {"name": "other_phone_number"},
    {"name": "preg_1yr"},
    {"name": "fam_consent"},
    {"name": "consent_photo"}
] 
-%}
{{- flattern_obs('family_member_registration',fields) -}}