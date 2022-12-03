--Função que cria um fator de produção
CREATE OR ALTER FUNCTION createFatorProducao(tipo FatoresProducao.tipoFatorProducao%type,preco FatoresProducao.precoKg%type,nome FatoresProducao.nomeComercial%type, form FatoresProducao.formulacao%type) return integer
IS
    DECLARE codFator integer;
BEGIN
IF (EXISTS(SELECT * FROM FatoresProducao WHERE codFator= FatoresProducao.codFatorProducao))
THEN
UPDATE FatoresProducao SET tipoDistribuicao = tipo, precoKg = preco, nomeComercial=nome  WHERE codFator=FatoresProducao.codFatorProducao;
ELSE
INSERT INTO FatoresProducao (codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) VALUES (:new.codFatorProducao,tipo,preco,nome,form) RETURNING codFatorProducao INTO codFator;
END
END IF;
RETURN codFator;
END;
