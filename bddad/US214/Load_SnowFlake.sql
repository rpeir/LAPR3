-- create new session
CREATE USER snowflake2 IDENTIFIED BY abcd1234;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, create procedure, create trigger, create sequence to snowflake2;
alter user snowflake2 quota unlimited on users;

-- list sessions
SELECT SID, SERIAL#, USERNAME, STATUS
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- on ras session
-- list roles from ras session
SELECT * FROM USER_ROLE_PRIVS;
-- grant roles to snowflake2
GRANT CONNECT TO snowflake2;
GRANT RESOURCE TO snowflake2;
GRANT DBA TO snowflake2;

-- on ras session
GRANT SELECT, INSERT, UPDATE, DELETE ON Clientes TO snowflake2;
GRANT SELECT, INSERT, UPDATE, DELETE ON Culturas TO snowflake2;
GRANT SELECT, INSERT, UPDATE, DELETE ON Produtos TO snowflake2;
GRANT SELECT, INSERT, UPDATE, DELETE ON SetoresAgricolas TO snowflake2;
GRANT SELECT, INSERT, UPDATE, DELETE ON SetoresAgricolas_Culturas TO snowflake2;

-- on snowflake2 session
GRANT SELECT, INSERT, UPDATE, DELETE ON Cliente TO ras;
GRANT SELECT, INSERT, UPDATE, DELETE ON Cultura TO ras;
GRANT SELECT, INSERT, UPDATE, DELETE ON Produto TO ras;
GRANT SELECT, INSERT, UPDATE, DELETE ON SetorAgricola TO ras;
GRANT SELECT, INSERT, UPDATE, DELETE ON SetorAgricola_Cultura TO ras;

-- on snowflake2 session
INSERT INTO Cliente (codCliente, nome, emailCliente, nrFiscal)
SELECT codInterno, nome, emailCliente, nrFiscal
FROM ras.Clientes;

-- Produtos to Produto table
INSERT INTO Produto (codProduto, codCultura, designacaoProduto)
SELECT codProduto, codCultura, designacaoProduto
FROM ras.Produtos;

-- Culturas to Cultura table
INSERT INTO Cultura (codCultura, designacaoCultura, tipoCultura)
SELECT codCultura, designacaoCultura, tipoCultura
FROM ras.Culturas;

-- SetoresAgricolas to SetorAgricola table
INSERT INTO SetorAgricola (codSetorAgricola, designacaoSetorAgricola)
SELECT codSetorAgricola, designacaoSetorAgricola
FROM ras.SetoresAgricolas;

-- SetoresAgricolas_Culturas to SetorAgricola_Cultura table
INSERT INTO SetorAgricola_Cultura (codSetorAgricola, codCultura)
SELECT codSetorAgricola, codCultura
FROM ras.SetoresAgricolas_Culturas;

-- insert values into Tempo table
INSERT INTO Tempo (codTempo, ano, mes) VALUES (1, 2017, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (2, 2017, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (3, 2017, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (4, 2017, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (5, 2017, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (6, 2017, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (7, 2017, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (8, 2017, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (9, 2017, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (10, 2017, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (11, 2017, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (12, 2017, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (13, 2018, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (14, 2018, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (15, 2018, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (16, 2018, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (17, 2018, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (18, 2018, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (19, 2018, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (20, 2018, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (21, 2018, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (22, 2018, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (23, 2018, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (24, 2018, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (25, 2019, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (26, 2019, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (27, 2019, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (28, 2019, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (29, 2019, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (30, 2019, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (31, 2019, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (32, 2019, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (33, 2019, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (34, 2019, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (35, 2019, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (36, 2019, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (37, 2020, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (38, 2020, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (39, 2020, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (40, 2020, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (41, 2020, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (42, 2020, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (43, 2020, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (44, 2020, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (45, 2020, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (46, 2020, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (47, 2020, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (48, 2020, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (49, 2021, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (50, 2021, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (51, 2021, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (52, 2021, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (53, 2021, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (54, 2021, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (55, 2021, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (56, 2021, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (57, 2021, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (58, 2021, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (59, 2021, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (60, 2021, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (61, 2022, 1);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (62, 2022, 2);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (63, 2022, 3);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (64, 2022, 4);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (65, 2022, 5);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (66, 2022, 6);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (67, 2022, 7);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (68, 2022, 8);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (69, 2022, 9);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (70, 2022, 10);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (71, 2022, 11);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (72, 2022, 12);
INSERT INTO Tempo (codTempo, ano, mes) VALUES (73, 2023, 1);

-- insert values into producoes TABLE
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (1, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (2, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (3, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (4, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (5, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (6, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (7, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (8, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (9, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (10, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (11, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (12, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (13, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (14, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (15, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (16, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (17, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (18, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (19, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (20, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (21, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (22, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (23, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (24, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (25, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (26, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (27, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (28, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (29, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (30, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (31, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (32, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (33, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (34, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (35, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (36, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (37, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (38, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (39, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (40, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (41, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (42, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (43, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (44, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (45, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (46, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (47, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (48, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (49, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (50, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (51, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (52, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (53, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (54, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (55, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (56, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (57, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (58, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (59, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (60, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (61, 1, 1, 1);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (62, 1, 1, 2);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (63, 1, 1, 3);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (64, 1, 1, 4);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (65, 1, 1, 5);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (66, 1, 1, 6);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (67, 1, 1, 7);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (68, 1, 1, 8);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (69, 1, 1, 9);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (70, 1, 1, 10);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (71, 1, 1, 11);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (72, 1, 1, 12);
INSERT INTO Producoes (codTempo, codProduto, codSetorAgricola, producaoToneladas) VALUES (73, 1, 1, 1);

-- insert values into Vendas table
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (1, 1, 1, 1);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (2, 1, 2, 2);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (3, 1, 3, 3);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (4, 1, 4, 4);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (5, 1, 5, 5);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (6, 1, 6, 6);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (7, 1, 7, 7);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (8, 1, 8, 8);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (9, 1, 9, 9);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (10, 1, 10, 10);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (11, 1, 1, 11);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (12, 1, 2, 12);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (13, 1, 3, 1);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (14, 1, 4, 2);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (15, 1, 5, 3);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (16, 1, 6, 4);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (17, 1, 7, 100);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (18, 1, 8, 8);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (19, 1, 9, 9);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (20, 1, 10, 10);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (21, 1, 1, 11);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (22, 1, 2, 12);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (23, 1, 3, 1);
INSERT INTO Vendas (codTempo, codProduto, codCliente, vendasMilharesEuros) VALUES (24, 1, 4, 2);