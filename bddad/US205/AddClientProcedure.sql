set serveroutput on;
set verify off;

DROP TABLE Cliente CASCADE CONSTRAINTS;

CREATE TABLE Cliente (
    codCliente number(10) GENERATED AS IDENTITY,
    codInt number(10) NOT NULL UNIQUE,
    nome varchar2(250) NOT NULL,
    nrFiscal number(9) NOT NULL UNIQUE,
    email VARCHAR2(250) NOT NULL UNIQUE,
    plafond number(10) NOT NULL,
    codMoradaCor number(10) NOT NULL,
    codMoradaEnt number(10) NOT NULL,
    PRIMARY KEY (codCliente),
    FOREIGN KEY (codMoradaCor) REFERENCES Morada(codMorada),
    FOREIGN KEY (codMoradaEnt) REFERENCES Morada(codMorada)
);

CREATE TABLE Morada (
    codMorada number(10) GENERATED AS IDENTITY,
    codCliente number(10) NOT NULL,
    codPostal number(8) NOT NULL,
    rua varchar2(250) NOT NULL,
    pais varchar2(250) NOT NULL,
    andar number(10) NOT NULL,
    nrPorta number(10) NOT NULL,
    localidade varchar2(250) NOT NULL,
    PRIMARY KEY (codMorada),
    FOREIGN KEY (codCliente) REFERENCES Cliente(codCliente)
);

CREATE OR REPLACE FUNCTION adicionarMorada (
    m_codPostal IN Morada.codPostal%TYPE,
    m_rua IN Morada.rua%TYPE,
    m_pais IN Morada.pais%TYPE,
    m_andar IN Morada.andar%TYPE,
    m_nrPorta IN Morada.nrPorta%TYPE,
    m_localidade IN Morada.localidade%TYPE
)   RETURN Morada.codMorada%TYPE

IS
    m_codMorada Morada.codMorada%TYPE;
    morada_nao_criada_exception EXCEPTION;

BEGIN
    SELECT codMorada INTO m_codMorada
    FROM Morada m
    WHERE m.codPostal = m_codPostal AND m.rua = m_rua AND m.pais = m_pais AND m.andar = m_andar AND m.nrPorta = m_nrPorta AND m.localidade = m_localidade;
    RETURN m_codMorada;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO Morada (codPostal, rua, pais, andar, nrPorta, localidade);
        VALUES (m_codPostal, m_rua, m_pais, m_andar, m_nrPorta, m_localidade);
        RETURN m_codMorada;
END;
/

CREATE OR REPLACE PROCEDURE adicionarCliente (
    c_codInt IN Cliente.codInt%TYPE,
    c_nome IN Cliente.nome%TYPE,
    c_nrFiscal IN Cliente.nrFiscal%TYPE,
    c_email IN Cliente.email%TYPE,
    c_plafond IN Cliente.plafond%TYPE,
    c_codMoradaCor IN Cliente.codMoradaCor%TYPE,
    c_codMoradaEnt IN Cliente.codMoradaEnt%TYPE
)   RETURN Cliente.codCliente%TYPE
IS
    c_codCliente Cliente.codCliente%TYPE;
    cliente_nao_adicionado_exception EXCEPTION;

BEGIN
    SELECT codCliente INTO c_codCliente
    FROM Cliente c
    WHERE c.codInt = c_codInt AND c.nome = c_nome AND c.nrFiscal = c_nrFiscal AND c.email = c_email AND c.plafond = c_plafond AND c.codMoradaCor = c_codMoradaCor AND c.codMoradaEnt = c_codMoradaEnt;

    RETURN c_codCliente;
END;
/

CREATE OR REPLACE PROCEDURE ciarCliente (
    c_codInt IN Cliente.codInt%TYPE,
    c_nome IN Cliente.nome%TYPE,
    c_nrFiscal IN Cliente.nrFiscal%TYPE,
    c_email IN Cliente.email%TYPE,
    c_plafond IN Cliente.plafond%TYPE,
    c_codPostalCor IN Morada.codPostal%TYPE,
    c_ruaCor IN Morada.rua%TYPE,
    c_paisCor IN Morada.pais%TYPE,
    c_andarCor IN Morada.andar%TYPE,
    c_nrPortaCor IN Morada.nrPorta%TYPE,
    c_localidadeCor IN Morada.localidade%TYPE,
    c_codPostalEnt IN Morada.codPostal%TYPE,
    c_ruaEnt IN Morada.rua%TYPE,
    c_paisEnt IN Morada.pais%TYPE,
    c_andarEnt IN Morada.andar%TYPE,
    c_nrPortaEnt IN Morada.nrPorta%TYPE,
    c_localidadeEnt IN Morada.localidade%TYPE
)   RETURN Cliente.codCliente%TYPE

IS
    c_codMoradaCor Cliente.codMoradaCor%TYPE;
    c_codMoradaEnt Cliente.codMoradaEnt%TYPE;
    c_codCliente Cliente.codCliente%TYPE;
    cliente_nao_criado_exception EXCEPTION;

BEGIN
    c_codMoradaCor := adicionarMorada(c_codPostalCor, c_ruaCor, c_paisCor, c_andarCor, c_nrPortaCor, c_localidadeCor);
    c_codMoradaEnt := adicionarMorada(c_codPostalEnt, c_ruaEnt, c_paisEnt, c_andarEnt, c_nrPortaEnt, c_localidadeEnt);
    c_codCliente := adicionarCliente(c_codInt, c_nome, c_nrFiscal, c_email, c_plafond, c_codMoradaCor, c_codMoradaEnt);
    dbms_output.put_line('Cliente criado com sucesso! Cod: ' || c_codCliente);
    RETURN c_codCliente;
END;
/