--CONSTRAINTS CHECK
--##Clientes##
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(1,'P','Joao','Test1@sapo.pt',1000,'123456789'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(1,'P','Carlos','Test2@sapo.pt',1000,'123456709'); --(REPROVADO)
    --O código interno tem de ser único, pelo que o segundo insert não é aceite
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(2,'A','Maria','maria@sapo.pt',1000,'111111111'); --(REPROVADO)
    --O tipo tem de ser P ou E, logo o insert não é executado
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(2,'','Maria','maria@sapo.pt',1000,'111111111'); --(REPROVADO)
    --O tipo não pode ser nulo, logo o insert não é executado
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(2,'P','Maria','maria@sapo.pt',1000,'111111111'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(3,'P','','a1@sapo.pt',1000,'111111111'); --(REPROVADO)
    --O nome não pode ser nulo, logo o insert não é executado
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(3,'P','Maria','a1@sapo.pt',1000,'111111112'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'P','Maria','a1@sapo.pt',1000,'111111113');  --(REPROVADO)
    --O email tem de ser único, pelo que o segundo insert não é aceite
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'E','Jose','a2@sapo.pt', '' ,'111111114'); --(REPROVADO)
    --O plafond não pode ser nulo, logo o insert não é executado
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'E','Jose','a2@sapo.pt,',1000,'111111114'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(5,'E','Jose','a3@sapo.pt',1000,'111111114'); --(REPROVADO)
    --O nrFiscal tem de ser único, pelo que o segundo insert não é aceite



--##Moradas##
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'',1,1,'1D','5400-093','Porto','Portugal'); --(REPROVADO)
    --A rua não pode ser nula, logo o insert não é executado
     insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria','' ,1,'1D','5400-093','Porto','Portugal'); --(REPROVADO)
    --O número do edifício não pode ser nulo, logo o insert não é executado
     insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','','Porto','Portugal'); --(REPROVADO)
    --O código postal não pode ser nulo, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400093','Porto','Portugal'); --(REPROVADO)
    --O código postal tem de ter o formato 0000-000, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093','','Portugal'); --(REPROVADO)
    --A localidade não pode ser nula, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093','Porto',''); --(REPROVADO)
    --O país não pode ser nulo, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093','Porto','Portugal'); --(APROVADO)

--##MoradasCorrespondencia##
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(null,1); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,null); --(REPROVADO)
    --O código da morada não pode ser nulo, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,1); --(APROVADO)
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,2); --(APROVADO)
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(2,1); --(APROVADO)
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(100000,10000000); --(REROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,10000000); --(REROVADO)
    --O código da morada não existe, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,1); --(REPROVADO)
    --O código interno já existe, logo o insert não é executado

--##MoradasEntrega##
    insert into MoradasEntrega(codInterno,codMorada) VALUES(null,1); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,null); --(REPROVADO)
    --O código da morada não pode ser nulo, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,1); --(APROVADO)
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,2); --(APROVADO)
    insert into MoradasEntrega(codInterno,codMorada) VALUES(2,1); --(APROVADO)
    insert into MoradasEntrega(codInterno,codMorada) VALUES(100000,10000000); --(REROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,10000000); --(REROVADO)
    --O código da morada não existe, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,1); --(REPROVADO)
    --O código interno e o código de morada já existem, logo o insert não é executado


--##Niveis##    
    insert into Niveis(codNivel,designacaoNivel) VALUES(1,'A'); --(APROVADO)
    insert into Niveis(codNivel,designacaoNivel) VALUES(null,'B'); --(REPROVADO)
    --O código do nível não pode ser nulo, logo o insert não é executado
    insert into Niveis(codNivel,designacaoNivel) VALUES(1,''); --(REROVADO)
    --A designação do nível não pode ser nula, logo o insert não é executado
    insert into Niveis(codNivel,designacaoNivel) VALUES(1,'A'); --(REPROVADO)
    --O código do nível já existe, logo o insert não é executado
    insert into Niveis(codNivel,designacaoNivel) VALUES(2,'D'); --(REPROVADO)
    -- A designação do nível tem de ser A,B ou C logo o insert não é executado

--##Clientes_Niveis##    

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(1,1,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(APROVADO)
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(1,1,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(10,1,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(null,1,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,null,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código do nível não pode ser nulo, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,10,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código do nível não existe, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,1,null); --(REPROVADO)
    --A data de atribuição não pode ser nula, logo o insert não é executado


--##Pedidos##
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(1,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(APROVADO)
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(1,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(null,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O código do pedido não pode ser nulo, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,10,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,null,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O valor total não pode ser nulo, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,0,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O valor total tem de ser maior que 0, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,110.2,null,TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --A data do pedido não pode ser nula, logo o insert não é executado
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),null); --(REPROVADO)
    --A data de vencimento não pode ser nula, logo o insert não é executado

--##Pagamentos##    

    insert into Pagamentos(codPagamento,dataPagamento) VALUES(1,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(APROVADO)
    insert into Pagamentos(codPagamento,dataPagamento) VALUES(1,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Pagamentos(codPagamento,dataPagamento) VALUES(null,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código do pagamento não pode ser nulo, logo o insert não é executado


--##Colheitas##
    insert into Colheitas(codColheita,anoColheita) VALUES(1,2015); --(APROVADO)
    insert into Colheitas(codColheita,anoColheita) VALUES(1,2015); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Colheitas(codColheita,anoColheita) VALUES(null,2015); --(REPROVADO)
    --O código da colheita não pode ser nulo, logo o insert não é executado
    insert into Colheitas(codColheita,anoColheita) VALUES(1,null); --(REPROVADO)
    --O ano da colheita não pode ser nulo, logo o insert não é executado


--##Culturas##
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(1,'Cultura 1','P','C',1); --(APROVADO)
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(1,'Cultura 1','P','C',1); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(null,'Cultura 1','P','C',1); --(REPROVADO)
    --O código da cultura não pode ser nulo, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,null,'P','C',1); --(REPROVADO)
    --A designação da cultura não pode ser nula, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1',null,'C',1); --(REPROVADO)
    --O tipo da cultura não pode ser nulo, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','A','C',1); --(REPROVADO)
    --O tipo da cultura não pode ser diferente de P ou T, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P',null,1); --(REPROVADO)
    --O objetivo da cultura não pode ser nulo, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P','B',1); --(REPROVADO)
    --O objetivo da cultura não pode ser diferente de C ou A, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P','C',null); --(REPROVADO)
    --O tempo de crescimento não pode ser nulo, logo o insert não é executado

--##Plano Anual##
insert into PlanosAnuais(anoPlanoAnual) VALUES(2000); --(APROVADO)
insert into PlanosAnuais(anoPlanoAnual) VALUES(2000); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into PlanosAnuais(anoPlanoAnual) VALUES(null); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado


--##Calendario Operações##
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(1,2000); --(APROVADO)
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(1,2020); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(null,2000); --(REPROVADO)
--O código do calendário de operações não pode ser nulo, logo o insert não é executado
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(100000,2000); --(REPROVADO)
--O código do calendário de operações não existe, logo o insert não é executado
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(1,null); --(REPROVADO)
--O ano do calendário de operações não pode ser nulo, logo o insert não é executado
insert into CalendariosOperacoes(codCalendarioOperacoes,anoCalendarioOperacoes) VALUES(2,2000); --(REPROVADO)
--O ano do calendário de operações é único, logo o insert não é executado




--##Operações##
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','M'); --(APROVADO)
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(null,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código da operação não pode ser nulo, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,null,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,100000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,null,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código do calendário de operações não pode ser nulo, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,100000,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código do calendário de operações não existe, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,null,TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--A data prevista do plano não pode ser nula, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),null,'F','C'); --(REPROVADO)
--A data da operação não pode ser nula, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'','C'); --(REPROVADO)
--A forma de aplicação não pode ser nula, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F',''); --(REPROVADO)
--O estado da operação não pode ser nulo, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'A','M'); --(REPROVADO)
--A forma de aplicação só pode ser F,FR or S, logo o insert não é executado
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','D'); --(REPROVADO)
--O estado da operação só pode ser C ou M, logo o insert não é executado

--##Regas##
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,1); --(APROVADO)
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,null,1); --(REPROVADO)
--O código da operação não pode ser nulo, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,20,1); --(REPROVADO)
--O código da operação não existe, logo o insert não é executado
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,null); --(REPROVADO)
--O tempo da rega não pode ser nulo, logo o insert não é executado 

--##Instalações Agrícolas##
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,'Instalação Agrícola 1'); --(APROVADO)
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,'Instalação Agrícola 1'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,null,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não pode ser nulo, logo o insert não é executado
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,20,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,null); --(REPROVADO)
--A designação da instalação agrícola não pode ser nula, logo o insert não é executado
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(2,1000,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado

--##Zonas Geograficas##
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1,'Zona Geográfica 1'); --(APROVADO)
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1,'Zona Geográfica 1'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(3,1000,'Zona Geográfica 1'); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(3,1,null); --(REPROVADO)
--A designação da zona geográfica não pode ser nula, logo o insert não é executado

--##Setores Agrícolas##
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,'Setor Agrícola 1',1); --(APROVADO)
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,'Setor Agrícola 1',1); --(REPROVADO)
-- chave primária já existe, logo o insert não é executado
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(4,1,1000,'Setor Agrícola 1',1); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(4,1,1,null,'1'); --(REPROVADO)
--A designação do setor agrícola não pode ser nula, logo o insert não é executado
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(4,1,1,'Setor Agrícola 1',null); --(REPROVADO)
--A área do setor agrícola não pode ser nula, logo o insert não é executado

--##Aplicação Regas##
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'G'); --(APROVADO)
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'G'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(2,null,1,'G'); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1000,1,'G'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,null,'G'); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1000,'G'); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,null); --(REPROVADO)
--O tipo de rega não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'A'); --(REPROVADO)
--O tipo de rega assume o valor G ou B, logo o insert não é executado


--##Incidentes##
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1,TO_DATE('2018-01-01', 'YYYY/MM/DD')); --(APROVADO)
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1,TO_DATE('2018-01-01', 'YYYY/MM/DD')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(3,1000,1,1,TO_DATE('2018-01-01', 'YYYY/MM/DD')); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(5,1,1000,1,TO_DATE('2018-01-01', 'YYYY/MM/DD')); --(REPROVADO)
--O código interno não existe, logo o insert não é executado
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(7,1,1,1000,TO_DATE('2018-01-01', 'YYYY/MM/DD')); --(REPROVADO)
--O código do pagamento não existe, logo o insert não é executado
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(8,1,1,1,null); --(REPROVADO)
--A data de ocorrência não pode ser nula, logo o insert não é executado



--##Produtos##
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,1,'Produto 1'); --(APROVADO)
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,1,'Produto 2'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(10000,1,1,1,1,'Produto 1'); --(REPROVADO)
--O código do produto não existe, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,null,1,'Produto 72'); --(REPROVADO)
--O preço por kg não pode ser nulo, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,null,'Produto 82'); --(REPROVADO)
--O stock em kg não pode ser nulo, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(3,1,1,1,1,'Produto 1'); --(REPROVADO)
--A designação do produto não pode ser repetida, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(19,100000,1,1,1,'Produto 29'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(15,1,1087000,1,1,'Produto 26'); --(REPROVADO)
--O código da colheita não existe, logo o insert não é executado

--##Pedidos_Produtos##
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,1); --(APROVADO)
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(100000,1,1,1); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(12,10000,1,1); --(REPROVADO)
--O código do produto não existe, logo o insert não é executado
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(6,1,100000,1); --(REPROVADO)
--A quantidade do produto não pode ser superior ao stock, logo o insert não é executado
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,null); --(REPROVADO)
--O preço do pedido não pode ser nulo, logo o insert não é executado

--##Entregas##
insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(APROVADO)
insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(12,100000,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado


--##Pedidos_Pagamentos_Entregas##
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'P'); --(APROVADO)
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'P'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1000002,1,1,'P'); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,100000,1,'P'); --(REPROVADO)
--O código do pagamento não existe, logo o insert não é executado
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,100000,'P'); --(REPROVADO)
--O código da entrega não existe, logo o insert não é executado
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,null); --(REPROVADO)
--O estado atual não pode ser nulo, logo o insert não é executado
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'A'); --(REPROVADO)
--O estado atual não pode ser diferente de R,E ou P, logo o insert não é executado



--##Colheitas_Culturas##
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,1); --(APROVADO)
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(104000,1,1); --(REPROVADO)
--O código da colheita não existe, logo o insert não é executado
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,100000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,null); --(REPROVADO)
--O valor total da colheita não pode ser nulo, logo o insert não é executado
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,-1); --(REPROVADO)
--O valor total da colheita não pode ser negativo, logo o insert não é executado

--##SetoresAgricolas_Culturas##
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(APROVADO)
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1000200,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1040000,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,null); --(REPROVADO)
--A data de plantação não pode ser nula, logo o insert não é executado

--##Planos Rega##
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,1); --(APROVADO)
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(null,1,1,1); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(100000,1,1,1); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,null,1,1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,100000,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,null,1); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,100000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,null); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,100000); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado

--##Culturas Regas##
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1,1,'A'); --(APROVADO)  --A;G;P
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1,1,'A'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(null,1,'A'); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(100000,1,'A'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1, null,'A'); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1,100000,'A'); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1,1,''); --(REPROVADO)
--O tipo de distribuição não pode ser nulo, logo o insert não é executado
insert into Culturas_Regas(codCultura,codRega,tipoDistribuicao) values(1,1,'B'); --(REPROVADO)
--O tipo de distribuição só pode ser A;G;P, logo o insert não é executado

--##Planos Anuais setores Agricolas##
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,1); --(APROVADO)
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(null,1,1,1); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(100000,1,1,1); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,null,1,1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,100000,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,null,1); --(REPROVADO)
--A ordem de rega não pode ser nula, logo o insert não é executado
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,null); --(REPROVADO)
--A periodicidade de rega do setor não pode ser nula, logo o insert não é executado

--##FatoresProducao##
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(1,'FE',1,'Fertilizante 1','G'); --(APROVADO)
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(1,'FE',1,'Fertilizante 2','G'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,'FB',1,'Fertilizante 1','G'); --(REPROVADO)
--O tipo de fator de produção só pode ser FE,CO,FI ou AD, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,null,1,'Fertilizante 1','G'); --(REPROVADO)
--O tipo de fator de produção não pode ser nulo, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,'FE',null,'Fertilizante 1','G'); --(REPROVADO)
--O preço do fator de produção não pode ser nulo, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,'FE',1,'Fertilizante 1','G'); --(REPROVADO)
--O nome comercial é único, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,'FE',1,'Fertilizante 1','O'); --(REPROVADO)
--A formulação só pode ser G,P ou L, logo o insert não é executado
insert into FatoresProducao(codFatorProducao,tipoFatorProducao,precoKg,nomeComercial,formulacao) values(2,'FE',1,'Fertilizante 1',null); --(REPROVADO)
--A formulação não pode ser nula, logo o insert não é executado

--##Aplicação Fatores de Produção##
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,1); --(APROVADO)
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(10041000,1,1,1,1); --(REPROVADO)
--O código da operação não existe, logo o insert não é executado
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,10032000,1,1,1); --(REPROVADO)
--O código do fator de produção não existe, logo o insert não é executado
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,23,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,103210000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,null); --(REPROVADO)
--A quantidade do fator de produção não pode ser nula, logo o insert não é executado


--##SetoresAgricolas_Colheitas_Culturas##
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1,1,1); --(APROVADO)
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(100321000,1,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1031230000,1,1); --(REPROVADO)
--O código da colheita não existe, logo o insert não é executado
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1,1000030,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1,1,null); --(REPROVADO)
--O valor do setor não pode ser nulo, logo o insert não é executado
insert into SetoresAgricolas_Colheitas_Culturas(codSetorAgricola,codColheita,codCultura,valorSetor) values(1,1,1,-1); --(REPROVADO)
--O valor do setor não pode ser negativo, logo o insert não é executado

--##Edificios##
insert into Edificios(codEdificio,codInstalacaoAgricola,tipoEdificio) values(1,1,'G'); --(APROVADO)
insert into Edificios(codEdificio,codInstalacaoAgricola,tipoEdificio) values(1,1,'A'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Edificios(codEdificio,codInstalacaoAgricola,tipoEdificio) values(13,100002310,'G'); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado
insert into Edificios(codEdificio,codInstalacaoAgricola,tipoEdificio) values(21,1,'O'); --(REPROVADO)
--O tipo do edifício não pode ser diferente de G,A,E ou R, logo o insert não é executado
insert into Edificios(codEdificio,codInstalacaoAgricola,tipoEdificio) values(1,1,null); --(REPROVADO)
--O tipo do edifício não pode ser nulo, logo o insert não é executado

--##Restricoes##
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(1,1,TO_DATE('2019-01-01', 'YYYY/MM/DD'),1); --(APROVADO)
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(1,1,TO_DATE('2019-01-01', 'YYYY//MM/DD'),1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(100000,1,TO_DATE('2019-01-01', 'YYYY/MM/DD'),1); --(REPROVADO)
--O código da zona geográfica não existe, logo o insert não é executado
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(1,100000,TO_DATE('2019-01-01', 'YYYY/MM/DD'),1); --(REPROVADO)
--O código do fator de produção não existe, logo o insert não é executado
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(1,1,null,1); --(REPROVADO)
--A data de início não pode ser nula, logo o insert não é executado
insert into Restricoes(codZonaGeografica,codFatorProducao,dataInicio,duracao) values(1,1,TO_DATE('2019-01-01', 'YYYY/MM/DD'),null); --(REPROVADO)
--A duração não pode ser nula, logo o insert não é executado


--##Tipos Sensores##
insert into TiposSensores(codTipoSensor) values('HS'); --(APROVADO)
insert into TiposSensores(codTipoSensor) values('HS'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into TiposSensores(codTipoSensor) values(null); --(REPROVADO)
--O código do tipo de sensor não pode ser nulo, logo o insert não é executado
insert into TiposSensores(codTipoSensor) values('KL'); --(REPROVADO)
--O código do tipo de sensor só pode ser HS,VV,PI,TS,TA,HA ou PA, logo o insert não é executado


--##EstacaoesMeteorologicas##
insert into EstacoesMeteorologicas(codEstacaoMeteorologica,codZonaGeografica) VALUES(1,1); --(APROVADO)
insert into EstacoesMeteorologicas(codEstacaoMeteorologica,codZonaGeografica) VALUES(1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into EstacoesMeteorologicas(codEstacaoMeteorologica,codZonaGeografica) VALUES(12,10003200); --(REPROVADO)
--O código da zona geográfica não existe, logo o insert não é executado

--##Sensores##
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('12345','HS',1,10); --(APROVADO)
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('12345','HS',1,10); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values(null,'HS',1,10); --(REPROVADO)
--O id do sensor não pode ser nulo, logo o insert não é executado
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('12395','LK',1,11); --(REPROVADO)
--O código do tipo de sensor só pode ser HS,VV,PI,TS,TA,HA ou PA, logo o insert não é executado
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('9345','HS',100,15); --(REPROVADO)
--O código da estação meteorológica não existe, logo o insert não é executado
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('1325','HS',100,15); --(REPROVADO)
--O valor de referência não pode ser repetido, logo o insert não é executado
insert into Sensores(idSensor,codTipoSensor,codEstacaoMeteorologica,valorReferencia) Values('12355','HS',1,-1); --(REPROVADO)
--O valor de referência não pode ser negativo, logo o insert não é executado

--##Leituras##
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(1,'12345',TO_DATE('2019-01-01 , 12:19:31' ,'YY/MM/DD, hh:mi:ss '),10); --(APROVADO)
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(1,'12345',TO_DATE('01-01-2019, 12:19:31', 'dd/MM/yyyy, hh:mi:ss '),10); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(21,'11000',TO_DATE('01-01-2019, 12:19:31', 'dd/MM/yyyy, hh:mi:ss '),10); --(REPROVADO)
--O id do sensor não existe, logo o insert não é executado
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(23,'12545',null,10); --(REPROVADO)
--O instante da leitura não pode ser nulo, logo o insert não é executado
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(2,'12545',TO_DATE('01-01-2019, 12:19:31', 'dd/MM/yyyy, hh:mi:ss '),null); --(REPROVADO)
--O valor lido não pode ser nulo, logo o insert não é executado
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(2,'12545',TO_DATE('01-01-2019, 12:19:31', 'dd/MM/yyyy, hh:mi:ss '),101); --(REPROVADO)
--O valor lido não pode ser maior que o valor 100, logo o insert não é executado
insert into Leituras(codLeitura,idSensor,instanteLeitura,valorLido) values(2,'12545',TO_DATE('01-01-2019, 12:19:31', 'dd/MM/yyyy, hh:mi:ss '),-1); --(REPROVADO)
--O valor lido não pode ser menor que o valor 0, logo o insert não é executado

--##FichasTecnicas##
insert into FichasTecnicas(codFichaTecnica,codFatorProducao) values(1,1); --(APROVADO)
insert into FichasTecnicas(codFichaTecnica,codFatorProducao) values(1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into FichasTecnicas(codFichaTecnica,codFatorProducao) values(2,100); --(REPROVADO)
--O código do fator de produção não existe, logo o insert não é executado

--##Componentes##
insert into Componentes(codComponente,substancia,categoria) values(1,'agua','categoria 1'); --(APROVADO)
insert into Componentes(codComponente,substancia,categoria) values(1,'nitrogenio','categoria 2'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into Componentes(codComponente,substancia,categoria) values(2,'agua','categoria 1'); --(REPROVADO)
--A substância não pode ser repetida, logo o insert não é executado
insert into Componentes(codComponente,substancia,categoria) values(3,'açucar',''); --(REPROVADO)
--A categoria não pode ser nula, logo o insert não é executado

--##FichasTecnicas_Componentes##
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(1,1,'litros',10); --(APROVADO)
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(1,1,'litros',10); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values (null,1,'litros',10); --(REPROVADO)
--O código da ficha técnica não pode ser nulo, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(2,'','litros',10); --(REPROVADO)
--O código do componente não pode ser nulo, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(1000,1,'litros',10); --(REPROVADO)
--O código da ficha técnica não existe, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(2,1000,'litros',10); --(REPROVADO)
--O código do componente não existe, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(2,1,null,10); --(REPROVADO)
--A unidade não pode ser nula, logo o insert não é executado
insert into FichasTecnicas_Componentes(codFichaTecnica,codComponente,unidade,quantidade) values(2,1,'litros',null); --(REPROVADO)
--A quantidade não pode ser nula, logo o insert não é executado










































