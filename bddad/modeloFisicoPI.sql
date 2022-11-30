create table Clientes (
codInterno integer,
tipo varchar(1) constraint ckTipoCliente CHECK(tipo='P' OR tipo='E'),
nome varchar(100) constraint nnNomeCliente NOT NULL,
emailCliente varchar(255) constraint unEmailCliente UNIQUE,
plafond float constraint nnPlafondCliente NOT NULL,
nrFiscal integer constraint unNrFiscalCliente UNIQUE,
    constraint pk_CodInterno PRIMARY KEY (codInterno)
);

create table Moradas (
codMorada integer,
rua varchar(100) constraint nnRuaMorada NOT NULL,
nrEdificio integer constraint nnNrEdificio NOT NULL,
andar integer,
porta varchar(100),
codPostal varchar(8) constraint nnCodPostal NOT NULL,
localidade varchar(100) constraint nnLocalidade NOT NULL,
pais varchar(100) constraint nnPais NOT NULL,
    constraint pk_CodMorada PRIMARY KEY (codMorada)
);



create table MoradasCorrespondencia(
codInterno integer,
codMorada integer,
    constraint pk_MoradasCorrespondencia_CodInterno_CodMorada PRIMARY KEY (codInterno,codMorada)
);


create table MoradasEntrega(
codInterno integer,
codMorada integer,
    constraint pk_MoradasEntrega_CodInterno_CodMorada PRIMARY KEY (codInterno,codMorada)
);

create table Niveis(
codNivel integer,
designacaoNivel varchar(1),
    constraint pk_codnivel PRIMARY KEY (codNivel)
);


create table Clientes_Niveis(
codClienteNivel integer,
codInterno integer,
codNivel integer,
dataAtribuicao Date constraint nnDataAtribuicao NOT NULL,
    constraint pk_codClienteNivel PRIMARY KEY (codClienteNivel)
);

create table Pedidos(
codPedido integer,
codInterno integer,
valorTotal float,
dataPedido date constraint nnDataPedido NOT NULL,
dataVencimento date constraint nnDataVencimento NOT NULL,
    constraint pk_codPedido PRIMARY KEY (codPedido)
);


create table Pagamentos( 
codPagamento integer,
dataPagamento date constraint nnDataPagamento NOT NULL,
    constraint pk_codPagamento PRIMARY KEY (codPagamento)
);

create table Colheitas(
codColheita integer,
anoColheita integer constraint nnAnoColheita NOT NULL,
    constraint pk_codColheita PRIMARY KEY (codColheita)
);
create table Culturas(
codCultura integer,
designacaoCultura varchar(50) constraint nnDesignacaoCultura NOT NULL,
tipoCultura varchar(1),
objetivoCultura varchar(8), 
tempoCrescimento integer constraint nnTempoCrescimento NOT NULL,
    constraint pk_codCultura PRIMARY KEY (codCultura)
);

create table Regas(
codRega integer,
codOperacao integer,
tempoRega integer constraint nnTempoRega NOT NULL,
    constraint pk_codRega PRIMARY KEY (codRega)
);


create table InstalacoesAgricolas(
codInstalacaoAgricola integer,
codMorada integer,
designacao varchar(50) constraint nnDesignacaoInstalacao NOT NULL,
    constraint pk_codInstalacaoAgricola PRIMARY KEY (codInstalacaoAgricola)
);


create table ZonasGeograficas(
codZonaGeografica integer,
codInstalacaoAgricola integer,
designacaoZonaGeografica varchar(50) constraint nndesignacaoZonaGeografica NOT NULL,
    constraint pk_codZonaGeografica PRIMARY KEY (codZonaGeografica)
);






create table SetoresAgricolas(
codSetorAgricola integer,
codZonaGeografica integer,
codInstalacaoAgricola integer,
designacaoSetorAgricola varchar(50) constraint nnDesignacaoSetor NOT NULL,
areaSetorAgricola integer constraint nnAreaSetor NOT NULL,
    constraint pk_codSetorAgricola PRIMARY KEY (codSetorAgricola)
);




create table AplicacaoRegas(
codRega integer,
codCultura integer,
codSetorAgricola integer,
tipoRega varchar(1),
    constraint pk_codRega_codCultura_codSetorAgricola PRIMARY KEY (codRega,codCultura,codSetorAgricola)
);


create table Incidentes(
codIncidente integer,
codPedido integer,
codInterno integer,
codPagamento integer,
dataOcorrencia date constraint nnDataOcorrencia NOT NULL,
    constraint pk_codIncidente PRIMARY KEY (codIncidente)
);




create table Produtos(
codProduto integer,
codCultura integer,
-- codColheita integer,
precoKg float constraint nnPrecoKg NOT NULL,
stockKg float constraint nnStockKg NOT NULL,
designacao varchar(50) constraint unDesignacaoProduto UNIQUE,
    constraint pk_codProduto PRIMARY KEY (codProduto)
);




create table Pedidos_Produtos(
codPedido integer,
codProduto integer,
quantidadeProduto float constraint nnQuantidadePedido NOT NULL,
precoPedido float constraint nnPrecoPedido NOT NULL,
    constraint pk_codPedido_codProduto PRIMARY KEY (codPedido, codProduto)
);


create table Entregas(
codEntrega integer,
codMorada integer,
dataEntrega date constraint nnDataEntrega NOT NULL,
    constraint pk_codEntrega PRIMARY KEY (codEntrega)
);


create table Pedidos_Pagamentos_Entregas(
codPedido integer,
codPagamento integer,
codEntrega integer,
estadoAtual varchar(1),
    constraint pk_codPedido_codPagamento_codEntrega PRIMARY KEY (codPedido,codPagamento,codEntrega)
);

create table Colheitas_Culturas(
codColheita integer,
codCultura integer,
valorTotal float constraint nnValorTotal NOT NULL,
    constraint pk_codColheita_codCultura PRIMARY KEY (codColheita,codCultura)
);


create table SetoresAgricolas_Culturas(
codSetorAgricola integer,
codCultura integer,
dataPlantacao date constraint nnDataPlantacao NOT NULL,
    constraint pk_codSetorAgricola_codCultura PRIMARY KEY (codSetorAgricola,codCultura)
);



create table PlanosAnuais(
anoPlanoAnual integer,
    constraint pk_anoPlanoAnual PRIMARY KEY (anoPlanoAnual)
);

create table CalendariosOperacoes(
codCalendarioOperacoes integer,
anoCalendarioOperacoes integer constraint unAnoCalendarioOperacoes UNIQUE,
    constraint pk_codCalendarioOperacoes PRIMARY KEY (codCalendarioOperacoes)
);

create table Operacoes(
codOperacao integer,
anoPlanoAnual integer,
codCalendarioOperacoes integer,
dataPrevistaPlano date,
dataOperacao date constraint nnDataOperacao NOT NULL,
formaAplicacao varchar(1),
estadoOperacao varchar(1),
    constraint pk_codOperacao PRIMARY KEY (codOperacao)
);




create table PlanosRega(
anoPlanoAnual integer,
codSetorAgricola integer,
codCultura integer,
codRega integer,
    constraint pk_anoPlanoAnual_codSetorAgricola_codCultura_codRega PRIMARY KEY (anoPlanoAnual,codSetorAgricola,codCultura,codRega)
);




create table Culturas_Regas(
codCultura integer,
codRega integer,
tipoDistribuicao varchar(1),
    constraint pk_codCultura_codRega PRIMARY KEY (codCultura,codRega)
);

create table PlanosAnuais_SetoresAgricolas(
anoPlanoAnual integer,
codSetorAgricola integer,
ordemRega integer constraint nnOrdemRega NOT NULL,
periodicidadeRegaSetor integer constraint nnPeriodicidadeRegaSetor NOT NULL,
    constraint pk_anoPlanoAnual_codSetorAgricola PRIMARY KEY (anoPlanoAnual,codSetorAgricola)
);




create table AplicacaoFatorProducao(
codOperacao integer,
codFatorProducao integer,
codSetorAgricola integer,
codCultura integer,
qtFatorProducao float constraint nnQtFatorProducao NOT NULL,
    constraint pk_codOperacao_codFatorProducao_codSetorAgricola_codCultura PRIMARY KEY (codOperacao,codFatorProducao,codSetorAgricola,codCultura)
);



create table SetoresAgricolas_Colheitas_Culturas(
codSetorAgricola integer,
codColheita integer,
codCultura integer,
valorSetor float constraint nnValorSetor NOT NULL,
    constraint pk_codSetorAgricola_codColheita_codCultura PRIMARY KEY (codSetorAgricola,codColheita,codCultura)
);

create table Edificios(
codEdificio integer,
codInstalacaoAgricola integer,
tipoEdificio varchar(1),
    constraint pk_codEdificio PRIMARY KEY (codEdificio)
);



create table FatoresProducao(
codFatorProducao integer,
tipoFatorProducao varchar(2),
precoKg float constraint nnFPPrecoKg NOT NULL,
nomeComercial varchar(50) constraint unNomeComercial UNIQUE,
formulacao varchar(1),
fichaTecnica blob, ----ESPERANDO O FICHEIRO PROFS
    constraint pk_codFatorProducao PRIMARY KEY (codFatorProducao)
);


create table Restricoes(
codZonaGeografica integer,
codFatorProducao integer,
dataInicio date constraint nnDataInicio NOT NULL,
dataFim date constraint nnDataFim NOT NULL,
    constraint pk_codZonaGeografica_codFatorProducao PRIMARY KEY (codZonaGeografica,codFatorProducao)
);



create table TiposSensores(
codTipoSensor varchar(2),
    constraint pk_codTipoSensor PRIMARY KEY (codTipoSensor)
);





create table EstacoesMeteorologicas(
codEstacaoMeteorologica integer,
codZonaGeografica integer,
    constraint pk_codEstacaoMeteorologica PRIMARY KEY (codEstacaoMeteorologica)
);


create table Sensores(
idSensor varchar(5),
codTipoSensor varchar(2),
codEstacaoMeteorologica integer,
valorReferencia integer constraint unValorReferencia UNIQUE,
    constraint pk_idSensor PRIMARY KEY (idSensor)
);


create table Leituras(
codLeitura integer,
idSensor varchar(5),
instanteLeitura date constraint nnInstanteLeitura NOT NULL,
valorLido integer constraint nnValorLido NOT NULL,
    constraint pk_codLeitura PRIMARY KEY (codLeitura)
);
alter table Leituras add constraint fk_Leitura_idSensor FOREIGN KEY (idSensor) references Sensores (idSensor);
alter table Leituras add constraint ck_valorLido CHECK(valorLido>=0 AND valorLido<=100);
alter table Clientes add CONSTRAINT ckemailvalidation CHECK ( REGEXP_LIKE ( emailCliente, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}$' ) );
alter table Sensores add constraint fk_Senosres_codTipoSensor FOREIGN KEY (codTipoSensor) references TiposSensores (codTipoSensor);
alter table Sensores add constraint fk_Sensores_codEstacaoMeteorologica FOREIGN KEY (codEstacaoMeteorologica) references EstacoesMeteorologicas (codEstacaoMeteorologica);
alter table Moradas add constraint  ckCodPostal CHECK(REGEXP_LIKE (codPostal, '^\d{4}(-\d{3})?$'));
alter table MoradasCorrespondencia add constraint fk_moradaCorrespondencia_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table MoradasCorrespondencia add constraint fk_moradaCorrespondencia_CodMorada FOREIGN KEY (codMorada) references Moradas(codMorada);
alter table MoradasEntrega add constraint fk_moradasEntrega_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table MoradasEntrega add constraint fk_moradasEntrega_CodMorada FOREIGN KEY (codMorada) references Moradas(codMorada);
alter table Niveis add constraint ckDesignacaoNivel CHECK(designacaoNivel='A' OR designacaoNivel='B' OR designacaoNivel='C');
alter table Clientes_Niveis add constraint fk_clienteNivel_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table Clientes_Niveis add constraint fk_clienteNivel_CodNivel FOREIGN KEY (codNivel) references Niveis (codNivel);
alter table Pedidos add constraint fk_pedidos_codInterno FOREIGN KEY (codInterno) references Clientes (codInterno);
alter table Culturas add constraint ckTipoCultura CHECK(tipoCultura='P' OR tipoCultura='T' );
alter table Culturas add constraint ckobjetivoCultura CHECK(objetivoCultura ='A' OR objetivoCultura ='C');
alter table Regas add constraint fk_regas_codOperacao FOREIGN KEY (codOperacao) references Operacoes (codOperacao);
alter table InstalacoesAgricolas add constraint fk_InstalacoesAgricolas_codMorada FOREIGN KEY (codMorada) references Moradas (codMorada);
alter table ZonasGeograficas add constraint fk_ZonasGeograficas_CodInstalacaoAgricola FOREIGN KEY (codInstalacaoAgricola) references InstalacoesAgricolas (codInstalacaoAgricola);
alter table SetoresAgricolas add constraint fk_SetoresAgricolas_CodZonaGeografica FOREIGN KEY (codZonaGeografica) references ZonasGeograficas (codZonaGeografica);
alter table SetoresAgricolas add constraint fk_SetoresAgricolas_CodInstalacaoAgricola FOREIGN KEY (codInstalacaoAgricola) references InstalacoesAgricolas (codInstalacaoAgricola);
alter table AplicacaoRegas add constraint fk_aplicacaoRegas_CodRega FOREIGN KEY (codRega) references Regas(codRega);
alter table AplicacaoRegas add constraint fk_aplicacaoRegas_CodCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table AplicacaoRegas add constraint fk_aplicacaoRegas_CodSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table AplicacaoRegas add constraint ckTipoRega CHECK(tipoRega='G' OR tipoRega='B');
alter table Incidentes add constraint fk_IncidentesCodPedido FOREIGN KEY (codPedido) references Pedidos (codPedido);
alter table Incidentes add constraint fk_IncidentesCodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table Incidentes add constraint fk_IncidentescodPagamento FOREIGN KEY (codPagamento) references Pagamentos(codPagamento);
alter table Produtos add constraint fk_Produtos_CodCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
-- alter table Produtos add constraint fk_Produtos_CodColheita FOREIGN KEY (codColheita) references Colheitas(codColheita);
alter table Pedidos_Produtos add constraint fk_PedidosProdutos_CodPedido FOREIGN KEY (codPedido) references Pedidos (codPedido);
alter table Pedidos_Produtos add constraint fk_PedidosProdutos_CodInterno FOREIGN KEY (codProduto) references Produtos (codProduto);
alter table Entregas add constraint fk_Entregas_CodEntrega FOREIGN KEY (codMorada) references Moradas (codMorada);
alter table Pedidos_Pagamentos_Entregas add constraint fk_Pedidos_Pagamentos_Entregas_CodPedido FOREIGN KEY (codPedido) references Pedidos (codPedido);
alter table Pedidos_Pagamentos_Entregas add constraint fk_Pedidos_Pagamentos_Entregas_CodPagamento FOREIGN KEY (codPagamento) references Pagamentos (codPagamento);
alter table Pedidos_Pagamentos_Entregas add constraint fk_Pedidos_Pagamentos_Entregas_CodEntrega FOREIGN KEY (codEntrega) references Entregas (codEntrega);
alter table Pedidos_Pagamentos_Entregas add constraint ck_estadoAtual CHECK(estadoAtual='R' OR estadoAtual='E' OR estadoAtual='P');
alter table Colheitas_Culturas add constraint fk_Colheitas_Culturas_CodColheita FOREIGN KEY (codColheita) references Colheitas (codColheita);
alter table Colheitas_Culturas add constraint fk_Colheitas_Culturas_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table SetoresAgricolas_Culturas add constraint fk_SetoresAgricolas_Culturas_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table SetoresAgricolas_Culturas add constraint fk_SetoresAgricolas_Culturas_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table Operacoes add constraint fk_Operacoes_anoPlanoAnual FOREIGN KEY (anoPlanoAnual) references PlanosAnuais (anoPlanoAnual);
alter table Operacoes add constraint fk_Operacoes_codCalendarioOperacoes FOREIGN KEY (codCalendarioOperacoes) references CalendariosOperacoes (codCalendarioOperacoes);
alter table Operacoes add constraint ck_formaAplicacao CHECK(formaAplicacao='F' OR formaAplicacao='R' OR formaAplicacao='S');
alter table Operacoes add constraint ck_estadoOperacao CHECK(estadoOperacao='F' OR estadoOperacao='R' OR estadoOperacao='S');
alter table PlanosRega add constraint fk_PlanosRega_anoPlanoAnual FOREIGN KEY (anoPlanoAnual) references PlanosAnuais (anoPlanoAnual);
alter table PlanosRega add constraint fk_PlanosRega_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table PlanosRega add constraint fk_PlanosRega_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table PlanosRega add constraint fk_PlanosRega_codRega FOREIGN KEY (codRega) references Regas (codRega);
alter table Culturas_Regas add constraint fk_Culturas_Regas_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table Culturas_Regas add constraint fk_Culturas_Regas_codRega FOREIGN KEY (codRega) references Regas (codRega);
alter table Culturas_Regas add constraint ck_tipoDistribuicao CHECK(tipoDistribuicao='A' OR tipoDistribuicao='G' OR tipoDistribuicao='P');
alter table PlanosAnuais_SetoresAgricolas add constraint fk_PlanosAnuais_SetoresAgricolas_anoPlanoAnual FOREIGN KEY (anoPlanoAnual) references PlanosAnuais (anoPlanoAnual);
alter table PlanosAnuais_SetoresAgricolas add constraint fk_PlanosAnuais_SetoresAgricolas_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table AplicacaoFatorProducao add constraint fk_AplicacaoFatorProducao_codOperacao FOREIGN KEY (codOperacao) references Operacoes (codOperacao);
alter table AplicacaoFatorProducao add constraint fk_AplicacaoFatorProducao_codFatorProducao FOREIGN KEY (codFatorProducao) references FatoresProducao (codFatorProducao);
alter table AplicacaoFatorProducao add constraint fk_AplicacaoFatorProducao_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table AplicacaoFatorProducao add constraint fk_AplicacaoFatorProducao_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table SetoresAgricolas_Colheitas_Culturas add constraint fk_SetoresAgricolas_Colheitas_Culturas_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table SetoresAgricolas_Colheitas_Culturas add constraint fk_SetoresAgricolas_Colheitas_Culturas_codColheita FOREIGN KEY (codColheita) references Colheitas (codColheita);
alter table SetoresAgricolas_Colheitas_Culturas add constraint fk_SetoresAgricolas_Colheitas_Culturas_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table Edificios add constraint fk_Edificios_codInstalacaoAgricola FOREIGN KEY (codInstalacaoAgricola) references InstalacoesAgricolas (codInstalacaoAgricola);
alter table Edificios add constraint ck_tipoEdificio CHECK(tipoEdificio='G' OR tipoEdificio='A' OR tipoEdificio='R' OR tipoEdificio='E');
alter table FatoresProducao add constraint ck_tipoFatorProducao CHECK(tipoFatorProducao='FE' OR tipoFatorProducao='AD' OR tipoFatorProducao='CO' OR tipoFatorProducao='FI');
alter table FatoresProducao add constraint ck_formulacao CHECK(formulacao='G' OR formulacao='L' OR formulacao='P');
alter table Restricoes add constraint fk_Restricoes_codZonaGeografica FOREIGN KEY (codZonaGeografica) references ZonasGeograficas (codZonaGeografica);
alter table Restricoes add constraint fk_Restricoes_codFatorProducao FOREIGN KEY (codFatorProducao) references FatoresProducao (codFatorProducao);
alter table TiposSensores add constraint ck_codTipoSensor CHECK(codTipoSensor='HS' OR codTipoSensor='VV' OR codTipoSensor='PI'OR codTipoSensor='TX'OR codTipoSensor='TA'OR codTipoSensor='HA'OR codTipoSensor='PA');
alter table EstacoesMeteorologicas add constraint fk_EstacoesMeteorologicas_codZonaGeografica FOREIGN KEY(codZonaGeografica) references ZonasGeograficas (codZonaGeografica);


