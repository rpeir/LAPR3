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

--Função que cria ficha técnica com um fator de produção
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
--Função que cria um fator de produção
CREATE OR REPLACE FUNCTION createFatorProducao(tipo FatoresProducao.tipoFatorProducao%type,preco FatoresProducao.precoKg%type,nome FatoresProducao.nomeComercial%type, formulacao FatoresProducao.formulacao%type) return integer
IS
    codFator integer;
   	countFator integer; 
BEGIN
select COUNT(*)
into countFator
from FatoresProducao 
where codFator= FatoresProducao.codFatorProducao ;
IF (countFator=1)
THEN
UPDATE FatoresProducao SET tipoFatorProducao = tipo, precoKg = preco, nomeComercial=nome  WHERE codFator=FatoresProducao.codFatorProducao;
ELSE
INSERT INTO FatoresProducao (tipoFatorProducao,precoKg,nomeComercial,formulacao) VALUES (tipo,preco,nome,form) RETURNING codFatorProducao INTO codFator;
END IF;
RETURN codFator;
END;
--Função que cria um componente
CREATE OR REPLACE FUNCTION createComponente(subs Componentes.substancia%type, catg Componentes.categoria%type) return integer
IS
    codComp integer;
    countComp integer;
BEGIN
select COUNT(*)
into countComp
from Componentes 
where codComp=Componentes.codComponente; 
IF (countComp=1)
THEN
UPDATE Componentes SET substancia = subs, categoria=catg WHERE codComp = Componentes.codComponente;
ELSE
INSERT INTO Componentes (substancia,categoria) VALUES (subs,catg) RETURNING codComponente INTO codComp;
END IF;
RETURN codComp;
END;