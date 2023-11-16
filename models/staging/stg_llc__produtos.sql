{{ config(
    materialized="view"
) }}

select
    cast(id_produto as integer) as id_produto
    ,cast(nome_produto as string) as nome_produto
    ,cast(estoque_inicial as integer) as estoque_inicial
    ,cast(unidades_produzidas as integer) as unidades_produzidas
from {{ source('llc_latinhas', 'produtos') }}