{% set pnc_fields = [
  {"name": "couselling_pnc", "type": "text"},
  {"name": "danger_signs_present_mama", "type": "text"},
  {"name": "danger_signs_captured_sw", "type": "text"},
  {"name": "minor_illness_present_mama", "type": "text"},
  {"name": "save", "type": "text"},
  {"name": "pnc_visit_1", "type": "text"},
  {"name": "pnc_visit_2", "type": "text"},
  {"name": "confirmed_health_facility_visits", "type": "text"},
  {"name": "refill_commodities", "type": "text"},
  {"name": "ifa_mother", "type": "text"},
  {"name": "fp_period_received", "type": "text"},
  {"name": "fp_start_date", "type": "text"},
  {"name": "fp_method", "type": "text"},
  {"name": "vit_a_mother", "type": "text"},
  {"name": "mild_pain", "type": "text"},
  {"name": "mild_fever", "type": "text"},
  {"name": "fam_llin", "type": "text"},
  {"name": "llin_2days", "type": "text"},
  {"name": "llin_condition", "type": "text"},
  {"name": "fp_counseling", "type": "text"},
  {"name": "using_medication", "type": "yes_no"},
  {"name": "medication_currently_using_pnc", "type": "text"},
  {"name": "source_medicine", "type": "text"},
  {"name": "source_selection_medicine", "type": "text"},
  {"name": "get_all_meds", "type": "yes_no"},
  {"name": "not_get_all_meds_reason", "type": "text"},
  {"name": "not_get_all_meds_reason_other", "type": "text"},
  {"name": "expensive_medication_list", "type": "text"},
  {"name": "out_of_stock_medication_list", "type": "text"},
  {"name": "other_reason_medication_list", "type": "text"},
  {"name": "chw_comment_anc", "type": "text"},
  {"name": "start", "type": "timestamp"},
  {"name": "end", "type": "timestamp"},
  {"name": "pnc_visit_date", "type": "text"},
  {"name": "pnc_hf_visit1_date", "type": "text"},
  {"name": "pnc_hf_visit2_date", "type": "text"},
  {"name": "nutrition_status_mama", "type": "text"},
  {"name": "last_health_facility_visit_date", "type": "text"},
  {"name": "save_n_refer", "type": "text"},
  {"name": "save_n_link", "type": "text"}
] 
-%}
SELECT
    pnc_home_visit_view.base_entity_id,
    pnc_home_visit_view.event_date,
    pnc_home_visit_view.team,
    pnc_home_visit_view.child_location_id,
    pnc_home_visit_view.location_id,
    pnc_home_visit_view.provider_id,
    pnc_home_visit_view.server_version,
    pnc_home_visit_view.date_created,
    pnc_home_visit_view.id,
    {%- set table_name = 'pnc_home_visit_view' -%}
    {%- for pnc_field in pnc_fields -%}
        {%- if pnc_field.name == 'start' or pnc_field.name == 'end' -%} 
        
            {%- set field_name = pnc_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = pnc_field.name -%}

        {%- endif -%}

        {%- if pnc_field.name == 'medication_currently_using_pnc' or pnc_field.name == 'danger_signs_present_mama' -%}
            
            {{ get_string_aggregated_value(table_name , pnc_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, pnc_field.name, pnc_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('pnc_home_visit_view') }} AS pnc_home_visit_view
GROUP BY
    pnc_home_visit_view.base_entity_id,
    pnc_home_visit_view.event_date,
    pnc_home_visit_view.team,
    pnc_home_visit_view.location_id,
    pnc_home_visit_view.child_location_id,
    pnc_home_visit_view.provider_id,
    pnc_home_visit_view.server_version,
    pnc_home_visit_view.date_created,
    pnc_home_visit_view.id
