SELECT
    coalesce(t.english, chvfm.source_medicine) AS source_medicine,
    count(*) AS frequency
FROM
    {{ ref('child_home_visit_flat_mat') }} AS chvfm
LEFT JOIN translations.translations AS t
    ON
        chvfm.source_medicine = t.swahili
WHERE
    chvfm.event_date >= '2024-03-01'
GROUP BY
    coalesce(t.english, chvfm.source_medicine)
