{{ config(
    materialized='view',
    unique_key='id_cliente'
) }}

select
  *
from llc_latinhas.clientes