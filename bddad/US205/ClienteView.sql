CREATE VIEW ClienteTotalVendasView AS SELECT codInterno "Codigo Interno", (
    SELECT COUNT(codInterno) FROM (SELECT Pedidos_Pagamentos_Entregas.codPedido, Pedidos_Pagamentos_Entregas.estadoAtual, Pedidos.codInterno, Pedidos.dataPedido FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido)
    WHERE codInterno = c.codInterno
    AND estadoAtual = 'P'
    AND dataPedido BETWEEN SYSDATE AND add_months(SYSDATE, -12)
) AS "Total vendas nos ultimos 12 meses"
FROM Clientes c;

CREATE VIEW DataUltimoIncidente AS
SELECT codInterno "Codigo Interno",
       (CASE WHEN (SELECT max(TO_CHAR(dataOcorrencia, 'DD-MM-YYYY'))
                  FROM incidentes i
                  WHERE i.codInterno = c.codinterno) IS NULL
             THEN 'Sem incidentes à data'
             ELSE (SELECT max(TO_CHAR(dataOcorrencia, 'DD-MM-YYYY'))
                   FROM incidentes i
                   WHERE i.codInterno = c.codinterno)
        END) AS "Data do ultimo incidente"
FROM Clientes c;

CREATE VIEW EncomendasEntreguesNaoPagas AS SELECT codInterno "Codigo Interno", (
    SELECT COUNT(codInterno) FROM (SELECT Pedidos_Pagamentos_Entregas.codPedido, Pedidos_Pagamentos_Entregas.codPagamento, Pedidos_Pagamentos_Entregas.estadoAtual, Pedidos.codInterno, Pedidos.dataPedido FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido)
    WHERE codInterno = c.codInterno
    AND estadoAtual = 'E'
    AND codPagamento IS NULL
) AS "Encomendas entregues mas nao pagas"
FROM Clientes c;

CREATE VIEW NivelCliente AS
SELECT c.codInterno, c.nome, n.designacaoNivel
FROM Clientes c
INNER JOIN Clientes_Niveis cn ON c.codInterno = cn.codInterno
INNER JOIN Niveis n ON cn.codNivel = n.codNivel;

