{% set referral_fields = [
    {"name": "date_chw_mfollowup", "type": "text"},
    {"name": "visit_hf", "type": "text"},
    {"name": "services_hf", "type": "text"},
    {"name": "get_all_meds", "type": "text"},
    {"name": "not_get_all_meds_reason", "type": "text"},
    {"name": "not_get_all_meds_reason_other", "type": "text"},
    {"name": "reminder_toaster", "type": "text"},
    {"name": "noservices_reason", "type": "text"},
    {"name": "other_reason", "type": "text"},
    {"name": "novisit_reason", "type": "text"},
    {"name": "other_reason_novisit", "type": "text"},
    {"name": "encourage_toaster", "type": "text"},
    {"name": "complete_referral", "type": "text"}
] 
-%}
SELECT
    referral_follow_up_visit_view.base_entity_id,
    referral_follow_up_visit_view.event_date,
    referral_follow_up_visit_view.team,
    referral_follow_up_visit_view.child_location_id,
    referral_follow_up_visit_view.location_id,
    referral_follow_up_visit_view.provider_id,
    referral_follow_up_visit_view.server_version,
    referral_follow_up_visit_view.date_created,
    referral_follow_up_visit_view.id,
    {%- set table_name = 'referral_follow_up_visit_view' -%}
    {%- for referral_field in referral_fields -%}
        {%- if referral_field.name == 'start' or referral_field.name == 'end' -%} 
        
            {%- set field_name = referral_field.name ~ '_time' -%}
    
        {%- else -%}
        
            {%- set field_name = referral_field.name -%}

        {%- endif -%}

        {%- if referral_field.name == 'not_get_all_meds_reason' -%}
            
            
            {{ get_string_aggregated_value(table_name , referral_field.name) }} AS {{ field_name }},

        
        {%- else -%}
        
            {{ get_single_field_value(table_name, referral_field.name, referral_field.type) }} AS {{ field_name }},

        {%- endif -%}
    {% endfor %}
    uuid_generate_v4() AS unique_id
FROM {{ ref('referral_follow_up_visit_view') }} AS referral_follow_up_visit_view
GROUP BY
    referral_follow_up_visit_view.base_entity_id,
    referral_follow_up_visit_view.event_date,
    referral_follow_up_visit_view.team,
    referral_follow_up_visit_view.location_id,
    referral_follow_up_visit_view.child_location_id,
    referral_follow_up_visit_view.provider_id,
    referral_follow_up_visit_view.server_version,
    referral_follow_up_visit_view.date_created,
    referral_follow_up_visit_view.id
