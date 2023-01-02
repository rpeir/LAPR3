CREATE OR REPLACE Procedure registerOperation(tipoOperacao Operacoes.tipo%type,formaAplicacao Operacoes.formaAplicacao%type,produto Operacoes.codproduto%type,quantidade Operacoes.quantidade%type,dataRealizacao Operacoes.dataOperacao%type)
AS
invalidOperation Exception;
BEGIN
insert into Operacoes Values (tipoOperacao,formaAplicacao,produto,quantidade,dataRealizacao);
Exception
when invalidOperation then
RAISE_APPLICATION_ERROR(-20001,'Invalid Operation Parameters');
END;
