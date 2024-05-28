{%- set fields = [ 
    {"name": "using_medication", "type": "boolean", "translate": "true"  },
    {"name": "medication_currently_using_anc", "type": "options","rename":"medication_used_currently"},
    {"name": "source_medicine", "translate": "true"},
    {"name": "source_selection_medicine", "translate": "true"},
    {"name": "not_get_all_meds_reason", "translate": "true"},
    {"name": "not_get_all_meds_reason_other"},
    {"name": "expensive_medication_list"},
    {"name": "out_of_stock_medication_list"},
    {"name": "other_reason_medication_list"},
    {"name": "get_all_meds", "type": "boolean", "translate": "true"},
    {"name": "danger_signs_present", "type": "options"},
    {"name": "minor_illnesses"},
    {"name": "save_n_link"},
    {"name": "save_n_refer"},
    {"name": "anc_hf_visit"},
    {"name": "anc_hf_visit_date"},
    {"name": "anc_hf_next_visit_date"},
    {"name": "confirmed_visits"},
    {"name": "counselling_given"},
    {"name": "fam_llin"},
    {"name": "llin_2days"},
    {"name": "llin_condition"},
    {"name": "start", "rename":"start_time", "type": "timestamp"},
    {"name": "end", "rename":"end_time", "type": "timestamp"},
    {"name": "anc_visit_date"},
    {"name": "date_of_illness"},
    {"name": "chw_comment_anc"},
    {"name": "fam_planning"},
    {"name": "llin_given"},
    {"name": "danger_signs_counseling"}
] 
-%}
{{- flattern_obs('anc_home_visit',fields) }}
