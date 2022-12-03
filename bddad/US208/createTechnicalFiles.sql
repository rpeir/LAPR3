--Função que cria ficha técnica
CREATE OR ALTER FUNCTION createFichaTecnica(codFator FichasTecnicas.codFatorProducao%type) return integer
IS
    DECLARE codFicha integer;
BEGIN
IF (EXISTS(SELECT * FROM FichasTecnicas WHERE codFator = FichasTecnicas.codFatorProducao))
THEN
UPDATE FichasTecnicas SET codFicha = :new.codFichaTecnica WHERE codFatorProducao= codFator;
ELSE
INSERT INTO FichasTecnicas (codFatorProducao,codFatorProducao) VALUES (codFicha,codFator) RETURNING codFicha INTO codigoFichaTecnica;
END
END IF;
RETURN codigoFichaTecnica;
END;

