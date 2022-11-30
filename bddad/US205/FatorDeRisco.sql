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