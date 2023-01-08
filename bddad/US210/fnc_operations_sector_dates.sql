create Procedureprc_operations_sector_dates(codSA SetorAgricola.codSetorAgricola%type, dataI date, dataF date)
as
dataIEx exception;
dataFEx exception;
codSAEx exception;
exEx exception;
BEGIN
if(dataI is null) then
raise dataIEx;
end if;

if(dataF is null) then
raise dataFEx;
end if;

if(codSA is null) then
raise codSAEx;
end if;

select codOperacao into temp_codOp
from Operacoes
where codSetorAgricola=codSA and dataOperacao>=dataI and dataOperacao<=dataF;

select COUNT(*) into numberRegists from Operacoes where codOperacao=temp_codOp;
if (numberRegists>=1) then
create or replace View "v_Operacoes" As
select *
from Operacoes
where codOperacao=temp_codOp;
order by dataOperacao ASC;

else
raise exEx;
END IF;

exception
when exEx then
RAISE_APPLICATION_ERROR(-20034,'There are no operations for the inserted sector and dates ');

when dataIEx then
RAISE_APPLICATION_ERROR(-20035,'The inserted initial date is null ');

when dataFEx then
RAISE_APPLICATION_ERROR(-20036,'The inserted final date is null ');

when codSAEx then
RAISE_APPLICATION_ERROR(-20040,'The inserted sector is null ');

END;