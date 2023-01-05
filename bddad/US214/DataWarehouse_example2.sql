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

-- insert 5 values into Tempo table
INSERT INTO Tempo (codTempo, ano, mes)
VALUES (1, 2019, 1);
INSERT INTO Tempo (codTempo, ano, mes)
VALUES (2, 2007, 2);
INSERT INTO Tempo (codTempo, ano, mes)
VALUES (3, 2018, 3);
INSERT INTO Tempo (codTempo, ano, mes)
VALUES (4, 2017, 4);
INSERT INTO Tempo (codTempo, ano, mes)
VALUES (5, 2021, 5);


