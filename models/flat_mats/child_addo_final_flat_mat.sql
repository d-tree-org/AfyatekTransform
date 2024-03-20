{%- set child_fields = [
    {"name":"start", "type": "timestamp"}, 
    {"name":"end", "type": "timestamp"},
    {"name":"deviceid", "type": "text"},
    {"name":"simserial", "type": "text"},
    {"name":"subscriberid", "type": "text"},
    {"name":"service_provider", "type": "text"},
    {"name":"chw_link", "type": "text"},
    {"name":"save_n_refer", "type": "text"},
    {"name":"referral_status", "type": "text"},
    {"name":"dispense_options", "type": "text"},
    {"name":"condition_urgency", "type": "text"},
    {"name":"all_meds_dispensed", "type": "text"},
    {"name":"addo_actions", "type": "text"},
    {"name":"danger_signs_captured", "type": "text"},
    {"name":"child_present", "type": "text"},
    {"name":"medications_selected", "type": "text"},
    {"name":"medicine_dispensed", "type": "text"},
    {"name":"linkage_recommendation", "type": "text"},
    {"name":"addo_medication_to_give", "type": "text"},
    {"name":"addo_visit_date", "type": "text"},
    {"name":"child_conditions", "type": "text"},
    {"name":"danger_signs_present_child", "type": "text"}, 
    {"name": "encounter_type", "type":"text" }
    ] 
-%}
SELECT
    child_addo_visit_view.base_entity_id,
    child_addo_visit_view.event_date,
    child_addo_visit_view.team,
    child_addo_visit_view.child_location_id,
    child_addo_visit_view.location_id,
    child_addo_visit_view.provider_id,
    child_addo_visit_view.server_version,
    child_addo_visit_view.date_created,
    child_addo_visit_view.id,
    {%- set table_name = 'child_addo_visit_view' -%}
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
FROM {{ ref('child_addo_visit_view') }} AS child_addo_visit_view
GROUP BY
    child_addo_visit_view.base_entity_id,
    child_addo_visit_view.event_date,
    child_addo_visit_view.team,
    child_addo_visit_view.location_id,
    child_addo_visit_view.child_location_id,
    child_addo_visit_view.provider_id,
    child_addo_visit_view.server_version,
    child_addo_visit_view.date_created,
    child_addo_visit_view.id
