{{ config(
    materialized="table"
) }}

SELECT 
    v.id_venda
    ,v.id_produto
    ,p.nome_produto
    ,p.valor_produto as valor_unitario
    ,v.id_cliente
    ,c.nome_cliente
    ,v.qtd_vendida
    ,v.valor_total
    ,v.data_venda
    ,CASE
        WHEN d.id_venda IS NULL THEN 'false'
        ELSE 'true'
    END AS is_devolucao
    ,d.qtd_devolvida AS qtd_devolucao
    ,'-'||cast(d.qtd_devolvida as numeric) * cast(p.valor_produto as numeric) as valor_restituido
FROM {{ ref('stg_llc__vendas') }} v
LEFT JOIN {{ ref('dim_llc__produtos') }} p ON p.id_produto = v.id_produto
LEFT JOIN {{ ref('dim_llc__clientes') }} c ON c.id_cliente = v.id_cliente
LEFT JOIN {{ ref('stg_llc__devolucoes') }} d ON d.id_venda = v.id_venda