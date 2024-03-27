WITH reason_choosing_addo_anc AS (
    SELECT
        coalesce(
            t2.english,
            ahvfm.source_selection_medicine
        ) AS reason_for_selecting_addo
    FROM
        {{ ref('anc_home_visit_flat_mat') }} AS ahvfm
    LEFT JOIN translations.translations AS t
        ON
            ahvfm.source_medicine = t.swahili
    LEFT
    JOIN translations.translations AS t2
        ON
            ahvfm.source_selection_medicine = t2.swahili
    WHERE
        ahvfm.event_date >= '2024-03-01'
        AND coalesce(
            t.english,
            ahvfm.source_medicine
        ) = 'ADDO'
),

reason_choosing_addo_pnc AS (
    SELECT
        coalesce(
            t2.english,
            phvfm.source_selection_medicine
        ) AS reason_for_selecting_addo
    FROM
        {{ ref('pnc_home_visit_flat_mat') }} AS phvfm
    LEFT JOIN translations.translations AS t
        ON
            phvfm.source_medicine = t.swahili
    LEFT
    JOIN translations.translations AS t2
        ON
            phvfm.source_selection_medicine = t2.swahili
    WHERE
        phvfm.event_date >= '2024-03-01'
        AND coalesce(
            t.english,
            phvfm.source_medicine
        ) = 'ADDO'
),

reason_choosing_addo_child AS (
    SELECT coalesce(t.english, chvfm.source_selection_reason_addo) AS reason_for_selecting_addo
    FROM
        {{ ref('child_home_visit_flat_mat') }} AS chvfm
    LEFT JOIN translations.translations AS t ON chvfm.source_selection_reason_addo = t.swahili
    WHERE chvfm.event_date >= '2024-03-01' AND chvfm.source_selection_reason_addo NOTNULL
),

reason_choosing_addo_all AS (
    SELECT *
    FROM
        reason_choosing_addo_anc
    UNION ALL
    SELECT *
    FROM
        reason_choosing_addo_pnc
    UNION ALL
    SELECT *
    FROM
        reason_choosing_addo_child
)

SELECT
    reason_for_selecting_addo,
    count(*) AS count
FROM
    reason_choosing_addo_all
GROUP BY 1
