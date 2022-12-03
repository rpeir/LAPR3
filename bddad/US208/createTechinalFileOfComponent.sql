--cria a ficha tecnica de um componente
CREATE OR ALTER FUNCTION createFichaTecnicaComponente(codFicha FichasTecnicas_Componentes.codFichaTecnica%type,codComp FichasTecnicas_Componentes.codComponente%type,unid FichasTecnicas_Componentes.unidade%type,qnt FichasTecnicas_Componentes.quantidade%type) return integer
AS
    DECLARE codFichaComp integer;
BEGIN
IF (EXISTS(SELECT * FROM FICHATECNICA_COMPONENTE WHERE codFicha = FichasTecnicas_Componentes.codFichaTecnica AND codComp = FichasTecnicas_Componentes.codComponente))
THEN
UPDATE FICHATECNICA_COMPONENTE SET codFichaTecnica = codFicha, codComponente = codComp, unidade = unid, quantidade = qnt WHERE codFichaTecnica = FichasTecnicas_Componentes.codFichaTecnica AND codComponente = FichasTecnicas_Componentes.codComponente;
ELSE
INSERT INTO FICHATECNICA_COMPONENTE (codFichaTecnica,codComponente,unidade,quantidade) VALUES (codFicha,codComp,unid,qnt) RETURNING codFichaTecnica INTO codFichaComp;
END
END IF;
RETURN codFichaComp;
END;