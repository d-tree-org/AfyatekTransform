SELECT
    unnest(string_to_array(
        phvfm.medication_currently_using_pnc,
        '~'
    )) AS medicines,
    count(*) AS frequency
FROM
    {{ ref('pnc_home_visit_flat_mat') }} AS phvfm
WHERE
    phvfm.event_date >= '2024-03-2'
GROUP BY
    unnest(string_to_array(phvfm.medication_currently_using_pnc, '~'))
ORDER BY frequency DESC
