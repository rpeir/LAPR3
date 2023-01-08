create or replace Procedure check_calendar (ano CalendariosOperacoes.ano%type) 
As
anoEx exception;
BEGIN
--obtem o codigo do calendario que corresponde ao ano inserido
select codCalendarioOperacoes into temp_cod
from CalendariosOperacoes
where anoCalendarioOperacoes=ano;
-- obtem o numero de operacoes com o codigo de calendario encontrado em cima
select COUNT(*) into numberRegists from Operacoes where codCalendarioOperacoes=temp_cod;


-- Caso existam registos, cria uma view com os resultados
if (numberRegists>=1) then
create or replace View "v_Calendario" As
select Operacoes.codOperacao, Operacoes.dataOperacao, Operacoes.tipoOperacao
from Operacoes
where operacoes.codCalendarioOperacoes=temp_cod;
-- para usar a view select* from "Calendario"

else
raise anoEx;
END IF;

exception
when anoEx then
RAISE_APPLICATION_ERROR(-20032,'There are no registers for the inserted year ');

END;