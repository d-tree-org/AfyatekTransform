{%- set anc_fields = [
    {"name":"start", "type": "timestamp"}, 
    {"name": "end", "type": "timestamp"}, 
    {"name":"deviceid", "type": "text"}, 
    {"name": "simserial", "type":"text"}, 
    {"name": "subscriberid", "type":"text"}, 
    {"name": "service_provider", "type":"text"}, 
    {"name": "danger_signs_present", "type":"text"}, 
    {"name": "minor_illness_captured", "type":"text"}, 
    {"name": "chw_link", "type":"text"}, 
    {"name": "referral_status", "type":"text"}, 
    {"name": "save_n_refer", "type":"text"}, 
    {"name": "dispense_options", "type":"text"}, 
    {"name": "select_facility", "type":"text"},
    {"name": "all_meds_dispensed", "type":"text"},
    {"name": "danger_signs_captured", "type":"text"}, 
    {"name": "medications_selected", "type":"text"}, 
    {"name": "medicine_dispensed", "type":"text"},
    {"name": "minor_illnesses", "type":"text"}, 
    {"name": "pregnant_woman_present", "type":"text"}, 
    {"name": "client_commodities_dispensed", "type":"text"}, 
    {"name": "addo_medication_to_give", "type":"text"}, 
    {"name": "addo_visit_date", "type":"text"}, 
    {"name": "linkage_recommendation", "type":"text"}, 
    {"name": "encounter_type", "type":"text" }
    ] 
-%}
SELECT
    anc_addo_visit_view.base_entity_id,
    anc_addo_visit_view.event_date,
    anc_addo_visit_view.team,
    anc_addo_visit_view.child_location_id,
    anc_addo_visit_view.location_id,
    anc_addo_visit_view.provider_id,
    anc_addo_visit_view.server_version,
    anc_addo_visit_view.date_created,
    anc_addo_visit_view.id,
    {%- set table_name = 'anc_addo_visit_view' -%}
    {%- for anc_field in anc_fields -%}
        {%- if anc_field.name == 'start' or anc_field.name == 'end' -%} 
        
            {%- set field_name = anc_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = anc_field.name -%}

        {%- endif -%}

        {%- if anc_field.name == 'medicine_dispensed' or anc_field.name == 'danger_signs_present' -%}
            
            {{ get_string_aggregated_value(table_name , anc_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, anc_field.name, anc_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {%- endfor -%}
    uuid_generate_v4() AS unique_id
FROM {{ ref("anc_addo_visit_view") }} AS anc_addo_visit_view
GROUP BY
    anc_addo_visit_view.base_entity_id,
    anc_addo_visit_view.event_date,
    anc_addo_visit_view.team,
    anc_addo_visit_view.location_id,
    anc_addo_visit_view.child_location_id,
    anc_addo_visit_view.provider_id,
    anc_addo_visit_view.server_version,
    anc_addo_visit_view.date_created,
    anc_addo_visit_view.id
