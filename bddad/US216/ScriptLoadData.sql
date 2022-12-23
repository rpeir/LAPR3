-- create new session
CREATE USER Snowflake IDENTIFIED BY abcd1234;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, create procedure, create trigger, create sequence to snowflake;
alter user snowflake quota unlimited on users;

-- list sessions
SELECT SID, SERIAL#, USERNAME, STATUS
FROM V$SESSION
WHERE USERNAME IS NOT NULL;

-- on ras session
DECLARE
  cursor c1 is
    SELECT table_name
    FROM all_tables
    --WHERE owner = 'ras'; ?
BEGIN
  FOR r1 IN c1 LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON Joana.' || r1.table_name || ' TO snowflake';
  END LOOP;
END;
/

-- on snowflake session
DECLARE
  cursor c1 is
    SELECT table_name
    FROM all_tables
    --WHERE owner = 'snowflake'; ?
BEGIN
  FOR r1 IN c1 LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON snowflake.' || r1.table_name || ' TO ras';
  END LOOP;
END;
/

-- database name = XEPDB1
INSERT INTO Cliente (codCliente, nome, emailCliente, nrFiscal)
SELECT codInterno, nome, emailCliente, nrFiscal
FROM ras.Clientes;

-- Produtos to Produto table
INSERT INTO Produto (codProduto, codCultura, designacaoProduto)
SELECT codInterno, codCultura, designacaoProduto
FROM ras.Produtos;

-- Culturas to Cultura table
INSERT INTO Cultura (codCultura, designacaoCultura, tipoCultura)
SELECT codInterno, designacaoCultura, tipoCultura
FROM ras.Culturas;

-- SetoresAgricolas to SetorAgricola table
INSERT INTO SetorAgricola (codSetorAgricola, designacaoSetorAgricola)
SELECT codInterno, designacaoSetorAgricola
FROM ras.SetoresAgricolas;

-- SetoresAgricolas_Culturas to SetorAgricola_Cultura table
INSERT INTO SetorAgricola_Cultura (codSetorAgricola, codCultura)
SELECT codSetorAgricola, codCultura
FROM ras.SetoresAgricolas_Culturas;

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

-- insert 5 values into Estatistica table
INSERT INTO Estatistica (codTempo, codSetorAgricola, codProduto, codCliente, codHub, producaoToneladas, vendasMilharesEuros)
VALUES (1, 1, 1, 1, 1, 1000, 2000);
INSERT INTO Estatistica (codTempo, codSetorAgricola, codProduto, codCliente, codHub, producaoToneladas, vendasMilharesEuros)
VALUES (2, 2, 2, 2, 2, 2000, 3000);
INSERT INTO Estatistica (codTempo, codSetorAgricola, codProduto, codCliente, codHub, producaoToneladas, vendasMilharesEuros)
VALUES (3, 3, 3, 3, 3, 3000, 4000);
INSERT INTO Estatistica (codTempo, codSetorAgricola, codProduto, codCliente, codHub, producaoToneladas, vendasMilharesEuros)
VALUES (4, 4, 4, 4, 4, 4000, 5000);
INSERT INTO Estatistica (codTempo, codSetorAgricola, codProduto, codCliente, codHub, producaoToneladas, vendasMilharesEuros)
VALUES (5, 5, 5, 5, 5, 5000, 6000);




