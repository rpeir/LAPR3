DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Nivel CASCADE CONSTRAINTS;
DROP TABLE Morada CASCADE CONSTRAINTS;
DROP TABLE Utilizador CASCADE CONSTRAINTS;

CREATE TABLE Utilizador (
    codUtilizador NUMBER(10) GENERATED AS IDENTITY,
    email VARCHAR2(50) NOT NULL,
    pass VARCHAR2(50) NOT NULL,
    PRIMARY KEY (codUtilizador)
);


CREATE TABLE Nivel (
    codNivel number(10) GENERATED AS IDENTITY,
    letra varchar2(250) NOT NULL UNIQUE,
    PRIMARY KEY (codNivel)
);

CREATE TABLE Morada (
    codMorada number(10) GENERATED AS IDENTITY,
    codPostal varchar2(250) NOT NULL,
    rua varchar2(250) NOT NULL,
    pais varchar2(250) NOT NULL,
    andar number(10) NOT NULL,
    nrPorta number(10) NOT NULL,
    localidade varchar2(250) NOT NULL,
    PRIMARY KEY(codMorada)
);

CREATE OR REPLACE FUNCTION adicionarMorada (
    m_codPostal IN Morada.codPostal%TYPE,
    m_rua IN Morada.rua%TYPE,
    m_pais IN Morada.pais%TYPE,
    m_andar IN Morada.andar%TYPE,
    m_nrPorta IN Morada.nrPorta%TYPE,
    m_localidade IN Morada.localidade%TYPE
) return Morada.codMorada%TYPE

is
    codMorada Morada.codMorada%TYPE;
begin
    INSERT INTO Morada (codPostal, rua, pais, andar, nrPorta, localidade)
    VALUES (m_codPostal, m_rua, m_pais, m_andar, m_nrPorta, m_localidade)
    RETURNING codMorada INTO codMorada;
    RETURN codMorada;
end;
/

CREATE OR REPLACE FUNCTION adicionarNivel (
    n_letra IN Nivel.letra%TYPE
)  return Nivel.codNivel%TYPE

is
    codNivel Nivel.codNivel%TYPE;
begin
    INSERT INTO Nivel (letra)
    VALUES (n_letra)
    RETURNING codNivel INTO codNivel;
    RETURN codNivel;
end;
/

CREATE TABLE Cliente (
    codCliente number(10) NOT NULL,
    codInt number(10) NOT NULL UNIQUE,
    nome varchar2(250) NOT NULL,
    nrFiscal number(9) NOT NULL UNIQUE,
    email VARCHAR2(250) NOT NULL UNIQUE,
    plafond number(10) NOT NULL,
    codNivel number(10) NOT NULL,
    codMoradaEntrega number(10) NOT NULL,
    codMoradaCorrespondencia number(10) NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES Utilizador (codUtilizador),
    FOREIGN KEY (codNivel) REFERENCES Nivel(codNivel),
    FOREIGN KEY (codMoradaEntrega) REFERENCES Morada(codMorada),
    FOREIGN KEY (codMoradaCorrespondencia) REFERENCES Morada(codMorada),
    PRIMARY KEY (codCliente)
);

CREATE OR REPLACE FUNCTION adicionarNovoUtilizador (
    u_email IN Utilizador.email%TYPE,
    u_pass IN Utilizador.pass%TYPE
)   return Utilizador.codUtilizador%TYPE

is
    codUtilizador Utilizador.codUtilizador%TYPE;
begin
    INSERT INTO Utilizador (email, pass)
    VALUES (u_email, u_pass)
    RETURNING codUtilizador INTO codUtilizador;
    RETURN codUtilizador;
end;
/

CREATE OR REPLACE FUNCTION adicionarNovoCliente (
    -- atributos do cliente
    c_codCliente IN Cliente.codCliente%TYPE,
    c_codInt IN Cliente.codInt%type,
    c_nome IN Cliente.nome%type,
    c_nrFiscal IN Cliente.nrFiscal%type,
    c_email IN Cliente.email%type,
    c_plafond IN Cliente.plafond%type,
    c_codNivel IN Cliente.codNivel%type,
    c_codMoradaEntrega IN Cliente.codMoradaEntrega%type,
    c_codMoradaCorrespondencia IN Cliente.codMoradaCorrespondencia%type

) return Cliente.codCliente%type

is
    codCliente Cliente.codCliente%type;

begin
    -- inserir cliente
    INSERT INTO Cliente (codCliente, codInt, nome, nrFiscal, email, plafond, codNivel, codMoradaEntrega, codMoradaCorrespondencia)
    VALUES (c_codCliente, c_codInt, c_nome, c_nrFiscal, c_email, c_plafond, c_codNivel, c_codMoradaEntrega, c_codMoradaCorrespondencia)
    RETURNING codCliente INTO codCliente;

    -- retornar o código do cliente
    return codCliente;
end;
/

CREATE OR REPLACE PROCEDURE checkRua (
    rua IN Morada.rua%TYPE
) IS

begin
    IF rua IS NULL THEN
        raise_application_error(-20000, 'Rua não pode ser nula');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkPais (
    pais IN Morada.pais%TYPE
) IS

begin
    IF pais IS NULL THEN
        raise_application_error(-20000, 'Pais não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkAndar (
    andar IN Morada.andar%TYPE
) IS

begin
    IF andar IS NULL THEN
        raise_application_error(-20000, 'Andar não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkNrPorta (
    nrPorta IN Morada.nrPorta%TYPE
) IS
begin
    IF nrPorta IS NULL THEN
        raise_application_error(-20000, 'Numero da porta não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkLocalidade (
    localidade IN Morada.localidade%TYPE
) IS
begin
    IF localidade IS NULL THEN
        raise_application_error(-20000, 'Localidade não pode ser nula');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkCodPostal (
    codPostal IN Morada.codPostal%type
)

IS

begin
    IF (codPostal IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20000, 'codPostal não pode ser nulo!');
    ELSIF NOT REGEXP_LIKE(codPostal, '[0-9]{4}-[0-9]{3}') THEN
        RAISE_APPLICATION_ERROR(-20000, 'codPostal nao esta no formato XXXX-XXX.');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkNome (nome IN Cliente.nome%type)
is
begin
    if (nome is NULL) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nome não pode ser nulo!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkNrFiscal (nrFiscal IN Cliente.nrFiscal%type)
is
begin
    if (nrFiscal is NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'nrFiscal não pode ser nulo!');
    elsif NOT (REGEXP_LIKE(nrFiscal, '[0-9]{9}')) then
        RAISE_APPLICATION_ERROR(-20000, 'nrFiscal deve conter 9 digitos!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkEmail (email IN Utilizador.email%type)
is
begin
    if (email is NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'email não pode ser nulo!');
    elsif NOT (REGEXP_LIKE(email, '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}')) then
        RAISE_APPLICATION_ERROR(-20000, 'email invalido!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkPlafond (plafond IN Cliente.Plafond%TYPE)

IS

BEGIN
    IF (plafond IS NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'Plafond não pode ser nulo!');
    ELSIF (plafond < 0) then
        RAISE_APPLICATION_ERROR(-20000, 'Plafond inválido!');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE checkNrFiscalJaExiste (c_nrFiscal IN Cliente.nrFiscal%TYPE)

IS
    cc_nrFiscal Cliente.nrFiscal%TYPE;

begin
    SELECT nrFiscal INTO cc_nrFiscal FROM Cliente c WHERE c.nrFiscal = c_nrFiscal;

    RAISE_APPLICATION_ERROR(-20000, 'nrFiscal ja existe!');
EXCEPTION
    WHEN NO_DATA_FOUND then
        dbms_output.put_line('nrFiscal valido!');
end;
/

CREATE OR REPLACE PROCEDURE checkEmailJaExiste (c_email IN Cliente.email%TYPE)

IS
    cc_email Cliente.email%TYPE;

begin
    SELECT email INTO cc_email FROM Cliente c WHERE c.email = c_email;

    RAISE_APPLICATION_ERROR(-20000, 'email ja existe!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('email valido!');
end;
/

CREATE OR REPLACE FUNCTION criarCliente (
    -- atributos do cliente
    c_codInt Cliente.codInt%type,
    c_nome Cliente.nome%type,
    c_nrFiscal Cliente.nrFiscal%type,
    c_email Utilizador.email%type,
    c_plafond Cliente.plafond%type,
    c_codPostal Morada.codPostal%type,
    c_rua Morada.rua%type,
    c_pais Morada.pais%type,
    c_andar Morada.andar%type,
    c_nrPorta Morada.nrPorta%type,
    c_localidade Morada.localidade%type,
    u_pass Utilizador.pass%type

) return Cliente.codCliente%type

is
    c_codCliente Cliente.codCliente%type;
    c_codNivel Cliente.codNivel%type;
    n_letra Nivel.letra%type;
    c_codMoradaEntrega Cliente.codMoradaEntrega%type;
    c_codMoradaCorrespondencia Cliente.codMoradaCorrespondencia%type;
    c_codUtilizador Utilizador.codUtilizador%type;

begin

    checkNrFiscalJaExiste(c_nrFiscal);
    checkEmailJaExiste(c_email);
    checkNome(c_nome);
    checkEmail(c_email);
    checkNrFiscal(c_nrFiscal);
    checkPlafond(c_plafond);
    checkCodPostal(c_codPostal);
    checkRua(c_rua);
    checkPais(c_pais);
    checkAndar(c_andar);
    checkNrPorta(c_nrPorta);
    checkLocalidade(c_localidade);
    n_letra := 'C';
    c_codNivel := adicionarNivel(n_letra);
    c_codUtilizador := adicionarNovoUtilizador(c_email, u_pass);
    c_codMoradaEntrega := adicionarMorada(c_codPostal, c_rua, c_pais, c_andar, c_nrPorta, c_localidade);
    c_codMoradaCorrespondencia := adicionarMorada(c_codPostal, c_rua, c_pais, c_andar, c_nrPorta, c_localidade);
    c_codCliente := adicionarNovoCliente(c_codUtilizador, c_codInt, c_nome, c_nrFiscal, c_email, c_plafond, c_codNivel, c_codMoradaEntrega, c_codMoradaCorrespondencia);
    dbms_output.put_line('Cliente inserido com id: ' || c_codCliente);
return c_codCliente;

end;
/

DECLARE
      success_code NUMBER;
begin
      success_code := criarCliente(67, 'joao', 123456789, 'abcd1234@gmail.com', 1600, '4445-320', 'rua da constituicao', 'portugal', 9, 256, 'porto', 'abdfbfbhg');
      rollback;
end;