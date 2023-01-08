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

-- insert 5 values into Hub table
INSERT INTO Hub (codHub, nomeHub, tipoHub)
VALUES (1, 'nome1', 'tipo1');
INSERT INTO Hub (codHub, nomeHub, tipoHub)
VALUES (2, 'nome2', 'tipo2');
INSERT INTO Hub (codHub, nomeHub, tipoHub)
VALUES (3, 'nome3', 'tipo3');
INSERT INTO Hub (codHub, nomeHub, tipoHub)
VALUES (4, 'nome4', 'tipo4');
INSERT INTO Hub (codHub, nomeHub, tipoHub)
VALUES (5, 'nome5', 'tipo5');