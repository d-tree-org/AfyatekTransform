{% macro get_single_field_value(table_name, field_name, type) %}
    max(
        CASE
            WHEN {{table_name}}.formsubmissionfield_ = '{{ field_name }}'::text
                THEN
                    coalesce(
                        {{table_name}}.humanreadablevalues_::{{type}}, {{table_name}}.value_::{{type}}
                    )
            ELSE null::{{type}}
        END
    )
{% endmacro %}