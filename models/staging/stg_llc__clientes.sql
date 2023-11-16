{{ config(
    materialized="view"
) }}

select 
    cast(id_cliente as integer) as id_cliente
    ,cast(nome_cliente as string) as nome_cliente
    ,cast(uf as string) as estado
    ,cast(cidade as string) as cidade
from {{ source('llc_latinhas', 'clientes') }}