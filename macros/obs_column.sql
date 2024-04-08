{%- macro obs_column(field) -%}
    {%- set column="coalesce(dict.get->>(lower(obs._val)),obs._val)" if field.translate else "obs._val" -%}
    {%- set casting= "::" ~ field.type if field.type and field.type not in ['options','comma_separated_string'
        ,'tag_delimited', 'text' ] -%}
    {%- set kinds={
        'options': "array_agg({column}) ",
        'comma_separated_string': "max(string_to_array({column},',')) ",
        'tag_delimited': "max(array(
                SELECT coalesce(dict.get->>(lower(trim(original))), original) as translated
                FROM unnest(array_remove(regexp_split_to_array(obs._val,'(\s*(<[^>]+>\s*)|\s*u2022\s*)'),'')) AS original
            )) " if field.translate else
            "max(array_remove(regexp_split_to_array(obs._val,'(\s*(<[^>]+>\s*)|\s*u2022\s*)'),'')) ",
        'else': 'max({column}) '} -%}

    {{- kinds.get(field.type).format(column=column) if field.type in kinds
        else kinds.get('else').format(column=column) -}}
    FILTER (WHERE obs._col = '{{ field.name }}') {{- casting ~ ' ' -}} 
    AS {{ field.rename if 'rename' in field else field.name }},
{%- endmacro %}
