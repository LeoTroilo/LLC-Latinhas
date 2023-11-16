{{ config(
    materialized="table"
) }}

WITH 

preco_produto AS (
    SELECT
        id_produto
        ,CAST(SUM(valor_total) AS NUMERIC) / NULLIF(CAST(SUM(qtd_vendida) AS NUMERIC), 0) AS valor_produto
    FROM {{ ref('stg_llc__vendas') }}
    GROUP BY 1
),

produtos_vendidos as 
(
    SELECT 
        id_produto
        ,sum(qtd_vendida) as qtd_vendida_total
    from {{ ref('stg_llc__vendas') }}
    group by 1
),

devolucao AS 
(
    SELECT
        v.id_produto
        ,sum(d.qtd_devolvida) as devolucoes
    from {{ ref('stg_llc__devolucoes') }} d
        left join {{ ref('stg_llc__vendas') }} v on v.id_venda = d.id_venda
        group by 1
)

SELECT 
    distinct
    p.id_produto
    ,p.nome_produto
    ,cast(p.estoque_inicial as numeric) + cast(p.unidades_produzidas as numeric) qtd_produtos_estoque
    ,pv.qtd_vendida_total
    ,round(pp.valor_produto, 2) as valor_produto
    ,case 
    when d.devolucoes is null then 0
    else d.devolucoes 
    end as qtd_produtos_devolvidos
FROM {{ ref('stg_llc__produtos') }} p
    LEFT JOIN preco_produto pp ON p.id_produto = pp.id_produto
    LEFT JOIN devolucao d on d.id_produto = p.id_produto
    LEFT JOIN produtos_vendidos pv on pv.id_produto = p.id_produto
order by 1