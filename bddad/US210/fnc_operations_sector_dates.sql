Create or Replace Function fnc_operations_sector_date(dataIn date,dataFim date) return sys_refcursor 
is
v_result sys_refcursor;
declare
restricao_ex Exception;
BEGIN
open v_result for
select Operacoes.codOperacao
from Operacoes 
inner join SetoresAgricolas ON SetoresAgricolas.codSetorAgricola = Restricoes.codSetorAgricola
where dataIn <= Operacoes.dataOperacao and dataFim >= Operacoes.dataOperacao;
return (v_result);
END;
--if v_result != null then
--Return Restricoes.designacao;
--else
--RAISE_APPLICATION_ERROR(-20023,'There is no restriction for this date and sector');
--END IF;