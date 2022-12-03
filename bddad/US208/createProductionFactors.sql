--Função que cria um fator de produção
CREATE OR REPLACE FUNCTION createFatorProducao(tipo FatoresProducao.tipoFatorProducao%type,preco FatoresProducao.precoKg%type,nome FatoresProducao.nomeComercial%type, form FatoresProducao.formulacao%type) return integer
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