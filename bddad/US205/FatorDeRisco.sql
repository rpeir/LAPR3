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
    -- obter o codigo do pedido
    SELECT codPedido
    INTO search_codigoDoPedido
    FROM Pedidos
    WHERE codInterno = search_codInterno;

    -- obter o valor total nos ultimos 12 meses
    SELECT valorTotal
    INTO valorTotalIncidentesUltimosDozeMeses
    FROM Pedidos
    WHERE codInterno = search_codInterno
    AND dataPedido BETWEEN add_months(sysdate, -12) AND SYSDATE;

    SELECT dataPedido
    INTO search_dataPedido
    FROM Pedidos
    WHERE codPedido = search_codigoDoPedido;

    -- obter o numero de encomendas nao pagas depois do ultimo incidente
    SELECT COUNT(*)
    INTO numeroEncomendasDepoisUltimoIncidente
    FROM Pedidos_Pagamentos_Entregas
    WHERE codPedido = search_codigoDoPedido
    AND estadoAtual = 'Nao Pago'
    AND (search_dataPedido) < dataUltimoIncidente;

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