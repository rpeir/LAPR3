CREATE OR REPLACE FUNCTION FatorDeRisco (
    search_codInterno IN Clientes.codInterno%TYPE    -- Codigo Interno do Cliente
) RETURN NUMBER

is
fatorDeRisco NUMBER; -- variavel de retorno
valorTotalIncidentesUltimosDozeMeses NUMBER;
numeroEncomendasDepoisUltimoIncidente NUMBER;
dataUltimoIncidente DATE;
search_codigoDoPedido NUMBER; -- o valor total esta na tabela Pedidos
search_dataPedido DATE; -- data do pedido
begin
    -- obter o valor total dos incidentes nos ultimos 12 meses
    SELECT SUM(valorTotal) INTO valorTotalIncidentesUltimosDozeMeses
    FROM(SELECT Pedidos.codPedido, Pedidos.valorTotal, Incidentes.codIncidente, Incidentes.dataOcorrencia, Incidentes.codInterno FROM Pedidos INNER JOIN Incidentes ON Pedidos.codPedido = Incidentes.codPedido)
    WHERE codInterno = search_codInterno
    AND dataOcorrencia BETWEEN SYSDATE AND add_months(SYSDATE, -12);

    -- obter a data do ultimo incidente
    SELECT dataOcorrencia
    INTO dataUltimoIncidente
    FROM Incidentes
    WHERE codIncidente=(SELECT max(codIncidente) FROM Incidentes);

    -- obter o numero de encomendas por pagar depois do ultimo incidente
    SELECT COUNT(codPedido) INTO numeroEncomendasDepoisUltimoIncidente
    FROM(SELECT Pedidos_Pagamentos_Entregas.codPedido, Pedidos_Pagamentos_Entregas.estadoAtual, Pedidos.codInterno, Pedidos.dataPedido FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido)
    WHERE codInterno = search_codInterno
    AND estadoAtual = 'Nao Pago'
    AND dataPedido >= dataUltimoIncidente;

    -- obter o fator de risco
    if numeroEncomendasDepoisUltimoIncidente = 0 then
        fatorDeRisco := 0;
        dbms_output.put_line('Fator de risco: ' || fatorDeRisco);
    else
        fatorDeRisco := valorTotalIncidentesUltimosDozeMeses / numeroEncomendasDepoisUltimoIncidente;
        dbms_output.put_line('Fator de risco: ' || fatorDeRisco);
    end if;

    return fatorDeRisco;

end;
/