{% set adolescent_fields = [
    {"name": "start", "type": "timestamp"}, 
    {"name": "end", "type": "timestamp"},
    {"name": "deviceid", "type": "text"},
    {"name": "simserial", "type": "text"},
    {"name": "subscriberid", "type": "text"},
    {"name": "service_provider", "type": "text"},
    {"name": "chw_link", "type": "text"},
    {"name": "referral_status", "type": "text"},
    {"name": "save_n_refer", "type": "text"},
    {"name": "dispense_options", "type": "text"},
    {"name": "adolescent_present", "type": "text"},
    {"name": "all_meds_dispensed", "type": "text"},
    {"name": "addo_actions", "type": "text"},
    {"name": "danger_signs_captured", "type": "text"},
    {"name": "medications_selected", "type": "text"},
    {"name": "medicine_dispensed", "type": "text"},
    {"name": "addo_medication_to_give", "type": "text"},
    {"name": "adolescent_condition_present_other", "type": "text"},
    {"name": "addo_referral_options", "type": "text"},
    {"name": "addo_visit_date", "type": "text"},
    {"name": "adolescent_condition_present", "type": "text"},
    {"name": "linkage_recommendation", "type": "text"}
    ] 
%}
SELECT
    adolescent_addo_visit_view.base_entity_id,
    adolescent_addo_visit_view.event_date,
    adolescent_addo_visit_view.team,
    adolescent_addo_visit_view.child_location_id,
    adolescent_addo_visit_view.location_id,
    adolescent_addo_visit_view.provider_id,
    adolescent_addo_visit_view.server_version,
    adolescent_addo_visit_view.date_created,
    adolescent_addo_visit_view.id,
    {%- set table_name = 'adolescent_addo_visit_view' -%}
    {%- for adolescent_field in adolescent_fields -%}
        {%- if adolescent_field.name == 'start' or adolescent_field.name == 'end' -%} 
        
            {%- set field_name = adolescent_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = adolescent_field.name -%}

        {%- endif -%}

        {%- if adolescent_field.name == 'medicine_dispensed' or adolescent_field.name == 'adolescent_condition_present' -%}
            
            {{ get_string_aggregated_value(table_name , adolescent_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, adolescent_field.name, adolescent_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('adolescent_addo_visit_view') }} as adolescent_addo_visit_view
GROUP BY
    adolescent_addo_visit_view.base_entity_id,
    adolescent_addo_visit_view.event_date,
    adolescent_addo_visit_view.team,
    adolescent_addo_visit_view.location_id,
    adolescent_addo_visit_view.child_location_id,
    adolescent_addo_visit_view.provider_id,
    adolescent_addo_visit_view.server_version,
    adolescent_addo_visit_view.date_created,
    adolescent_addo_visit_view.id
