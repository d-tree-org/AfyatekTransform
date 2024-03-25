SELECT
    (
        SELECT
            sum(CASE WHEN ahvfm.using_medication = 'yes' THEN 1 ELSE 0 END)::decimal
            / count(*) AS proportion_med_use_anc
        FROM
            {{ ref('anc_home_visit_flat_mat') }} AS ahvfm
        WHERE ahvfm.event_date >= '2024-02-22'
    ) AS anc_medicine_use,
    (
        SELECT
            sum(CASE WHEN phvfm.using_medication = 'yes' THEN 1 ELSE 0 END)::decimal
            / count(*) AS proportion_med_use_pnc
        FROM
            {{ ref('pnc_home_visit_flat_mat') }} AS phvfm
        WHERE phvfm.event_date >= '2024-02-22'
    ) AS pnc_medicine_use,
    (
        SELECT
            sum(CASE WHEN chvfm.using_medication = 'yes' THEN 1 ELSE 0 END)::decimal
            / count(*) AS proportion_med_use_child
        FROM
            {{ ref('child_home_visit_flat_mat') }} AS chvfm
        WHERE chvfm.event_date >= '2024-02-22'
    ) AS child_medicine_use
