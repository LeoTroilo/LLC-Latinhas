{{ config(
    materialized="view",
    partition_by={
      "field": "data_venda",
      "data_type": "timestamp",
      "granularity": "day",
      "time_ingestion_partitioning": true
    }
) }}

select 
    cast(id_venda as integer) as id_venda
    ,cast(id_produto as integer) as id_produto
    ,cast(id_cliente as integer) as id_cliente
    ,cast(qtd_vendida as integer) as qtd_vendida
    ,cast(valor_total as numeric) as valor_total
    ,cast(data_venda as timestamp) as data_venda
from {{ source('llc_latinhas', 'vendas') }}