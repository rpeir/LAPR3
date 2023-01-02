Create or Replace Function fnc_restrictions_date_sector(dataIns Restricoes.dataInicio%type, codZG SetorAgricola.codZonaGeografica%type) return sys_refcursor 
is
v_result sys_refcursor;
declare
restricao_ex Exception;
BEGIN
open v_result for
select Restricao.designacao
from Restricoes 
inner join SetoresAgricolas ON SetoresAgricolas.codZonageografica = Restricoes.codZonaGeografica
where codZonaGeografica = codZG and dataInicio <= dataIns and dataInicio + duracao >= dataIns;
return (v_result);
END;
--if v_result != null then
--Return Restricoes.designacao;
--else
--RAISE_APPLICATION_ERROR(-20023,'There is no restriction for this date and sector');
--END IF;