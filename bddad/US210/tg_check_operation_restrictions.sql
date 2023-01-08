create or replace Trigger tg_check_operation_restrictions
after insert 
on AplicacaoFatorProducao
for each row
Declare
ex exception;
BEGIN
select codFatorProducao into temp_codFP
from AplicacaoFatorProducao
where codOperacao=NEW.codOperacao,codSetorAgricola=NEW.codSetorAgricola,codCultura=NEW.codCultura,qtFatorProducao=NEW.qtFatorProducao;

select COUNT(*) into numberRegists from AplicacaoFatorProducao where codFatorProducao=temp_codFP;
if(numberRegists>=1) then
create or replace View "v_Restricao" As
select Restricoes.codZonaGeografica, Restricoes.dataInicio, Restricoes.codFatorProducao
from Restricoes
where Restricoes.codFatorProducao=temp_codFP;

else 
raise ex;
END IF;

Exception
when ex then
RAISE_APPLICATION_ERROR(-20033,'There are no restrictions for the inserted operation');
END;