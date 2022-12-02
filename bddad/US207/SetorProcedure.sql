CREATE OR REPLACE FUNCTION quantidadePorSetorAgricolaDescrescente (
search_codColheita IN Colheitas_Culturas.codColheita%TYPE
) RETURN NUMBER

begin
    SELECT valorTotalColheita
    FROM Colheitas_Culturas
    WHERE codColheita = search_codColheita
    ORDER BY valorTotalColheita DESC;
end;
/

