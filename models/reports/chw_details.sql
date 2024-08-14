SELECT
    chw.chw_username AS provider_id,
    chw.given_name || ' ' || chw.family_name AS "name",
    chw.*,
    phone.phone_number,
    phone,
    network,
    loc.district_name,
    loc.village_name

FROM {{ source("afyatek_data","openmrs_user_mapping_final") }} AS chw
LEFT JOIN {{ source("afyatek_data","chw_phone_numbers" ) }} AS phone
    ON chw.chw_username = phone.provider_id
LEFT JOIN {{ source("afyatek_data","openmrs_location_mapping_final" ) }} AS loc
    ON chw.user_location_id = loc.id
