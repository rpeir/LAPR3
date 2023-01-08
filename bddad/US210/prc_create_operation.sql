CREATE OR REPLACE Procedure registerOperation(tipo_Operacao Operacoes.tipoOperacao%type,setorAgricola Operacoes.codSetorAgricola%type,cultura Operacoes.codCultura%type,forma_Aplicacao Operacoes.formaAplicacao%type,codFP AplicacaoFatorProducao.codFatorProducao%type,quantidade AplicacaoFatorProducao.qtFatorProducao%type,dataRealizacao varchar(10))
AS
typeOperationEx exception;
wayApplicationEx exception;

BEGIN
if (tipo_Operacao !='I' and tipo_Operacao !='A' and tipo_Operacao != 'FP') then
raise typeOperationEx;
END IF;

if(forma_Aplicacao !='F' and forma_Aplicacao !='FR' and formaAplicacao != 'S') then
raise wayApplicationEx;
END IF;



insert into Operacoes(codSetorAgricola,codCultura,dataOperacao,tipoOperacao,formaAplicacao) Values (setorAgricola,cultura,TO_DATE(dataRealizacao,"MM/DD/YYYY"),tipo_Operacao,forma_Aplicacao) returning codOperacao into c_operacao;
if(tipoOperacao !='I') then
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao,dataAplicacao) Values (c_operacao,codFP,setor,cultura,quantidade,TO_DATE(dataRealizacao,"MM/DD/YYYY"));
END IF;

exception
when typeOperationEx then
RAISE_APPLICATION_ERROR(-20001,'Invalid type of operation');

when wayApplicationEx then
RAISE_APPLICATION_ERROR(-20002,'Invalid way of application');

END;
