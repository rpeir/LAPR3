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
) return Cliente.codCliente%type

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

CREATE OR REPLACE PROCEDURE checkEmail (email IN Cliente.email%type)
is
begin
    if (email is NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'email não pode ser nulo!');
    elsif (REGEXP_LIKE(email, '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a-zA-Z]{2,4}$')) THEN
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
    c_email Cliente.email%type,
    c_moradaCor Cliente.moradaCor%type,
    c_moradaEnt Cliente.moradaEnt%type,
    c_plafond Cliente.plafond%type,

    -- atributos do utilizador
    u_email Utilizador.email%type,
    u_password Utilizador.password%type
) return Cliente.codCliente%type

is
    c_codCliente Cliente.codCliente%type;
    codUtilizador Utilizador.codUtilizador%type;

begin

    checkNrFiscalJaExiste(c_nrFiscal);
    checkEmailJaExiste(c_email);
    checkNome(c_nome);
    checkEmail(c_email);
    checkNrFiscal(c_nrFiscal);
    checkPlafond(c_plafond);
    c_codCliente := adicionarNovoCliente(c_codInt, c_nome, c_nrFiscal, c_email, c_moradaCor, c_moradaEnt, c_plafond, u_email, u_password);
    dbms_output.put_line('Cliente inserido com id: ' || c_codCliente);
return c_codCliente;

    EXCEPTION
    WHEN others then
        dbms_output.put_line(SQLERRM);
        RETURN NULL;

end;
/

DECLARE
      success_code NUMBER;
begin
      success_code := criarCliente(1, 'joao', 123456789, 'abcd1234@gmail.com', 'rua do isep', 'rua do isep dois', 1600, '1234abcd@gmail.com', 'abcd1234');
      rollback;
end;