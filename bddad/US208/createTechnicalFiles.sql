--Função que cria ficha técnica
CREATE OR ALTER FUNCTION createFichaTecnica(codFator FichasTecnicas.codFatorProducao%type) return integer
AS
    DECLARE codFicha integer;
BEGIN
IF (EXISTS(SELECT * FROM FICHATECNICA WHERE codFator = FichasTecnicas.codFatorProducao))
THEN
UPDATE FICHATECNICA SET codFicha = :new.codFichaTecnica WHERE codFatorProducao= codFator;
ELSE
INSERT INTO FICHATECNICA (codFatorProducao,codFatorProducao) VALUES (codFicha,codFator) RETURNING codFicha INTO codigoFichaTecnica;
END
END IF;
RETURN codigoFichaTecnica;
END;

