--cria a ficha tecnica de um componente
CREATE OR ALTER FUNCTION createFichaTecnicaComponente(codFicha FichasTecnicas_Componentes.codFichaTecnica%type,codComp FichasTecnicas_Componentes.codComponente%type,unid FichasTecnicas_Componentes.unidade%type,qnt FichasTecnicas_Componentes.quantidade%type) return integer
IS
    DECLARE codFichaComp integer;
BEGIN
IF (EXISTS(SELECT * FROM FichasTecnicas_Componentes WHERE codFicha = FichasTecnicas_Componentes.codFichaTecnica AND codComp = FichasTecnicas_Componentes.codComponente))
THEN
UPDATE FichasTecnicas_Componentes SET codFichaTecnica = codFicha, codComponente = codComp, unidade = unid, quantidade = qnt WHERE codFichaTecnica = FichasTecnicas_Componentes.codFichaTecnica AND codComponente = FichasTecnicas_Componentes.codComponente;
ELSE
INSERT INTO FichasTecnicas_Componentes (codFichaTecnica,codComponente,unidade,quantidade) VALUES (codFicha,codComp,unid,qnt) RETURNING codFichaTecnica INTO codFichaComp;
END
END IF;
RETURN codFichaComp;
END;