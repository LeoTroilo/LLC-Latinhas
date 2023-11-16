{{ config(
    materialized='view',
    unique_key='id_feedback'
) }}

select
  *
from llc_latinhas.feedback_clientes