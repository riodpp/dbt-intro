{{ config(materialized='view') }}

with source_data as (

    select "Hello" as id
    union all
    select "World" as id

)

select *
from source_data