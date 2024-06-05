{{ config(materialized='view') }}

select *
from {{ ref('citybike_trips_gold')}}