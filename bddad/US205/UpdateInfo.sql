CREATE OR REPLACE procedure UpdateInfo (
    search_codInterno IN Clientes.codInterno%TYPE    -- Codigo Interno do Cliente
)

is
numeroTotalEncomendasUltimoAno NUMBER;
valorTotalEncomendasUltimoAno NUMBER;

begin
    -- obter o numero total de encomendas no ultimo ano
    SELECT COUNT(codPedido) INTO numeroTotalEncomendasUltimoAno
    FROM Pedidos
    WHERE codInterno = search_codInterno
    AND dataPedido BETWEEN SYSDATE AND add_months(SYSDATE, -12);

    -- obter o valor total das encomendas no ultimo ano
    SELECT SUM(valorTotal) INTO valorTotalEncomendasUltimoAno
    FROM Pedidos
    WHERE codInterno = search_codInterno
    AND dataPedido BETWEEN SYSDATE AND add_months(SYSDATE, -12);

    -- mostrar resultados
    dbms_output.put_line('Numero total de encomendas no ultimo ano: ' || numeroTotalEncomendasUltimoAno);
    dbms_output.put_line('Valor total das encomendas no ultimo ano: ' || valorTotalEncomendasUltimoAno);

end;
/