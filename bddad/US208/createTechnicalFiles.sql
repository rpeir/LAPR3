--Função que cria ficha técnica
CREATE OR REPLACE FUNCTION createFichaTecnica(codFator FichasTecnicas.codFatorProducao%type) return integer
IS
    codFicha integer;
    countTecnica integer;
BEGIN
select COUNT(*)
into countTecnica
from FichasTecnicas 
where codFicha=FichasTecnicas.codFichaTecnica;
IF (countTecnica=1)
THEN
UPDATE FichasTecnicas SET codFatorProducao =codFator WHERE codFicha= codFichaTecnica;
ELSE
INSERT INTO FichasTecnicas (codFatorProducao) VALUES (codFator) RETURNING codFicha INTO codFicha;
END IF;
RETURN codFicha;
END;

