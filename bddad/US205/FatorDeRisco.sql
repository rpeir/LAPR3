CREATE OR REPLACE procedure FatorDeRisco (
    search_codInterno IN Clientes.codInterno%TYPE    -- Codigo Interno do Cliente
)
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
    SELECT max(TO_CHAR(dataOcorrencia, 'DD-MM-YYYY')) INTO dataUltimoIncidente
                      FROM incidentes i
                      WHERE i.codInterno = search_codInterno;

    -- obter o numero de encomendas por pagar depois do ultimo incidente
    SELECT COUNT(codPedido) INTO numeroEncomendasDepoisUltimoIncidente
    FROM(SELECT Pedidos_Pagamentos_Entregas.codPedido, Pedidos_Pagamentos_Entregas.estadoAtual, Pedidos.codInterno, Pedidos.dataPedido FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido)
    WHERE codInterno = search_codInterno
    AND estadoAtual = 'R'
    AND dataPedido >= dataUltimoIncidente;

    -- obter o fator de risco
    if numeroEncomendasDepoisUltimoIncidente = 0 then
        fatorDeRisco := 0;
        dbms_output.put_line('Fator de risco: ' || fatorDeRisco);
    else
        fatorDeRisco := valorTotalIncidentesUltimosDozeMeses / numeroEncomendasDepoisUltimoIncidente;
        dbms_output.put_line('Fator de risco: ' || fatorDeRisco);
    end if;

end;
/

begin
fatorderisco(3);
end;
/
