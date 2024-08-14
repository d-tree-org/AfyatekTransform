SELECT
    loc.ward_id,
    loc.ward_name,
    loc.district_id,
    loc.district_name,
    coalesce(member.start,adolescent.start,child.start) as "start",
    coalesce(member.end,adolescent.end,child.end) as "end",
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
    coalesce(member.preferred_name,adolescent.preferred_name,child.preferred_name) as preferred_name,
    coalesce(member.disabilities,adolescent.disabilities,child.disabilities) as disabilities,
    coalesce(member.nutrition_status,adolescent.nutrition_status,child.nutrition_status) as nutrition_status,
    coalesce(member.rhc_card,adolescent.rhc_card,child.rhc_card) as rhc_card,
    coalesce(member.fam_consent,adolescent.fam_consent,child.fam_consent) as fam_consent,
    CASE
        WHEN child.base_entity_id IS NOT null THEN 'child'
        WHEN member.base_entity_id IS NOT null THEN 'member'
    END AS client_type,
    coalesce(child.event_ids, member.event_ids, adolescent.event_ids) AS event_ids

FROM {{ ref('child_registration') }} AS child
FULL JOIN {{ ref('family_member') }} AS member
    ON child.event_ids = member.event_ids
FULL JOIN {{ ref('adolescent_registration') }} AS adolescent
    ON anc.event_ids = adolescent.event_ids
LEFT JOIN
    {{ source('afyatek_data', 'openmrs_location_mapping_final') }} AS loc
    ON loc.location_id = coalesce(child.location_id, adolescent.location_id, adolescent.location_id)