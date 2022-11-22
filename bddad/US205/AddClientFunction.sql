DROP TABLE Utilizador CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

CREATE TABLE Utilizador (
    codUtilizador number(10) GENERATED AS IDENTITY,
    email varchar2(250) NOT NULL UNIQUE,
    password varchar2(250) NOT NULL,
    PRIMARY KEY (codUtilizador)
);

CREATE TABLE Cliente (
    codCliente number(10) GENERATED AS IDENTITY,
    codInt number(10) NOT NULL UNIQUE,
    nome varchar2(250) NOT NULL,
    nrFiscal number(9) NOT NULL UNIQUE,
    email VARCHAR2(250) NOT NULL UNIQUE,
    moradaCor VARCHAR2(250) NOT NULL,
    moradaEnt VARCHAR2(250) NOT NULL,
    plafond number(10) NOT NULL,
    PRIMARY KEY (codCliente)
);

CREATE OR REPLACE FUNCTION adicionarNovoCliente (
    -- atributos do cliente
    c_codInt IN Cliente.codInt%type,
    c_nome IN Cliente.nome%type,
    c_nrFiscal IN Cliente.nrFiscal%type,
    c_email IN Cliente.email%type,
    c_moradaCor IN Cliente.moradaCor%type,
    c_moradaEnt IN Cliente.moradaEnt%type,
    c_plafond IN Cliente.plafond%type,

    -- atributos do utilizador
    u_email IN Utilizador.email%type,
    u_password IN Utilizador.password%type
) return int

is
    codCliente Cliente.codCliente%type;
    codUtilizador Utilizador.codUtilizador%type;

begin
    -- inserir cliente
    INSERT INTO Cliente (codInt, nome, nrFiscal, email, moradaCor, moradaEnt, plafond)
    VALUES (c_codInt, c_nome, c_nrFiscal, c_email, c_moradaCor, c_moradaEnt, c_plafond)
    RETURNING codCliente INTO codCliente;

    -- inserir utilizador
    INSERT INTO Utilizador (email, password)
    VALUES (u_email, u_password)
    RETURNING codUtilizador INTO codUtilizador;

    -- retornar o código do cliente
    return codCliente;

end;
/