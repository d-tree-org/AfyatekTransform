{% set child_fields = [
        {"name": "danger_signs_present_child", "type": "text"},
        {"name": "minor_illness_present_child", "type": "text"},
        {"name": "save_n_link", "type": "text"},
        {"name": "home_visit_date", "type": "text"},
        {"name": "start", "type": "timestamp"},
        {"name": "end", "type": "timestamp"},
        {"name": "save_n_refer", "type": "text"},
        {"name": "date_of_illness_1m5yr", "type": "text"},
        {"name": "couselling_pnc", "type": "text"},
        {"name": "fam_llin_1m5yr", "type": "text"},
        {"name": "llin_2days_1m5yr", "type": "text"},
        {"name": "using_medication", "type": "text"},
        {"name": "medication_currently_using_child", "type": "text"},
        {"name": "source_medicine", "type": "text"},
        {"name": "source_selection_reason_hf", "type": "text"},
        {"name": "source_selection_reason_addo", "type": "text"},
        {"name": "source_selection_reason_pharmacy", "type": "text"},
        {"name": "source_selection_reason_commodities_shop", "type": "text"},
        {"name": "get_all_meds", "type": "text"},
        {"name": "not_get_all_meds_reason", "type": "text"},
        {"name": "not_get_all_meds_reason_other", "type": "text"},
        {"name": "expensive_medication_list", "type": "text"},
        {"name": "out_of_stock_medication_list", "type": "text"},
        {"name": "other_reason_medication_list", "type": "text"}
    ] 
%}
SELECT
    child_home_visit_view.base_entity_id,
    child_home_visit_view.event_date,
    child_home_visit_view.team,
    child_home_visit_view.location_id,
    child_home_visit_view.child_location_id,
    child_home_visit_view.provider_id,
    child_home_visit_view.server_version,
    child_home_visit_view.date_created,
    child_home_visit_view.id,
    {%- set table_name = 'child_home_visit_view' -%}
    {%- for child_field in child_fields -%}
        {%- if child_field.name == 'start' or child_field.name == 'end' -%} 
        
            {%- set field_name = child_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = child_field.name -%}

        {%- endif -%}

        {%- if child_field.name == 'medicine_dispensed' or child_field.name == 'danger_signs_present_child' -%}
            
            {{ get_string_aggregated_value(table_name , child_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, child_field.name, child_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('child_home_visit_view') }} AS child_home_visit_view
GROUP BY
    child_home_visit_view.base_entity_id,
    child_home_visit_view.event_date,
    child_home_visit_view.team,
    child_home_visit_view.location_id,
    child_home_visit_view.child_location_id,
    child_home_visit_view.provider_id,
    child_home_visit_view.server_version,
    child_home_visit_view.date_created,
    child_home_visit_view.id
