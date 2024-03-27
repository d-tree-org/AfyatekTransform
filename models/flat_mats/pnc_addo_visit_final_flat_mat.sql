{%- set pnc_fields = [
    {"name": "select_facility", "type": "text"}, 
    {"name": "addo_visit_date", "type": "text"},
    {"name": "medications_selected", "type": "text"},
    {"name": "minor_illness_captured", "type": "text"},
    {"name": "chw_link", "type": "text"},
    {"name": "danger_signs_captured", "type": "text"},
    {"name": "save_n_refer", "type": "text"},
    {"name": "client_commodities_dispensed", "type": "text"},
    {"name": "all_meds_dispensed", "type": "text"},
    {"name": "medicine_dispensed", "type": "text"},
    {"name": "linkage_recommendation", "type": "text"},
    {"name": "addo_medication_to_give", "type": "text"},
    {"name": "dispense_options", "type": "text"},
    {"name": "referral_status", "type": "text"},
    {"name": "minorillness_description", "type": "text"},
    {"name": "medication_description", "type": "text"},
    {"name": "minor_illness_present_mama", "type": "text"},
    {"name": "danger_signs_present_mama", "type": "text"},
    {"name": "mother_present", "type": "text"},
    {"name": "start", "type": "timestamp"},
    {"name": "end", "type": "timestamp"},
    {"name": "deviceid", "type": "text"},
    {"name": "simserial", "type": "text"},
    {"name": "subscriberid", "type": "text"},
    {"name": "service_provider", "type": "text"},
    {"name": "encounter_type", "type": "text"}
    ]
 -%}
SELECT
    pnc_addo_visit_view.base_entity_id,
    pnc_addo_visit_view.entity_type,
    pnc_addo_visit_view.event_date,
    pnc_addo_visit_view.event_type,
    pnc_addo_visit_view.team,
    pnc_addo_visit_view.location_id,
    pnc_addo_visit_view.child_location_id,
    pnc_addo_visit_view.provider_id,
    pnc_addo_visit_view.server_version,
    pnc_addo_visit_view.date_created,
    pnc_addo_visit_view.id,
    {%- set table_name = 'pnc_addo_visit_view' -%}
    {%- for pnc_field in pnc_fields -%}
        {%- if pnc_field.name == 'start' or pnc_field.name == 'end' -%} 
        
            {%- set field_name = pnc_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = pnc_field.name -%}

        {%- endif -%}

        {%- if pnc_field.name == 'medicine_dispensed' or pnc_field.name == 'danger_signs_present_mama' -%}
            
            {{ get_string_aggregated_value(table_name , pnc_field.name) }} AS {{ field_name }},

        {%- else -%}
        
            {{ get_single_field_value(table_name, pnc_field.name, pnc_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('pnc_addo_visit_view') }} AS pnc_addo_visit_view
GROUP BY
    pnc_addo_visit_view.base_entity_id,
    pnc_addo_visit_view.entity_type,
    pnc_addo_visit_view.event_date,
    pnc_addo_visit_view.event_type,
    pnc_addo_visit_view.team,
    pnc_addo_visit_view.location_id,
    pnc_addo_visit_view.child_location_id,
    pnc_addo_visit_view.provider_id,
    pnc_addo_visit_view.server_version,
    pnc_addo_visit_view.date_created,
    pnc_addo_visit_view.id
