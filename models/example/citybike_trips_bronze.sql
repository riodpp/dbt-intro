{{ 
    config(
        alias='citybike_trips_bronze',
        materialized='table'
    ) 
}}

SELECT *
FROM `bigquery-public-data.new_york_citibike.citibike_trips`