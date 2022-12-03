--Função que cria um fator de produção
CREATE OR ALTER FUNCTION createFatorProducao(tipo FatoresProducao.tipoFatorProducao%type,preco FatoresProducao.precoKg%type,nome FatoresProducao.nomeComercial%type, form FatoresProducao.formulacao%type) return integer
AS
    DECLARE codFator integer;
BEGIN
IF (EXISTS(SELECT * FROM FATOREPRODUCAO WHERE codFator= FatoresProducao.codFatorProducao))
THEN
UPDATE FATORPRODUCAO SET tipoDistribuicao = tipo, precoKg = preco, nomeComercial=nome  WHERE codFator=FatoresProducao.codFatorProducao;
ELSE
INSERT INTO FATORPRODUCAO (codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) VALUES (:new.codFatorProducao,tipo,preco,nome,form) RETURNING codFatorProducao INTO codFator;
END
END IF;
RETURN codFator;
END;
