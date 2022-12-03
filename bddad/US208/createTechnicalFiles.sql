--Função que cria ficha técnica
CREATE OR REPLACE FUNCTION createFichaTecnica(codFator FichasTecnicas.codFatorProducao%type) return integer
IS
    DECLARE codFicha integer;
BEGIN
IF (EXISTS(SELECT * FROM FichasTecnicas WHERE codFator = FichasTecnicas.codFatorProducao))
THEN
UPDATE FichasTecnicas SET codFicha = :new.codFichaTecnica WHERE codFatorProducao= codFator;
ELSE
INSERT INTO FichasTecnicas (codFatorProducao,codFatorProducao) VALUES (codFicha,codFator) RETURNING codFicha INTO codigoFichaTecnica;
END IF;
RETURN codigoFichaTecnica;
END;

