{{- config(
    materialized="table",
    on_configuration_change="apply",
    indexes=[{
        "columns": ['lower_limit','upper_limit','category'],
            "unique": true, 'type': 'btree' }]
) -}}

WITH p4p_breakdown(achieved, lower_limit, upper_limit, amount, category) AS (
    VALUES
    ('100.00%', 80, 1000000, 40000, 'registration'),
    ('80.00%', 60, 79, 30000, 'registration'),
    ('60.00%', 40, 59, 20000, 'registration'),
    ('40.00%', 20, 39, 10000, 'registration'),
    ('20.00%', 10, 19, 5000, 'registration'),
    ('0.00%', 0, 9, 0, 'registration'),
    ('100.00%', 80, 1000000, 60000, 'visit'),
    ('80.00%', 60, 79, 45000, 'visit'),
    ('60.00%', 40, 59, 30000, 'visit'),
    ('40.00%', 20, 39, 15000, 'visit'),
    ('20.00%', 10, 19, 5000, 'visit'),
    ('0.00%', 0, 9, 0, 'visit')
)

SELECT * FROM p4p_breakdown;
