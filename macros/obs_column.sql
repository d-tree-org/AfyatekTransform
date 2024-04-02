{%- macro obs_column(field,obs) -%}
    {{ log(field) }}
    {%- set column="coalesce(
        translation.dict->>(lower("~obs~" -> 'humanReadableValues' ->> 0)),
        translation.dict->>(lower("~obs~" -> 'values' ->> 0)),
        "~obs~" -> 'humanReadableValues' ->> 0,
        "~obs~" -> 'values' ->> 0)"
        if field.translate else 
        "coalesce("~obs~" -> 'humanReadableValues' ->> 0,"~obs~" -> 'values' ->> 0)" -%}

    {{- "string_agg({column},'~') ".format(column=column) if 'string_agg'==field.type else
        'max({column}) '.format(column=column) -}}
    FILTER (WHERE {{ obs }} ->> 'formSubmissionField' = '{{ field.name }}') {{- 
    '::' ~ field.type ~ ' ' if field.type and field.type not in ['string_agg', 'text' ] else ' ' -}} 
    AS {{ field.rename if 'rename' in field else field.name }},
{%- endmacro %}
