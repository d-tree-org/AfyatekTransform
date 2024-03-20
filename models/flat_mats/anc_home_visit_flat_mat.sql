{%- set anc_fields = [
  {"name": "using_medication", "type": "text"},
  {"name": "medication_currently_using_anc", "type": "text"},
  {"name": "source_medicine", "type": "text"},
  {"name": "source_selection_medicine", "type": "text"},
  {"name": "not_get_all_meds_reason", "type": "text"},
  {"name": "not_get_all_meds_reason_other", "type": "text"},
  {"name": "expensive_medication_list", "type": "text"},
  {"name": "out_of_stock_medication_list", "type": "text"},
  {"name": "other_reason_medication_list", "type": "text"},
  {"name": "get_all_meds", "type": "text"},
  {"name": "danger_signs_present", "type": "text"},
  {"name": "minor_illnesses", "type": "text"},
  {"name": "save_n_link", "type": "text"},
  {"name": "save_n_refer", "type": "text"},
  {"name": "anc_hf_visit", "type": "text"},
  {"name": "anc_hf_visit_date", "type": "text"},
  {"name": "anc_hf_next_visit_date", "type": "text"},
  {"name": "confirmed_visits", "type": "text"},
  {"name": "counselling_given", "type": "text"},
  {"name": "fam_llin", "type": "text"},
  {"name": "llin_2days", "type": "text"},
  {"name": "llin_condition", "type": "text"},
  {"name": "start", "type": "timestamp"},
  {"name": "end", "type": "timestamp"},
  {"name": "anc_visit_date", "type": "text"},
  {"name": "date_of_illness", "type": "text"},
  {"name": "chw_comment_anc", "type": "text"},
  {"name": "fam_planning", "type": "text"},
  {"name": "llin_given", "type": "text"},
  {"name": "danger_signs_counseling", "type": "text"}
  ] 
-%}
SELECT
    anc_home_visit_view.base_entity_id,
    anc_home_visit_view.event_date,
    anc_home_visit_view.team,
    anc_home_visit_view.location_id,
    anc_home_visit_view.child_location_id,
    anc_home_visit_view.provider_id,
    anc_home_visit_view.server_version,
    anc_home_visit_view.date_created,
    anc_home_visit_view.id,
    {%- set table_name = 'anc_home_visit_view' -%}
    {%- for anc_field in anc_fields -%}
        {%- if anc_field.name == 'start' or anc_field.name == 'end' -%} 
        
            {%- set field_name = anc_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = anc_field.name -%}

        {%- endif -%}

        {%- if anc_field.name == 'medication_currently_using_anc' or anc_field.name == 'danger_signs_present' -%}
            
            {{ get_string_aggregated_value(table_name , anc_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, anc_field.name, anc_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('anc_home_visit_view') }} AS anc_home_visit_view
GROUP BY
    anc_home_visit_view.base_entity_id,
    anc_home_visit_view.event_date,
    anc_home_visit_view.team,
    anc_home_visit_view.location_id,
    anc_home_visit_view.child_location_id,
    anc_home_visit_view.provider_id,
    anc_home_visit_view.server_version,
    anc_home_visit_view.date_created,
    anc_home_visit_view.id
