SELECT
    coalesce(t.english, ahvfm.source_medicine) AS source_medicine,
    count(*) AS frequency
FROM
    {{ ref('anc_home_visit_flat_mat') }} AS ahvfm
LEFT JOIN translations.translations AS t
    ON
        ahvfm.source_medicine = t.swahili
WHERE
    ahvfm.event_date >= '2024-03-01'
GROUP BY
    coalesce(t.english, ahvfm.source_medicine)
