{% macro get_single_field_value(table_name, field_name, type) %}

    max(
        CASE
            WHEN {{ table_name }}.formsubmissionfield_ = '{{ field_name }}'::text
                THEN
                    {% if type == 'yes_no' %}
                        (
                            lower
                                (
                                    coalesce(
                                        {{ table_name }}.humanreadablevalues_, {{ table_name }}.value_
                                    )
                                ) in ('yes', 'ndio', 'ndiyo')
                        )::INT

                    {%- else -%}
                        coalesce(
                            {{ table_name }}.humanreadablevalues_::{{ type }}, {{ table_name }}.value_::{{ type }}
                        )
                {% endif %}
        END
    {% if type == 'yes_no' %}
        )::boolean
    {% else %}
        )  
    {% endif %}
{% endmacro %}
