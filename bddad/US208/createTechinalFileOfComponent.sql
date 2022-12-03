--cria a ficha tecnica de um componente
CREATE OR REPLACE FUNCTION createFichaTecnicaComponente(codFicha FichasTecnicas_Componentes.codFichaTecnica%type,codComp FichasTecnicas_Componentes.codComponente%type,unid FichasTecnicas_Componentes.unidade%type,qnt FichasTecnicas_Componentes.quantidade%type) return integer
IS
codFichaComp integer;
countFichaComp integer;
BEGIN
select COUNT(*)
into countFichaComp
from FichasTecnicas_Componentes 
where codFicha= FichasTecnicas_Componentes.codFichaTecnica and codComp=FichasTecnicas_Componentes.codComponente; 
IF (countFichaComp=1)
THEN
UPDATE FichasTecnicas_Componentes SET codFichaTecnica = codFicha, codComponente = codComp, unidade = unid, quantidade = qnt WHERE codFichaTecnica = FichasTecnicas_Componentes.codFichaTecnica AND codComponente = FichasTecnicas_Componentes.codComponente;
ELSE
INSERT INTO FichasTecnicas_Componentes (codFichaTecnica,codComponente,unidade,quantidade) VALUES (codFicha,codComp,unid,qnt) RETURNING codFichaTecnica INTO codFichaComp;
END IF;
RETURN codFichaComp;
END;