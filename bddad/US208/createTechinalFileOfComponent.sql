--cria a ficha tecnica de um componente
CREATE OR REPLACE FUNCTION createFichaTecnicaComponente(codFicha FichasTecnicas_Componentes.codFichaTecnica%type,codComp FichasTecnicas_Componentes.codComponente%type,unid FichasTecnicas_Componentes.unidade%type,qnt FichasTecnicas_Componentes.quantidade%type) return integer
IS
codFichaComp integer;
countFichaComp integer;
BEGIN
-- verifica se ja existe a ficha tecnica do componente
select COUNT(*)
into countFichaComp
from FichasTecnicas_Componentes 
where codFicha= FichasTecnicas_Componentes.codFichaTecnica and codComp=FichasTecnicas_Componentes.codComponente; 
IF (countFichaComp=1) --caso exista, atualiza a ficha tecnica do componente existente com os novos dados
THEN
UPDATE FichasTecnicas_Componentes SET codFichaTecnica = codFicha, codComponente = codComp, unidade = unid, quantidade = qnt WHERE codFichaTecnica = FichasTecnicas_Componentes.codFichaTecnica AND codComponente = FichasTecnicas_Componentes.codComponente; -- inves de atualizar,talvez seria mais correto criar um novo
ELSE
INSERT INTO FichasTecnicas_Componentes (codFichaTecnica,codComponente,unidade,quantidade) VALUES (codFicha,codComp,unid,qnt) RETURNING codFichaTecnica INTO codFichaComp; --caso não exista, cria uma nova ficha tecnica do componente
END IF;
RETURN codFichaComp; --retorna o codigo da ficha tecnica do componente criada
END;
END;

--Função que cria ficha técnica com um fator de produção
CREATE OR REPLACE FUNCTION createFichaTecnica(codFator FichasTecnicas.codFatorProducao%type) return integer
IS
    codFicha integer;
    countTecnica integer;
BEGIN
-- verifica se ja existe a ficha tecnica
select COUNT(*)
into countTecnica
from FichasTecnicas 
where codFicha=FichasTecnicas.codFichaTecnica; -- where codFator=FichasTecnicas.codFatorProducao;
IF (countTecnica=1) --caso exista, atualiza a ficha tecnica existente com os novos dados
THEN
UPDATE FichasTecnicas SET codFatorProducao =codFator WHERE codFicha= codFichaTecnica; -- inves de atualizar,talvez seria mais correto dar mensagem de erro
ELSE
INSERT INTO FichasTecnicas (codFatorProducao) VALUES (codFator) RETURNING codFicha INTO codFicha; --caso não exista, cria uma nova ficha tecnica
END IF;
RETURN codFicha; --retorna o codigo da ficha tecnica criada
END;
--Função que cria um fator de produção
CREATE OR REPLACE FUNCTION createFatorProducao(tipo FatoresProducao.tipoFatorProducao%type,preco FatoresProducao.precoKg%type,nome FatoresProducao.nomeComercial%type, formulacao FatoresProducao.formulacao%type) return integer
IS
    codFator integer;
   	countFator integer; 
BEGIN
-- verifica se ja existe o fator de produção
select COUNT(*)
into countFator
from FatoresProducao 
where codFator= FatoresProducao.codFatorProducao ; -- where tipo= FatoresProducao.tipoFatorProducao and preco= FatoresProducao.precoKg and nome= FatoresProducao.nomeComercial and formulacao= FatoresProducao.formulacao;
IF (countFator=1) --caso exista, atualiza o fator de produção existente com os novos dados
THEN
UPDATE FatoresProducao SET tipoFatorProducao = tipo, precoKg = preco, nomeComercial=nome  WHERE codFator=FatoresProducao.codFatorProducao; -- inves de atualizar,talvez seria mais correto dar mensagem de erro
ELSE --caso não exista, cria um novo fator de produção
INSERT INTO FatoresProducao (tipoFatorProducao,precoKg,nomeComercial,formulacao) VALUES (tipo,preco,nome,form) RETURNING codFatorProducao INTO codFator;
END IF;
RETURN codFator; --retorna o codigo do fator de produção criado
END;

--Função que cria um componente
CREATE OR REPLACE FUNCTION createComponente(subs Componentes.substancia%type, catg Componentes.categoria%type) return integer
IS
    codComp integer;
    countComp integer;
BEGIN
-- verifica se ja existe o componente
select COUNT(*)
into countComp
from Componentes 
where codComp=Componentes.codComponente; -- where subs=Componentes.substancia and catg=Componentes.categoria;
IF (countComp=1) --caso exista, atualiza o componente existente com os novos dados
THEN
UPDATE Componentes SET substancia = subs, categoria=catg WHERE codComp = Componentes.codComponente; -- inves de atualizar,talvez seria mais correto dar mensagem de erro
ELSE --caso não exista, cria um novo componente
INSERT INTO Componentes (substancia,categoria) VALUES (subs,catg) RETURNING codComponente INTO codComp;
END IF;
RETURN codComp; -- retorna o codigo do componente criado
END;

--Falta uma funcao onde seriam agregadas todas as funcções e as respetivas chamadas