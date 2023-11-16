{{ config(
    materialized="view"
) }}

select 
    cast(id_devolucao as integer) as id_devolucao
    ,cast(id_venda as integer) as id_venda
    ,cast(qtd_devolvida as integer) as qtd_devolvida
    ,cast(motivo as string) as motivo
from {{ source('llc_latinhas', 'devolucoes') }}