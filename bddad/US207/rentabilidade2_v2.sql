CREATE OR REPLACE PROCEDURE lucroDeUmSetorCursor (
search_codColheita SetoresAgricolas_Colheitas_Culturas.codColheita%type,
search_codInstalacaoAgricola InstalacoesAgricolas.codInstalacaoAgricola%type)

AS
denominador NUMBER;
qntNumSetor NUMBER;
precoUmaUnidade NUMBER;
c_codSetorAgricola SetoresAgricolas_Colheitas_Culturas.codSetorAgricola%type;
c_codCultura SetoresAgricolas_Colheitas_Culturas.codCultura%type;
lucro NUMBER;

CURSOR c_cursor (codColheita SetoresAgricolas_Colheitas_Culturas.codColheita%type,
         codInstalacaoAgricola InstalacoesAgricolas.codInstalacaoAgricola%type) IS

        SELECT SetoresAgricolas_Colheitas_Culturas.codSetorAgricola,
               SetoresAgricolas_Colheitas_Culturas.codCultura
        FROM SetoresAgricolas_Colheitas_Culturas
        WHERE codColheita = codColheita
        AND codSetorAgricola IN (SELECT codSetorAgricola FROM SetoresAgricolas
                                    WHERE codInstalacaoAgricola = codInstalacaoAgricola);



 begin
    OPEN c_cursor(search_codColheita, search_codInstalacaoAgricola);
    LOOP
        FETCH c_cursor INTO c_codSetorAgricola, c_codCultura;
        EXIT WHEN c_cursor%notfound;
        -- obter a quantidade produzida de uma colheita especifica em cada setor de uma instalacao agricola
                     SELECT SUM(valorSetor) INTO qntNumSetor

                     FROM (SELECT InstalacoesAgricolas.codInstalacaoAgricola,
                     SetoresAgricolas_Colheitas_Culturas.codColheita,
                     SetoresAgricolas_Colheitas_Culturas.codSetorAgricola,
                     SetoresAgricolas_Colheitas_Culturas.valorSetor
                     FROM InstalacoesAgricolas INNER JOIN SetoresAgricolas_Colheitas_Culturas
                     ON InstalacoesAgricolas.codInstalacaoAgricola = search_codInstalacaoAgricola)

                     WHERE codColheita = search_codColheita
                     AND codInstalacaoAgricola = search_codInstalacaoAgricola;

                     -- obter a area total de um setor agricola especifico de uma instalacao agricola especifica
                     SELECT areaSetorAgricola INTO denominador
                     FROM SetoresAgricolas
                     WHERE codInstalacaoAgricola = search_codInstalacaoAgricola;

                     -- o preco de uma unidade de produto daquela colheita especifica naquele setor especifico na instalacao agricola especifica
                     SELECT precoKg INTO precoUmaUnidade
                     FROM (SELECT precoKG FROM Produtos WHERE c_codCultura = codCultura)

                     lucro := (qntNumSetor*1000/denominador) * precoUmaUnidade*0.001;


        dbms_output.put_line(c_codSetorAgricola || '-' ||  c_codCultura || '-' || lucro);
    END LOOP;
    CLOSE c_cursor;
end;
/