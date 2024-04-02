{% set fields = [
        {"name": "danger_signs_present_child", "type": "string_agg"},
        {"name": "minor_illness_present_child"},
        {"name": "save_n_link"},
        {"name": "home_visit_date"},
        {"name": "start", "type": "timestamp","rename":"start_time"},
        {"name": "end", "type": "timestamp","rename":"end_time"},
        {"name": "save_n_refer"},
        {"name": "date_of_illness_1m5yr"},
        {"name": "couselling_pnc"},
        {"name": "fam_llin_1m5yr"},
        {"name": "llin_2days_1m5yr"},
        {"name": "using_medication", "type": "boolean", "translate": "true"},
        {"name": "medication_currently_using_child","rename":"medication_used_currently"},
        {"name": "source_medicine"},
        {"name": "source_selection_reason_hf"},
        {"name": "source_selection_reason_addo"},
        {"name": "source_selection_reason_pharmacy"},
        {"name": "source_selection_reason_commodities_shop"},
        {"name": "get_all_meds", "type": "boolean", "translate": "true"},
        {"name": "not_get_all_meds_reason"},
        {"name": "not_get_all_meds_reason_other"},
        {"name": "expensive_medication_list"},
        {"name": "out_of_stock_medication_list"},
        {"name": "other_reason_medication_list"}
    ] 
%}
{{- flattern_obs('child_home_visit',fields) -}}