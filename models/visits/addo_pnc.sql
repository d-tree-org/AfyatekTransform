{%- set fields=[
  { "name": "select_facility" },
  { "name": "addo_visit_date" },
  { "name": "medications_selected", "translate":"true", "type":"tag_delimited" },
  { "name": "minor_illness_captured" },
  { "name": "chw_link" },
  { "name": "danger_signs_captured" ,"translate":"true", "type":"tag_delimited" },
  { "name": "save_n_refer" },
  { "name": "client_commodities_dispensed" },
  { "name": "all_meds_dispensed",
    "type": "boolean",
    "translate": "true",
    "rename": "is_all_medicine_dispensed"
  },
  { "name": "medicine_dispensed", "type": "options" },
  { "name": "linkage_recommendation" },
  { "name": "addo_medication_to_give","translate":"true", "type":"tag_delimited" },
  { "name": "dispense_options" },
  { "name": "referral_status" },
  { "name": "minorillness_description" },
  { "name": "medication_description" },
  { "name": "minor_illness_present_mama" },
  { "name": "danger_signs_present_mama", "type": "options" },
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
  { "name": "encounter_type", "type": "options" }
]
  -%}
{{- flattern_obs('pnc_addo_visit',fields) -}}