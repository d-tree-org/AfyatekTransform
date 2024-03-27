{% macro get_string_aggregated_value(table_name, field_name) %}
    string_agg(
        CASE
            WHEN {{ table_name }}.formsubmissionfield_ = '{{ field_name }}'::text
                THEN
                    coalesce(
                        {{ table_name }}.humanreadablevalues_, {{ table_name }}.value_
                    )
            ELSE null::text
        END,
        '~'
    )  
{% endmacro %}
