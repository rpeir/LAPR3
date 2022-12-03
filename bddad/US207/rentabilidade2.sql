-- lucro por hectar em cada setor
CREATE OR REPLACE PROCEDURE lucroDeUmSetor
(search_codColheita IN SetoresAgricolas_Colheitas_Culturas.codColheita%type,
search_codInstalacaoAgricola IN InstalacoesAgricolas.codInstalacaoAgricola%type,
search_codSetor IN SetoresAgricolas.codSetorAgricola%type)

is
lucro NUMBER;
denominador NUMBER;
qntNumSetor NUMBER;
precoUmaUnidade NUMBER;

begin
    -- obter a quantidade produzida de uma colheita especifica em cada setor de uma instalacao agricola
    SELECT SUM(valorSetor) INTO qntNumSetor

    FROM (SELECT InstalacoesAgricolas.codInstalacaoAgricola,
    SetoresAgricolas_Colheitas_Culturas.codColheita,
    SetoresAgricolas_Colheitas_Culturas.codSetorAgricola,
    SetoresAgricolas_Colheitas_Culturas.valorSetor
    FROM InstalacoesAgricolas INNER JOIN SetoresAgricolas_Colheitas_Culturas
    ON InstalacoesAgricolas.codInstalacaoAgricola = search_codInstalacaoAgricola)

    WHERE codColheita = search_codColheita
    AND codSetorAgricola = search_codSetor
    AND codInstalacaoAgricola = search_codInstalacaoAgricola;

    -- obter a area total de um setor agricola especifico de uma instalacao agricola especifica
    SELECT areaSetorAgricola INTO denominador
    FROM SetoresAgricolas
    WHERE codSetorAgricola = search_codSetor
    AND codInstalacaoAgricola = search_codInstalacaoAgricola;

    -- o preco de uma unidade de produto daquela colheita especifica naquele setor especifico na instalacao agricola especifica
    SELECT precoKg INTO precoUmaUnidade

    FROM (SELECT Produtos.codCultura,
    Produtos.precoKg,
    SetoresAgricolas_Colheitas_Culturas.codSetorAgricola,
    SetoresAgricolas_Colheitas_Culturas.codColheita
    FROM Produtos INNER JOIN SetoresAgricolas_Colheitas_Culturas
    ON Produtos.codCultura = SetoresAgricolas_Colheitas_Culturas.codCultura)

    WHERE codColheita = search_codColheita
    AND codSetorAgricola = search_codSetor;

    lucro := (qntNumSetor*1000/denominador) * precoUmaUnidade;

    dbms_output.put_line('Lucro por hectar em cada setor: ' || lucro);

end;
/



