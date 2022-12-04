create or replace procedure runConstraint
---------------Clientes----------------
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES('','P','Joao','TEST1@sapo.pt',1000,'123456789'); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(1,'P','Joao','Test1@sapo.pt',1000,'123456789'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(1,'P','Carlos','Test2@sapo.pt',1000,'123456709'); --(REPROVADO)
    --O código interno tem de ser único, pelo que o segundo insert não é aceite

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(2,'A','Maria','maria@sapo.pt',1000,'111111111'); --(REPROVADO)
    --O tipo tem de ser P ou E, logo o insert não é executado

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(2,'P','Maria','maria@sapo.pt',1000,'111111111'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(3,'P','','a1@sapo.pt',1000,'111111111'); --(REPROVADO)
    --O nome não pode ser nulo, logo o insert não é executado

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(3,'P','Maria','a1@sapo.pt',1000,'111111112'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'P','Maria','a1@sapo.pt',1000,'111111113');  --(REPROVADO)
    --O email tem de ser único, pelo que o segundo insert não é aceite

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'E','Jose','a2@sapo.pt', ,'111111114'); --(REPROVADO)
    --O plafond não pode ser nulo, logo o insert não é executado

    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(4,'E','Jose','a2@sapo.pt,',1000,'111111114'); --(APROVADO)
    insert into Clientes (codInterno,tipo,nome,emailCliente,plafond,nrFiscal) VALUES(5,'E','Jose','a3@sapo.pt',1000,'111111114'); --(REPROVADO)
    --O nrFiscal tem de ser único, pelo que o segundo insert não é aceite



---------------Moradas----------------
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES('','Rua da Alegria',1,1,'1D','5400-093','Porto','Portugal'); --(REPROVADO)
    --O código da morada não pode ser nulo, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'',1,1,'1D','5400-093','Porto','Portugal'); --(REPROVADO)
    --A rua não pode ser nula, logo o insert não é executado
     insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria', ,1,'1D','5400-093','Porto','Portugal'); --(REPROVADO)
    --O número do edifício não pode ser nulo, logo o insert não é executado
     insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D',' ','Porto','Portugal'); --(REPROVADO)
    --O código postal não pode ser nulo, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400093','Porto','Portugal'); --(REPROVADO)
    --O código postal tem de ter o formato 0000-000, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093',' ','Portugal'); --(REPROVADO)
    --A localidade não pode ser nula, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093','Porto',''); --(REPROVADO)
    --O país não pode ser nulo, logo o insert não é executado
    insert into Moradas (codMorada,rua,nrEdificio,andar,porta,codPostal,localidade,pais) VALUES(1,'Rua da Alegria',1,1,'1D','5400-093','Porto','Portugal'); --(APROVADO)

---------------MoradasCorrespondencia----------------
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(,1); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,); --(REPROVADO)
    --O código da morada não pode ser nulo, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,1); --(APROVADO)
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,2); --(APROVADO)
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(2,1); --(APROVADO)
    insert into MoradasCorrespondencia(codProduto,codMorada) VALUES(100000,10000000); --(REROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,10000000); --(REROVADO)
    --O código da morada não existe, logo o insert não é executado
    insert into MoradasCorrespondencia(codInterno,codMorada) VALUES(1,1); --(REPROVADO)
    --O código interno já existe, logo o insert não é executado

---------------MoradasEntrega----------------
    insert into MoradasEntrega(codInterno,codMorada) VALUES(,1); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,); --(REPROVADO)
    --O código da morada não pode ser nulo, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,1); --(APROVADO)
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,2); --(APROVADO)
    insert into MoradasEntrega(codInterno,codMorada) VALUES(2,1); --(APROVADO)
    insert into MoradasEntrega(codProduto,codMorada) VALUES(100000,10000000); --(REROVADO)
    --O código interno não existe, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,10000000); --(REROVADO)
    --O código da morada não existe, logo o insert não é executado
    insert into MoradasEntrega(codInterno,codMorada) VALUES(1,1); --(REPROVADO)
    --O código interno e o código de morada já existem, logo o insert não é executado


---------------Niveis----------------    
    insert into Niveis(codNivel,designacaoNivel) VALUES(1,'A'); --(APROVADO)
    insert into Niveis(codNivel,designacaoNivel) VALUES(,'B'); --(REROVADO)
    --O código do nível não pode ser nulo, logo o insert não é executado

    insert into Niveis(codNivel,designacaoNivel) VALUES(1,''); --(REROVADO)
    --A designação do nível não pode ser nula, logo o insert não é executado

    insert into Niveis(codNivel,designacaoNivel) VALUES(1,'A'); --(REPROVADO)
    --O código do nível já existe, logo o insert não é executado

    insert into Niveis(codNivel,designacaoNivel) VALUES(2,'D'); --(REPROVADO)
    -- A designação do nível tem de ser A,B ou C logo o insert não é executado

---------------Clientes_Niveis----------------    

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(1,1,TO_DATE('17/12/2015', 'DD/MM/YYYY'));; --(APROVADO)
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(1,1,TO_DATE('17/12/2015', 'DD/MM/YYYY'));; --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(10,1,TO_DATE('17/12/2015', 'DD/MM/YYYY'));; --(REPROVADO)
    --O código interno não existe, logo o insert não é executado

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(,1,TO_DATE('17/12/2015', 'DD/MM/YYYY'));; --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado
    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,,TO_DATE('17/12/2015', 'DD/MM/YYYY'));; --(REPROVADO)
    --O código do nível não pode ser nulo, logo o insert não é executado

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,10,TO_DATE('17/12/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código do nível não existe, logo o insert não é executado

    insert into Clientes_Niveis(codInterno,codNivel,dataAtribuicao) VALUES(2,1,); --(REPROVADO)
    --A data de atribuição não pode ser nula, logo o insert não é executado


---------------Pedidos----------------

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(1,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(APROVADO)
    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(1,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O código do pedido não pode ser nulo, logo o insert não é executado

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(1000,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    -- O código do pedido não existe, logo o insert não é executado


    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O código interno não pode ser nulo, logo o insert não é executado

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,10,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O código interno não existe, logo o insert não é executado


    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,,TO_DATE('17/12/2015', 'DD/MM/YYYY'),TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --O valor total não pode ser nulo, logo o insert não é executado

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,110.2,,TO_DATE('31/12/2015','DD/MM/YYYY')); --(REPROVADO)
    --A data do pedido não pode ser nula, logo o insert não é executado

    insert into Pedidos(codPedido,codInterno,valorTotal,dataPedido,dataVencimento) VALUES(2,1,110.2,TO_DATE('17/12/2015', 'DD/MM/YYYY'),); --(REPROVADO)
    --A data de vencimento não pode ser nula, logo o insert não é executado

---------------Pagamentos----------------    

    insert into Pagamentos(codPagamento,dataPagamento) VALUES(1,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(APROVADO)
    insert into Pagamentos(codPagamento,dataPagamento) VALUES(1,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Pagamentos(codPagamento,dataPagamento) VALUES(,TO_DATE('13/11/2015', 'DD/MM/YYYY')); --(REPROVADO)
    --O código do pagamento não pode ser nulo, logo o insert não é executado


---------------Colheitas----------------
    insert into Colheitas(codColheita,anoColheita) VALUES(1,2015); --(APROVADO)
    insert into Colheitas(codColheita,anoColheita) VALUES(1,2015); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Colheitas(codColheita,anoColheita) VALUES(,2015); --(REPROVADO)
    --O código da colheita não pode ser nulo, logo o insert não é executado
    insert into Colheitas(codColheita,anoColheita) VALUES(1,); --(REPROVADO)
    --O ano da colheita não pode ser nulo, logo o insert não é executado


----------------Culturas----------------
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(1,'Cultura 1','P','C',1); --(APROVADO)
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(1,'Cultura 1','P','C',1); --(REPROVADO)
    --A chave primária já existe, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(,'Cultura 1','P','C',1); --(REPROVADO)
    --O código da cultura não pode ser nulo, logo o insert não é executado

    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,,,'C',1); --(REPROVADO)
    --A designação da cultura não pode ser nula, logo o insert não é executado

    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1',,'C',1); --(REPROVADO)
    --O tipo da cultura não pode ser nulo, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','A','C',1); --(REPROVADO)
    --O tipo da cultura não pode ser diferente de P ou T, logo o insert não é executado

    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P',,1); --(REPROVADO)
    --O objetivo da cultura não pode ser nulo, logo o insert não é executado
    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P','B',1); --(REPROVADO)
    --O objetivo da cultura não pode ser diferente de C ou A, logo o insert não é executado

    insert into Culturas(codCultura,designacaoCultura,tipoCultura,objetivoCultura,tempoCrescimento) VALUES(2,'Cultura 1','P','C',); --(REPROVADO)
    --O tempo de crescimento não pode ser nulo, logo o insert não é executado


---------------Regas----------------
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,1); --(APROVADO)
insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(,1,1); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(20,1,1); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,,1); --(REPROVADO)
--O código da operação não pode ser nulo, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,20,1); --(REPROVADO)
--O código da operação não existe, logo o insert não é executado

insert into Regas(codRega,codOperacao,tempoRega) VALUES(1,1,); --(REPROVADO)
--O tempo da rega não pode ser nulo, logo o insert não é executado 

---------------Instalações Agrícolas----------------
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,'Instalação Agrícola 1'); --(APROVADO)
insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,'Instalação Agrícola 1'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(,1,'Instalação Agrícola 1'); --(REPROVADO)
--O código da instalação agrícola não pode ser nulo, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(20,1,'Instalação Agrícola 1'); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não pode ser nulo, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,20,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1,); --(REPROVADO)
--A designação da instalação agrícola não pode ser nula, logo o insert não é executado

insert into InstalacoesAgricolas(codInstalacaoAgricola,codMorada,designacao) VALUES(1,1000,'Instalação Agrícola 1'); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado

---------------Zonas Geograficas----------------
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1,'Zona Geográfica 1'); --(APROVADO)
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1,'Zona Geográfica 1'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(,1,'Zona Geográfica 1'); --(REPROVADO)
--O código da zona geográfica não pode ser nulo, logo o insert não é executado

insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(20,1,'Zona Geográfica 1'); --(REPROVADO)
--O código da zona geográfica não existe, logo o insert não é executado

insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,,'Zona Geográfica 1'); --(REPROVADO)
--O código da instalação agrícola não pode ser nulo, logo o insert não é executado
insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1000,'Zona Geográfica 1'); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado

insert into ZonasGeograficas(codZonaGeografica,codInstalacaoAgricola,designacaoZonaGeografica) VALUES(1,1,); --(REPROVADO)
--A designação da zona geográfica não pode ser nula, logo o insert não é executado

---------------Setores Agrícolas----------------
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,'Setor Agrícola 1',1); --(APROVADO)
insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,'Setor Agrícola 1',1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(,1,1,'Setor Agrícola 1',1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(20,1,1,'Setor Agrícola 1',1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,,1,'Setor Agrícola 1',1); --(REPROVADO)
--O código da zona geográfica não pode ser nulo, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,20,1,'Setor Agrícola 1',1); --(REPROVADO)
--O código da zona geográfica não existe, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,,'Setor Agrícola 1',1); --(REPROVADO)
--O código da instalação agrícola não pode ser nulo, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1000,'Setor Agrícola 1',1); --(REPROVADO)
--O código da instalação agrícola não existe, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,,'1'); --(REPROVADO)
--A designação do setor agrícola não pode ser nula, logo o insert não é executado

insert into SetoresAgricolas(codSetorAgricola,codZonaGeografica,codInstalacaoAgricola,designacaoSetorAgricola,areaSetorAgricola) VALUES(1,1,1,'Setor Agrícola 1',); --(REPROVADO)
--A área do setor agrícola não pode ser nula, logo o insert não é executado

---------------Aplicação Regas-----------------
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'G'); --(APROVADO)
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'G'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(,1,1,'G'); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1000,1,1,'G'); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado

insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,,1,'G'); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1000,1,'G'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,,'G'); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1000,'G'); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado

insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,); --(REPROVADO)
--O tipo de rega não pode ser nulo, logo o insert não é executado
insert into AplicacaoRegas(codRega,CodCultura,CodSetorAgricola,tipoRega) VALUES(1,1,1,'A'); --(REPROVADO)
--O tipo de rega assume o valor G ou B, logo o insert não é executado

---------------Incidentes-----------------
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(APROVADO)
insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(,1,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do incidente não pode ser nulo, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1000,1,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do incidente não existe, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do pedido não pode ser nulo, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1000,1,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código interno não pode ser nulo, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1000,1,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código interno não existe, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do pagamento não pode ser nulo, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1000,TO_DATE('2018-01-01', 'DD/MM/YYYY')); --(REPROVADO)
--O código do pagamento não existe, logo o insert não é executado

insert into Incidentes(codIncidente,codPedido,codInterno,codPagamento,dataOcorrencia) VALUES(1,1,1,1,); --(REPROVADO)
--A data de ocorrência não pode ser nula, logo o insert não é executado


---------------Produtos-----------------
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,1,'Produto 1'); --(APROVADO)
insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,1,'Produto 2'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(10000,1,1,1,1,'Produto 1'); --(REPROVADO)
--O código do produto não existe, logo o insert não é executado


insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(,1,1,1,1,'Produto 2'); --(REPROVADO)
--O código do produto não pode ser nulo, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,,1,1,1,'Produto 2'); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,,1,1,'Produto 2'); --(REPROVADO)
--O código da colheita não pode ser nulo, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,,1,'Produto 2'); --(REPROVADO)
--O preço por kg não pode ser nulo, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,,'Produto 2'); --(REPROVADO)
--O stock em kg não pode ser nulo, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,1,1,1,); --(REPROVADO)
--A designação do produto não pode ser nula, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(2,1,1,1,1,'Produto 1'); --(REPROVADO)
--A designação do produto não pode ser repetida, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,100000,1,1,1,'Produto 2'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into Produtos(codProduto,codCultura,codColheita,precoKg,stockKg,designacaoProduto) VALUES(1,1,100000,1,1,'Produto 2'); --(REPROVADO)
--O código da colheita não existe, logo o insert não é executado

---------------Pedidos_Produtos----------------
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,1); --(APROVADO)
insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(,1,1,1); --(REPROVADO)
--O código do pedido não pode ser nulo, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(100000,1,1,1); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,,1,1); --(REPROVADO)
--O código do produto não pode ser nulo, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,10000,1,1); --(REPROVADO)
--O código do produto não existe, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,,1); --(REPROVADO)
--A quantidade do produto não pode ser nula, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,100000,1); --(REPROVADO)
--A quantidade do produto não pode ser superior ao stock, logo o insert não é executado

insert into Pedidos_Produtos(codPedido,codProduto,quantidadeProduto,precoPedido) VALUES(1,1,1,); --(REPROVADO)
--O preço do pedido não pode ser nulo, logo o insert não é executado

---------------Entregas----------------
insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(APROVADO)
insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--O código da entrega não pode ser nulo, logo o insert não é executado

insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(100000,1,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--O código da entrega não existe, logo o insert não é executado

insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--O código da morada não pode ser nulo, logo o insert não é executado

insert into Entregas(codEntrega,codMorada,dataEntrega) VALUES(1,100000,TO_DATE('17/10/2015', 'DD/MM/YYYY')); --(REPROVADO)
--O código da morada não existe, logo o insert não é executado

---------------Pedidos_Pagamentos_Entregas----------------
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'P'); --(APROVADO)
insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'P'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(,1,1,'P'); --(REPROVADO)
--O código do pedido não pode ser nulo, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(100000,1,1,'P'); --(REPROVADO)
--O código do pedido não existe, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,,1,'P'); --(REPROVADO)
--O código do pagamento não pode ser nulo, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,100000,1,'P'); --(REPROVADO)
--O código do pagamento não existe, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,,P); --(REPROVADO)
--O código da entrega não pode ser nulo, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,100000,'P'); --(REPROVADO)
--O código da entrega não existe, logo o insert não é executado

--insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,); --(REPROVADO)
--O estado atual não pode ser nulo, logo o insert não é executado

insert into Pedidos_Pagamentos_Entregas(codPedido,codPagamento,codEntrega,estadoAtual) VALUES(1,1,1,'A'); --(REPROVADO)
--O estado atual não pode ser diferente de R,E ou P, logo o insert não é executado


---------------Colheitas_Culturas----------------
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,1); --(APROVADO)
insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,1); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(,1,1); --(REPROVADO)
--O código da colheita não pode ser nulo, logo o insert não é executado

insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(100000,1,1); --(REPROVADO)
--O código da colheita não existe, logo o insert não é executado

insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,,1); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado

insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,100000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into Colheitas_Culturas(codColheita,codCultura,valorTotalColheita) VALUES(1,1,); --(REPROVADO)
--O valor total da colheita não pode ser nulo, logo o insert não é executado

---------------SetoresAgricolas_Culturas-----------------
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(APROVADO)
insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado

insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(100000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado

insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)

--O código da cultura não pode ser nulo, logo o insert não é executado

insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,100000,TO_DATE('07/09/2012', 'DD/MM/YYYY')); --(REPROVADO)

--O código da cultura não existe, logo o insert não é executado

insert into SetoresAgricolas_Culturas(codSetorAgricola,codCultura,dataPlantacao) VALUES(1,1,); --(REPROVADO)

--A data de plantação não pode ser nula, logo o insert não é executado


---------------Plano Anual-----------------
insert into PlanoAnual(anoPlanoAnual) VALUES(2000); --(APROVADO)
insert into PlanoAnual(anoPlanoAnual) VALUES(2000); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into PlanoAnual(anoPlanoAnual) VALUES(); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado


----------------Calendario Operações----------------
insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(1,2000); --(APROVADO)
insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(1,2020); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(,2000); --(REPROVADO)
--O código do calendário de operações não pode ser nulo, logo o insert não é executado

insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(100000,2000); --(REPROVADO)
--O código do calendário de operações não existe, logo o insert não é executado

insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(1,); --(REPROVADO)
--O ano do calendário de operações não pode ser nulo, logo o insert não é executado

insert into CalendariosOperacoes(codCalendarioOperacao,anoCalendarioOperacao) VALUES(2,2000); --(REPROVADO)
--O ano do calendário de operações é único, logo o insert não é executado

---------------Operações-----------------
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','M'); --(APROVADO)
insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--A chave primária já existe, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código da operação não pode ser nulo, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(100000,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código da operação não existe, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,100000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código do calendário de operações não pode ser nulo, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,100000,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--O código do calendário de operações não existe, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,,TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','C'); --(REPROVADO)
--A data prevista do plano não pode ser nula, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),,'F','C'); --(REPROVADO)
--A data da operação não pode ser nula, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),,'C'); --(REPROVADO)
--A forma de aplicação não pode ser nula, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F',); --(REPROVADO)
--O estado da operação não pode ser nulo, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'A','M'); --(REPROVADO)
--A forma de aplicação só pode ser F,FR or S, logo o insert não é executado

insert into Operacoes(codOperacao,anoPlanoAnual,codCalendarioOperacoes,dataPrevistaPlano,dataOperacao,formaAplicacao,estadoOperacao) values(1,2000,1,TO_DATE('07/09/2012', 'DD/MM/YYYY'),TO_DATE('07/09/2012', 'DD/MM/YYYY'),'F','D'); --(REPROVADO)
--O estado da operação só pode ser C ou M, logo o insert não é executado

-------------Planos Rega----------------
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,1); --(APROVADO)
insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(,1,1,1); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(100000,1,1,1); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,,1,1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,100000,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,,1); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,100000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado

insert into PlanosRega(anoPlanoAnual,codSetorAgricola,codCultura,codRega) values(2000,1,1,100000); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado

-------------Culturas Regas---------------
insert into(codCultura,codRega,tipoDistribuicao) values(1,1,'A'); --(APROVADO)  --A;G;P
insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(1,1,'A'); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(,1,'A'); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(100000,1,'A'); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(1, ,'A'); --(REPROVADO)
--O código da rega não pode ser nulo, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(1,100000,'A'); --(REPROVADO)
--O código da rega não existe, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(1,1,''); --(REPROVADO)
--O tipo de distribuição não pode ser nulo, logo o insert não é executado

insert into CulturasRegas(codCultura,codRega,tipoDistribuicao) values(1,1,'B'); --(REPROVADO)
--O tipo de distribuição só pode ser A;G;P, logo o insert não é executado

-------------Planos Anuais setores Agricolas---------------
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,1); --(APROVADO)
insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(,1,1,1); --(REPROVADO)
--O ano do plano anual não pode ser nulo, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(100000,1,1,1); --(REPROVADO)
--O ano do plano anual não existe, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,,1,1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,100000,1,1); --(REPROVADO)
--O código do setor agrícola não existe, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,,1); --(REPROVADO)
--A ordem de rega não pode ser nula, logo o insert não é executado

insert into PlanosAnuais_SetoresAgricolas(anoPlanoAnual,codSetorAgricola,ordemRega,periodicidadeRegaSetor) values(2000,1,1,); --(REPROVADO)
--A periodicidade de rega do setor não pode ser nula, logo o insert não é executado

-------Aplicação Fatores de Produção-------
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,1); --(APROVADO)
insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,1); --(REPROVADO)
--A chave primária não pode ser repetido, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(,1,1,1,1); --(REPROVADO)
--O código da operação não pode ser nulo, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(100000,1,1,1,1); --(REPROVADO)
--O código da operação não existe, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,,1,1,1); --(REPROVADO)
--O código do fator de produção não pode ser nulo, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,100000,1,1,1); --(REPROVADO)
--O código do fator de produção não existe, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,,1,1); --(REPROVADO)
--O código do setor agrícola não pode ser nulo, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,100000,1,1); --(REPROVADO)

--O código do setor agrícola não existe, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,,1); --(REPROVADO)
--O código da cultura não pode ser nulo, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,100000,1); --(REPROVADO)
--O código da cultura não existe, logo o insert não é executado

insert into AplicacaoFatorProducao(codOperacao,codFatorProducao,codSetorAgricola,codCultura,qtFatorProducao) values(1,1,1,1,); --(REPROVADO)
--A quantidade do fator de produção não pode ser nula, logo o insert não é executado



-------FatoresAgricolas_Colheitas_Culturas-------
-------Edificios-------
-------FatoresProducao-------
----------Restricoes-----------
---------TipoSensor------------
----------EstacaoesMeteorologicas-----------
----------Sensores-----------
----------Leituras------------
-----------FichasTecnicas-----------
--------Componentes---------
----------FichasTecnicas_Componentes-----------










































