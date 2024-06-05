{{ 
    config(
        alias='citybike_trips_gold',
        materialized='table'
    ) 
}}

SELECT
  start_station_name,
  end_station_name,
  COUNT(*) AS total_trips,
  AVG(tripduration) AS avg_duration,
  MIN(tripduration) AS min_duration,
  MAX(tripduration) AS max_duration,
  start_year,
  start_month
FROM {{ ref('citybike_trips_silver') }}
WHERE tripduration > 60 AND tripduration < 86400
GROUP BY start_station_name, end_station_name, start_year, start_month