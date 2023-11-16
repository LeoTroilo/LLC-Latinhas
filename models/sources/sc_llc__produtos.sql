{{ config(
    materialized='view',
    unique_key='id_produto'
) }}

select
  *
from llc_latinhas.produtos