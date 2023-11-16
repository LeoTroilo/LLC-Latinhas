{{ config(
    materialized='view',
    unique_key='id_devolucao'
) }}

select
  *
from llc_latinhas.devolucoes