DROP TABLE CASCADE CONSTRAINTS Estatistica;
DROP TABLE CASCADE CONSTRAINTS Cliente;
DROP TABLE CASCADE CONSTRAINTS Produto;
DROP TABLE CASCADE CONSTRAINTS Hub;
DROP TABLE CASCADE CONSTRAINTS Cultura;
DROP TABLE CASCADE CONSTRAINTS SetorAgricola_Cultura;
DROP TABLE CASCADE CONSTRAINTS SetorAgricola;
DROP TABLE CASCADE CONSTRAINTS Tempo;

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

CREATE TABLE Hub (
    codHub INTEGER NOT NULL,
    nomeHub VARCHAR(50) NOT NULL,
    tipoHub VARCHAR(50) NOT NULL,
    constraint pk_codHub PRIMARY KEY (codHub)
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

alter table Clientes add CONSTRAINT ckemailvalidation CHECK ( REGEXP_LIKE ( emailCliente, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}$' ) );
alter table Clientes add constraint ck_nrFiscal CHECK(REGEXP_LIKE(nrFiscal,'^[0-9]{9}$'));
alter table SetoresAgricolas_Culturas add constraint fk_SetoresAgricolas_Culturas_codSetorAgricola FOREIGN KEY (codSetorAgricola) references SetoresAgricolas (codSetorAgricola);
alter table SetoresAgricolas_Culturas add constraint fk_SetoresAgricolas_Culturas_codCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
alter table Produtos add constraint fk_Produtos_CodCultura FOREIGN KEY (codCultura) references Culturas (codCultura);
