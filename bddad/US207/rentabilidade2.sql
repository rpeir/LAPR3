-- lucro por hectar em cada setor
CREATE OR REPLACE PROCEDURE lucroDeUmSetor
(search_codColheita IN SetoresAgricolas_Colheitas_Culturas.codColheita%type,
search_SetoresAgricolas IN SetoresAgricolas.codSetorAgricola%type)

is
lucro NUMBER;
denominador NUMBER;
qntNumSetor NUMBER;
precoUmaUnidade NUMBER;

begin
    -- obter a quantidade produzida de uma colheita especifica em cada setor de um setor agricola especifico
    SELECT SUM(valorSetor) INTO qntNumSetor
    FROM SetoresAgricolas_Colheitas_Culturas
    WHERE codColheita = search_codColheita
    AND codSetorAgricola = search_SetoresAgricolas;

    -- obter a area total de um setor agricola especifico
    SELECT areaSetorAgricola INTO denominador
    FROM SetoresAgricolas
    WHERE codSetorAgricola = search_SetoresAgricolas;

    -- o preco de uma unidade de produto daquela colheita especifica naquele setor
    SELECT precoKg INTO precoUmaUnidade
    FROM (SELECT Produtos.codCultura, Produtos.precoKg, SetoresAgricolas_Colheitas_Culturas.codSetorAgricola, SetoresAgricolas_Colheitas_Culturas.codColheita FROM Produtos INNER JOIN SetoresAgricolas_Colheitas_Culturas ON Produtos.codCultura = SetoresAgricolas_Colheitas_Culturas.codCultura)
    WHERE codColheita = search_codColheita
    AND codSetorAgricola = search_SetoresAgricolas;

    lucro := (qntNumSetor*1000/denominador) * precoUmaUnidade;

    dbms_output.put_line('Lucro por hectar em cada setor: ' || lucro);

end;
/



