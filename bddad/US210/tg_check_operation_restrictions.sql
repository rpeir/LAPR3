create or replace Trigger tg_check_operation_restrictions
after insert 
on AplicacaoFatorProducao
for each row
Declare
ex exception;
temp_codFP integer;
numberRegists integer;

BEGIN
select codFatorProducao into temp_codFP
from AplicacaoFatorProducao
where codOperacao=NEW.codOperacao,codSetorAgricola=NEW.codSetorAgricola,codCultura=NEW.codCultura,qtFatorProducao=NEW.qtFatorProducao;

select COUNT(*) into numberRegists from AplicacaoFatorProducao where codFatorProducao=temp_codFP;
if(numberRegists>=1) then
execute immediate 'create or replace View "v_Restricao" As
select codZonaGeografica, dataInicio, codFatorProducao
from Restricoes
where codFatorProducao=temp_codFP;' using temp_codFP;

else 
raise ex;
END IF;

Exception
when ex then
RAISE_APPLICATION_ERROR(-20033,'There are no restrictions for the inserted operation');
END;