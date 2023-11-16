{{ config(
    materialized='view',
    unique_key='id_vendas'
) }}

select
  *
from llc_latinhas.vendas