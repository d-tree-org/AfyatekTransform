SELECT
    coalesce(t.english, phvfm.source_medicine) AS source_medicine,
    count(*) AS frequency
FROM
    {{ ref('pnc_home_visit_flat_mat') }} AS phvfm
LEFT JOIN translations.translations AS t
    ON
        phvfm.source_medicine = t.swahili
WHERE
    phvfm.event_date >= '2024-03-01'
GROUP BY
    coalesce(t.english, phvfm.source_medicine)
