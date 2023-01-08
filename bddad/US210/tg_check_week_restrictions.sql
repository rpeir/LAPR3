create or replace Trigger tg_check_operation_restrictions
after insert 
on AplicacaoFatorProducao
for each row
Declare
ex exception;
BEGIN
-- Obtem o codigo da operacao que foi inserida
select codOperacao into temp_codOp
from AplicacaoFatorProducao
where codSetorAgricola=NEW.codSetorAgricola,codCultura=NEW.codCultura;

--Obtem a data da operacao que foi inserida
select dataOperacao into temp_dataOp
from Operacoes
where codOperacao=temp_codOp;
--Obtem o codigo do fator de producao que foi inserido
select codFatorProducao into temp_codFP
from AplicacaoFatorProducao
where codOperacao=temp_codOp;

select COUNT(*) into numberRegists from AplicacaoFatorProducao where codFatorProducao=temp_codFP,;
if(numberRegists>=1) then
EXECUTE IMMEDIATE 'create or replace View "v_Restricao_Semana" As
select Restricoes.codZonaGeografica, Restricoes.dataInicio, Restricoes.codFatorProducao
from Restricoes
where Restricoes.codFatorProducao=temp_codFP and Restricoes.dataInicio<=temp_dataOp-7<=Restricoes.dataInicio+Restricoes.duracao;'  using temp_codFP,temp_dataOp;
else 
raise ex;
END IF;

Exception
when ex then
RAISE_APPLICATION_ERROR(-20033,'There are no restrictions for the inserted operation');
END;