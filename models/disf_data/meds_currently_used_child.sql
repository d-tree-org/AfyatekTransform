SELECT
    unnest(string_to_array(
        chvfm.medication_currently_using_child,
        '~'
    )) AS medicines,
    count(*) AS frequency
FROM
    {{ ref('child_home_visit_flat_mat') }} AS chvfm
WHERE
    chvfm.event_date >= '2024-03-2'
GROUP BY
    unnest(string_to_array(chvfm.medication_currently_using_child, '~'))
ORDER BY frequency DESC
