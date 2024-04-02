{%- set fields=[
  { "name": "select_facility" },
  { "name": "addo_visit_date" },
  { "name": "medications_selected" },
  { "name": "minor_illness_captured" },
  { "name": "chw_link" },
  { "name": "danger_signs_captured" },
  { "name": "save_n_refer" },
  { "name": "client_commodities_dispensed" },
  { "name": "all_meds_dispensed",
    "type": "boolean",
    "translate": "true",
    "rename": "is_all_medicine_dispensed"
  },
  { "name": "medicine_dispensed", "type": "string_agg" },
  { "name": "linkage_recommendation" },
  { "name": "addo_medication_to_give" },
  { "name": "dispense_options" },
  { "name": "referral_status" },
  { "name": "minorillness_description" },
  { "name": "medication_description" },
  { "name": "minor_illness_present_mama" },
  { "name": "danger_signs_present_mama", "type": "string_agg" },
  { "name": "mother_present",
    "rename": "is_mother_present",
    "translate": "true",
    "type": "boolean"
  },
  { "name": "start", "type": "timestamp", "rename": "start_time" },
  { "name": "end", "type": "timestamp", "rename": "end_time" },
  { "name": "deviceid" },
  { "name": "simserial" },
  { "name": "subscriberid" },
  { "name": "service_provider" },
  { "name": "encounter_type", "type": "text" }
]
  -%}
{{- flattern_obs('pnc_addo_visit',fields) -}}