-- on snowflake2 session

CREATE TABLE Hub (
    codHub INTEGER NOT NULL,
    nomeHub VARCHAR(50) NOT NULL,
    tipoHub VARCHAR(50) NOT NULL,
    constraint pk_codHub PRIMARY KEY (codHub)
);

drop table Vendas cascade constraints;
CREATE TABLE Vendas (
    codTempo INTEGER NOT NULL,
    codProduto INTEGER NOT NULL,
    codCliente INTEGER NOT NULL,
    codHub INTEGER NOT NULL,
    vendasMilharesEuros INTEGER NOT NULL,
    constraint pk_codTempo_codProduto_codCliente_codHub PRIMARY KEY (codTempo,codProduto,codCliente,codHub)
);
alter table Vendas add constraint fk_Vendas_codTempo FOREIGN KEY (codTempo) references Tempo (codTempo);
alter table Vendas add constraint fk_Vendas_codProduto FOREIGN KEY (codProduto) references Produto (codProduto);
alter table Vendas add constraint fk_Vendas_codCliente FOREIGN KEY (codCliente) references Cliente (codCliente);
alter table Vendas add constraint fk_Vendas_codHub FOREIGN KEY (codHub) references Hub (codHub);

-- insert values from Hub on ras to snowflake2
INSERT INTO Hub (codHub, tipoHub)
SELECT codHub, tipoHub
FROM ras.Hub;