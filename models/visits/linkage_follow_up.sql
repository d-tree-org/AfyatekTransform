{% set fields = [
    {"name": "date_chw_mfollowup"},
    {"name": "visit_hf"},
    {"name": "services_hf"},
    {"name": "noservices_reason"},
    {"name": "other_reason"},
    {"name": "novisit_reason"},
    {"name": "other_reason_novisit"},
    {"name": "complete_referral"},
    {"name": "gps", "type": "gps", "rename":"location_point"}
] 
-%}
{{- flattern_obs('referral_follow_up_visit',fields) }}