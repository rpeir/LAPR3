CREATE OR REPLACE PROCEDURE check_calendar (ano CalendariosOperacoes.anoCalendarioOperacoes%type) 
AS
anoEx exception;
temp_cod integer;
numberRegists integer;
BEGIN
--obtem o codigo do calendario que corresponde ao ano inserido
select codCalendarioOperacoes into temp_cod
from CalendariosOperacoes
where anoCalendarioOperacoes=ano;
-- obtem o numero de operacoes com o codigo de calendario encontrado em cima
select COUNT(*) into numberRegists from Operacoes where codCalendarioOperacoes=temp_cod;


-- Caso existam registos, cria uma view com os resultados
if (numberRegists>=1) then
EXECUTE IMMEDIATE 'create or replace View "v_Calendario" AS
select Operacoes.codOperacao, Operacoes.dataOperacao, Operacoes.tipoOperacao 
from Operacoes
where operacoes.codCalendarioOperacoes=:temp_cod' using temp_cod;
-- para usar a view select* from "Calendario"

else
raise anoEx;
END IF;

exception
when anoEx then
RAISE_APPLICATION_ERROR(-20032,'There are no registers for the inserted year ');

END;
