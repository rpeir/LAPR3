CREATE VIEW ClienteTotalVendasView AS SELECT codInterno "Codigo Interno", (
    SELECT COUNT(codInterno) FROM (SELECT Pedidos_Pagamentos_Entregas.codPedido, Pedidos_Pagamentos_Entregas.estadoAtual, Pedidos.codInterno, Pedidos.dataPedido FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido)
    WHERE codInterno = c.codInterno
    AND estadoAtual = 'Pago'
    AND dataPedido BETWEEN SYSDATE AND add_months(SYSDATE, -12)
) AS "Total vendas nos ultimos 12 meses"
FROM Clientes c;

CREATE VIEW DataUltimoIncidente AS SELECT codInterno "Codigo Interno", (
    SELECT dataOcorrencia
    FROM Incidentes
    WHERE codIncidente=(SELECT max(codIncidente) FROM Incidentes)
) AS "Data do ultimo incidente"
FROM Clientes c;

CREATE VIEW EncomendasEntreguesNaoPagas AS SELECT codInterno "Codigo Interno", (
    SELECT COUNT(codInterno) FROM Pedidos_Pagamentos_Entregas
    WHERE codInterno = c.codInterno
    AND estadoAtual = 'Entregue'
    AND codPagamento IS NULL
) AS "Encomendas entregues mas nao pagas"
FROM Clientes c;


