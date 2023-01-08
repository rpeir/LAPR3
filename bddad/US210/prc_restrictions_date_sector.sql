create or replace Procedure prc_restrictions_date_sector(dataIns date, codSA SetoresAgricolas.codSetorAgricola%type)
AS
exEx exception;
temp_codZG integer;
numberRegists integer;
BEGIN
select codZonaGeografica INTO temp_codZG
from SetoresAgricolas
where codSetorAgricola=codSA;

-- obtem o numero de restricoes com o codigo de zona geografica encontrado em cima
select COUNT(*) into numberRegists from Restricoes where codZonaGeografica=temp_codZG;


-- Caso existam registos, cria uma view com os resultados
if (numberRegists>=1) then
EXECUTE IMMEDIATE 'create or replace View "v_RestricoesSetorData" As
select designacaoRestricao,codZonaGeografica,codFatorProducao
from Restricoes
where codZonaGeografica=temp_codZG and Restricoes.dataInicio <=dataIns and dataIns <= Restricoes.dataInicio+Restricoes.duracao;' using temp_codZG,dataIns;


else
raise exEx;
END IF;

exception
when exEx then
RAISE_APPLICATION_ERROR(-20037,'There are no restriction for the inserted date and sector ');


END;


