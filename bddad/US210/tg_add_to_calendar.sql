Create or Replace Trigger tg_add_to_calendar
After Insert
On Operacoes
-- For Each Row [when trigger_restriction]
Declare
existingOperation Exception;
BEGIN
-- verificar se a operação já existe
if select Count(select * from CalendarioOperacoes where codOperacao = :new.codOperacao)=0
then
-- caso nao exista, inserir na tabela CalendarioOperacoes
Insert into CalendariosOperacoes (codCalendarioOperacoes,anoCalendarioOperacoes,codOperacao) Values (codCalendarioOperacoes,anoCalendarioOperacoes,codOperacao);
else RAISE_APPLICATION_ERROR(-20022,'The operation already exists');
end if;
END;