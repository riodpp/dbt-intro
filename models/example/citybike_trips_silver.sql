{{ 
    config(
        alias='citybike_trips_silver',
        materialized='table'
    ) 
}}

SELECT
  tripduration,
  starttime,
  stoptime,
  start_station_id,
  start_station_name,
  start_station_latitude,
  start_station_longitude,
  end_station_id,
  end_station_name,
  end_station_latitude,
  end_station_longitude,
  bikeid,
  usertype,
  birth_year,
  gender as gender_desc,
  TIMESTAMP_TRUNC(starttime, HOUR) as start_hour,
  EXTRACT(YEAR FROM starttime) as start_year,
  EXTRACT(MONTH FROM starttime) as start_month
FROM {{ ref('citybike_trips_bronze') }}
WHERE tripduration > 60 AND tripduration < 86400