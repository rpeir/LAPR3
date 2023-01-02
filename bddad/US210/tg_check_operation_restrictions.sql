Create or Replace Trigger tg_check_operation_restrictions
After Insert or Update
On CalendariosOperacoes
-- For Each Row [when trigger_restriction]
Declare
noRestriction Exception;
BEGIN
select * from AplicacaoFatorProducao
where codOperacao=:new.codOperacao;

-- Exception
-- caso o select seja vazio, significa que a operação não tem restriçoes associadas
-- caso o select não seja vazio, significa que a operação tem restriçoes associadas e serao impressos os dados
END;