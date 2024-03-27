SELECT
    unnest(string_to_array(
        ahvfm.medication_currently_using_anc,
        '~'
    )) AS medicines,
    count(*) AS frequency
FROM
    {{ ref('anc_home_visit_flat_mat') }} AS ahvfm
WHERE
    ahvfm.event_date >= '2024-03-2'
GROUP BY
    unnest(string_to_array(ahvfm.medication_currently_using_anc, '~'))
ORDER BY frequency DESC
