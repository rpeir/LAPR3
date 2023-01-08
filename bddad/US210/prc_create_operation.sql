CREATE OR REPLACE Procedure registerOperation(tipo_Operacao Operacoes.tipoOperacao%type, setor Operacoes.codSetorAgricola%type, cultura Operacoes.codCultura%type, forma_Aplicacao Operacoes.formaAplicacao%type, codFP AplicacaoFatorProducao.codFatorProducao%type, quantidade AplicacaoFatorProducao.qtFatorProducao%type, dataRealizacao Operacoes.dataOperacao%type)
AS
dateEx exception;
c_operacao integer;

BEGIN	

if(dataRealizacao < SYSDATE) then
raise dateEx;
END IF;


insert into Operacoes(codSetorAgricola,codCultura,dataOperacao,tipoOperacao,formaAplicacao) Values (setor,cultura,dataRealizacao,tipo_Operacao,forma_Aplicacao) returning codOperacao into c_operacao;
if(tipo_Operacao !='I') then
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) Values (c_operacao,codFP,setor,cultura,quantidade);
END IF;

exception
when dateEx then
RAISE_APPLICATION_ERROR(-20001,'Invalid date');

END;
