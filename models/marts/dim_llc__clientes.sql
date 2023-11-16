{{ config(
    materialized="table"
) }}

with 

vendas as 
(
    select
        distinct 
        id_cliente
        ,count(id_venda) as qtd_vendas
        ,sum(valor_total) as faturamento_total
    from {{ ref('stg_llc__vendas') }}
    group by 1
),

feedback as
(
    select 
        id_cliente
        ,comentario
    from {{ ref('stg_llc__feedback_clientes') }}
)

select 
    c.id_cliente
    ,c.nome_cliente
    ,c.estado
    ,c.cidade
    ,v.qtd_vendas as qtd_vendas
    ,v.faturamento_total 
    ,f.comentario as avaliacao
from {{ ref('stg_llc__clientes') }} c
    left join vendas v on v.id_cliente = c.id_cliente
    left join feedback f on f.id_cliente = c.id_cliente
order by 1