{% set fields = [
  {"name": "couselling_pnc"},
  {"name": "danger_signs_present_mama", "type": "options"},
  {"name": "danger_signs_captured_sw"},
  {"name": "minor_illness_present_mama"},
  {"name": "save"},
  {"name": "pnc_visit_1"},
  {"name": "pnc_visit_2"},
  {"name": "confirmed_health_facility_visits"},
  {"name": "refill_commodities"},
  {"name": "ifa_mother"},
  {"name": "fp_period_received"},
  {"name": "fp_start_date"},
  {"name": "fp_method"},
  {"name": "vit_a_mother"},
  {"name": "mild_pain"},
  {"name": "mild_fever"},
  {"name": "fam_llin"},
  {"name": "llin_2days"},
  {"name": "llin_condition"},
  {"name": "fp_counseling"},
  {"name": "using_medication", "type": "boolean", "translate":"true"},
  {"name": "medication_currently_using_pnc", "type": "options","rename":"medication_used_currently"},
  {"name": "source_medicine", "translate": "true"},
  {"name": "source_selection_medicine", "translate": "true"},
  {"name": "get_all_meds", "type": "boolean", "translate": "true"},
  {"name": "not_get_all_meds_reason", "translate": "true"},
  {"name": "not_get_all_meds_reason_other"},
  {"name": "expensive_medication_list"},
  {"name": "out_of_stock_medication_list"},
  {"name": "other_reason_medication_list"},
  {"name": "chw_comment_anc"},
  {"name": "start", "rename":"start_time","type": "timestamp"},
  {"name": "end","rename":"end_time", "type": "timestamp"},
  {"name": "pnc_visit_date"},
  {"name": "pnc_hf_visit1_date"},
  {"name": "pnc_hf_visit2_date"},
  {"name": "nutrition_status_mama"},
  {"name": "last_health_facility_visit_date"},
  {"name": "save_n_refer"},
  {"name": "save_n_link"},
  {"name": "gps", "type": "gps", "rename":"location_point"}
] 
-%}
{{- flattern_obs('pnc_home_visit',fields) }}