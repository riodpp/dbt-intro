{{
    config(
        materialized='view',
        alias='bikeshare_trips'
    )
}}

SELECT
    trip_id,
    duration_sec,
    duration_sec/60 as duration_min,
    start_date AS start_timestamp,
    CAST(start_date AS DATE) AS start_date,
    start_station_name,
    start_station_id,
    end_date AS end_timestamp,
    CAST(end_date AS DATE) AS end_date,
    end_station_name,
    end_station_id,
    bike_number,
    zip_code,
    subscriber_type,
    c_subscription_type,
    start_station_latitude,
    start_station_longitude,
    end_station_latitude,
    end_station_longitude,
    member_birth_year,
    CASE
        WHEN member_birth_year IS NOT NULL THEN EXTRACT(YEAR FROM CURRENT_DATE()) - member_birth_year
        ELSE NULL
    END AS member_age,
    CASE
        WHEN member_birth_year IS NOT NULL THEN
            CASE
                WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - member_birth_year BETWEEN 0 AND 18 THEN 'child'
                WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - member_birth_year BETWEEN 19 AND 29 THEN 'young_adult'
                WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - member_birth_year BETWEEN 30 AND 59 THEN 'adult'
                WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - member_birth_year BETWEEN 60 AND 99 THEN 'senior'
                ELSE 'senior'
            END
        ELSE NULL
    END AS member_age_group,
    member_gender,
    bike_share_for_all_trip,
    start_station_geom,
    end_station_geom
FROM {{ source('san_francisco_bikeshare', 'bikeshare_trips')}}