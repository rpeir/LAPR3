-- on snowflake session

CREATE TABLE Hub (
    codHub INTEGER NOT NULL,
    nomeHub VARCHAR(50) NOT NULL,
    tipoHub VARCHAR(50) NOT NULL,
    constraint pk_codHub PRIMARY KEY (codHub)
);

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