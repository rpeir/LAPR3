create of replace Procedure prc_restrictions_date_sector(dataIns date, codSA SetorAgricola.codSetorAgricola%type)
as
dataEx exception;
codSAEx exception;
exEx exception;
BEGIN
if(dataIns is null) then
raise dataEx;
end if;

if(codSA is null) then
raise codSAEx;
end if;

select codZonaGeografica INTO temp_codZG
from SetoresAgricolas
where codSetorAgricola=codSA;

-- obtem o numero de restricoes com o codigo de zona geografica encontrado em cima
select COUNT(*) into numberRegists from Restricoes where codZonaGeografica=temp_codZG;


-- Caso existam registos, cria uma view com os resultados
if (numberRegists>=1) then
create or replace View "v_Restricoes_Setor_Data" As
select designacaoRestricao,codZonaGeografica,codFatorProducao
from Restricoes
where codZonaGeografica=temp_codZG and Restricoes.dataInicio <=dataIns and dataIns <= Restricoes.dataInicio+Restricoes.duracao;


else
raise exEx;
END IF;

exception
when exEx then
RAISE_APPLICATION_ERROR(-20037,'There are no restriction for the inserted date and sector ');

when dataEx then
RAISE_APPLICATION_ERROR(-20038,'The inserted date is null ');

when codSAEx then 
RAISE_APPLICATION_ERROR(-20039,'The inserted sector is null ');

END;

