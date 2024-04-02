{% set fields = [
    {"name": "date_chw_mfollowup"},
    {"name": "visit_hf"},
    {"name": "services_hf"},
    {"name": "get_all_meds"},
    {"name": "not_get_all_meds_reason", "type": "string_agg"},
    {"name": "not_get_all_meds_reason_other"},
    {"name": "reminder_toaster"},
    {"name": "noservices_reason"},
    {"name": "other_reason"},
    {"name": "novisit_reason"},
    {"name": "other_reason_novisit"},
    {"name": "encourage_toaster"},
    {"name": "complete_referral"}
] 
-%}
{{- flattern_obs('referral_follow_up_visit',fields) }}