CREATE TABLE Tempo (
    codTempo INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    constraint pk_codTempo PRIMARY KEY (codTempo)
);

CREATE TABLE Cultura (
    codCultura INTEGER NOT NULL,
    designacaoCultura VARCHAR(50) NOT NULL,
    tipoCultura VARCHAR(50) NOT NULL,
    constraint pk_codCultura PRIMARY KEY (codCultura)
);

CREATE TABLE SetorAgricola (
    codSetorAgricola INTEGER NOT NULL,
    designacaoSetorAgricola VARCHAR(50) NOT NULL,
    constraint pk_codSetorAgricola PRIMARY KEY (codSetorAgricola)
);

CREATE TABLE SetorAgricola_Cultura (
    codSetorAgricola INTEGER NOT NULL,
    codCultura INTEGER NOT NULL
);

CREATE TABLE Produto (
    codProduto INTEGER NOT NULL,
    codCultura INTEGER NOT NULL,
    designacaoProduto VARCHAR(50) NOT NULL,
    constraint pk_codProduto PRIMARY KEY (codProduto)
);

CREATE TABLE Cliente (
    codCliente INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    nrFiscal INTEGER NOT NULL,
    constraint pk_codCliente PRIMARY KEY (codCliente)
);

CREATE TABLE Vendas (
    codTempo INTEGER NOT NULL,
    codProduto INTEGER NOT NULL,
    codCliente INTEGER NOT NULL,
    vendasMilharesEuros INTEGER NOT NULL,
    constraint pk_codTempo_codProduto_codCliente PRIMARY KEY (codTempo,codProduto,codCliente)
);

CREATE TABLE Producoes (
    codTempo INTEGER NOT NULL,
    codProduto INTEGER NOT NULL,
    codSetorAgricola INTEGER NOT NULL,
    producaoToneladas INTEGER NOT NULL,
    constraint pk_codTempo_codProduto_codSetorAgricola PRIMARY KEY (codTempo,codProduto,codSetorAgricola)
);


alter table Cliente add CONSTRAINT ckemailvalidation CHECK ( REGEXP_LIKE ( emailCliente, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}$' ) );
alter table Cliente add constraint ck_nrFiscal CHECK(REGEXP_LIKE(nrFiscal,'^[0-9]{9}$'));
alter table SetorAgricola_Cultura add constraint fk_SetoresAgricolas_Culturas_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetorAgricola (codSetorAgricola);
alter table SetorAgricola_Cultura add constraint fk_SetoresAgricolas_Culturas_codCultura FOREIGN KEY (codCultura) references Cultura (codCultura);
alter table Produto add constraint fk_Produtos_CodCultura FOREIGN KEY (codCultura) references Cultura (codCultura);
alter table Vendas add constraint fk_Vendas_codTempo FOREIGN KEY (codTempo) references Tempo (codTempo);
alter table Producoes add constraint fk_Producoes_codTempo FOREIGN KEY (codTempo) references Tempo (codTempo);
alter table Vendas add constraint fk_Vendas_codProduto FOREIGN KEY (codProduto) references Produto (codProduto);
alter table Producoes add constraint fk_Producoes_codProduto FOREIGN KEY (codProduto) references Produto (codProduto);
alter table Producoes add constraint fk_Producoes_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetorAgricola (codSetorAgricola);
alter table Vendas add constraint fk_Vendas_codCliente FOREIGN KEY (codCliente) references Cliente (codCliente);