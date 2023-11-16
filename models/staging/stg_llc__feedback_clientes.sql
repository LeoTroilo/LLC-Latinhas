{{ config(
    materialized="view"
) }}

select
    cast(id_feedback as integer) as id_feedback
    ,cast(id_cliente as integer) as id_cliente
    ,cast(avaliacao as integer) as avaliacao
    ,cast(comentario as string) as comentario
from {{ source('llc_latinhas', 'feedback_clientes') }}