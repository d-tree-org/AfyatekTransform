{%- set fields = [
    {"name": "additional_counseling", "translate": "true"},
    {"name": "adolescent_condition_present", "translate": "true"},
    {"name": "date_of_illness"},
    {"name": "adolescent_condition_present_other"},
    {"name": "adolescent_service_option"},
    {"name": "adolescent_counseling_given"},
    {"name": "save_n_refer"},
    {"name": "save_n_link"},
    {"name": "save"},
    {"name": "using_medication", "type": "boolean", "translate":"true"},
    {"name": "medication_currently_using_adolescent", "type": "options","rename":"medication_used_currently"},
    {"name": "source_medicine", "translate": "true"},
    {"name": "source_selection_medicine"},
    {"name": "get_all_meds", "type": "boolean", "translate": "true"},
    {"name": "not_get_all_meds_reason", "translate": "true"},
    {"name": "not_get_all_meds_reason_other"},
    {"name": "expensive_medication_list"},
    {"name": "out_of_stock_medication_list"},
    {"name": "other_reason_medication_list"},
    {"name": "gps", "type": "gps", "rename":"location_point"}
] 
-%}
{{- flattern_obs('adolescent_home_visit',fields) }}
