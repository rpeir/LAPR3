create or replace Procedure prc_operations_sector_dates(codSA SetoresAgricolas.codSetorAgricola%type, dataI date, dataF date)
as
exEx exception;
temp_codOp integer;
numberRegists integer;
BEGIN
select codOperacao into temp_codOp
from Operacoes
where codSetorAgricola=codSA and dataOperacao>=dataI and dataOperacao<=dataF;

select COUNT(*) into numberRegists from Operacoes where codOperacao=temp_codOp;
if (numberRegists>=1) then
EXECUTE IMMEDIATE 'create or replace View "v_Operacoes" As
select *
from Operacoes
where codOperacao=temp_codOp;
order by dataOperacao ASC;' using temp_codOp;

else
raise exEx;
END IF;

exception
when exEx then
RAISE_APPLICATION_ERROR(-20034,'There are no operations for the inserted sector and dates ');

END;