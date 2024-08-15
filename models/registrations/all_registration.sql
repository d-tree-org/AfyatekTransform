SELECT
    loc.ward_id,
    loc.ward_name,
    loc.district_id,
    loc.district_name,
    coalesce(member.event_date,adolescent.event_date,child.event_date) AS event_date,
    coalesce(member.team,adolescent.team,child.team) AS team,
    coalesce(member.location_id,adolescent.location_id,child.location_id) AS location_id,
    coalesce(member.child_location_id,adolescent.child_location_id,child.child_location_id) AS child_location_id,
    coalesce(member.provider_id,adolescent.provider_id,child.provider_id) AS provider_id,
    coalesce(member.date_created,adolescent.date_created,child.date_created) AS date_created,
    coalesce(member.base_entity_id,adolescent.base_entity_id,child.base_entity_id) AS base_entity_id,
    coalesce(member.start_time,adolescent.start_time,child.start_time) as start_time,
    coalesce(member.end_time,adolescent.end_time,child.end_time) as end_time,
    coalesce(member.deviceid,adolescent.deviceid,child.deviceid) as deviceid,
    coalesce(member.simserial,adolescent.simserial,child.simserial) as simserial,
    coalesce(member.subscriberid,adolescent.subscriberid,child.subscriberid) as subscriberid,
    coalesce(member.service_provider,adolescent.service_provider,child.service_provider) as service_provider,
    coalesce(member.fam_name,adolescent.fam_name,child.fam_name) as fam_name,
    coalesce(member.age_calculated,adolescent.age_calculated,child.age_calculated) as age_calculated,
    coalesce(member.dob_calculated,adolescent.dob_calculated,child.dob_calculated) as dob_calculated,
    coalesce(member.wra,adolescent.wra,child.wra) as wra,
    coalesce(member.mra,adolescent.mra,child.mra) as mra,
    coalesce(member.is_primary_caregiver,adolescent.is_primary_caregiver,child.is_primary_caregiver) as is_primary_caregiver,
    coalesce(member.last_interacted_with,adolescent.last_interacted_with,child.last_interacted_with) as last_interacted_with,
    coalesce(member.member_consent,adolescent.member_consent,child.member_consent) as member_consent,
    coalesce(member.same_as_fam_name,adolescent.same_as_fam_name,child.same_as_fam_name) as same_as_fam_name,
    coalesce(member.finger_print,adolescent.finger_print,child.finger_print) as finger_print,
    coalesce(member.dob_unknown,adolescent.dob_unknown,child.dob_unknown) as dob_unknown,
    coalesce(member.disabilities,child.disabilities) as disabilities,
    coalesce(child.nutrition_status) as nutrition_status,
    coalesce(child.rhc_card) as rhc_card,
    coalesce(member.fam_consent,child.fam_consent) as fam_consent,
    CASE
        WHEN child.base_entity_id IS NOT null THEN 'child'
        WHEN member.base_entity_id IS NOT null THEN 'member'
        WHEN adolescent.base_entity_id IS NOT null THEN 'adolescent'
    END AS client_type,
    coalesce(child.event_ids, member.event_ids, adolescent.event_ids) AS event_ids

FROM {{ ref('child_registration') }} AS child
FULL JOIN {{ ref('family_member') }} AS member
    ON child.event_ids = member.event_ids
FULL JOIN {{ ref('adolescent_registration') }} AS adolescent
    ON child.event_ids = adolescent.event_ids
LEFT JOIN
    {{ source('afyatek_data', 'openmrs_location_mapping_final') }} AS loc
    ON loc.location_id = coalesce(child.location_id, adolescent.location_id, adolescent.location_id)