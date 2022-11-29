DROP TABLE Nivel CASCADE CONSTRAINTS;
DROP TABLE Morada CASCADE CONSTRAINTS;
DROP TABLE Utilizador CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Cliente_Nivel CASCADE CONSTRAINTS;
DROP TABLE MoradaEntrega CASCADE CONSTRAINTS;
DROP TABLE MoradaCorrespondencia CASCADE CONSTRAINTS;
-- criar tables que vao ser usadas
-- utilizador
CREATE TABLE Utilizador (
    codUtilizador NUMBER(10) GENERATED AS IDENTITY,
    email VARCHAR2(50) NOT NULL UNIQUE,
    pass VARCHAR2(50) NOT NULL,
    PRIMARY KEY (codUtilizador)
);
--cliente
CREATE TABLE Cliente (
    codUtilizador number(10) NOT NULL UNIQUE,
    codInt number(10) GENERATED AS IDENTITY,
    tipo varchar2(250) NOT NULL,
    nome varchar2(250) NOT NULL,
    email varchar2(250) NOT NULL UNIQUE,
    plafond number(10) NOT NULL,
    nrFiscal number(9) NOT NULL UNIQUE,
    FOREIGN KEY (codUtilizador) REFERENCES Utilizador (codUtilizador),
    PRIMARY KEY (codInt)
);
-- morada
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
-- nivel
CREATE TABLE Nivel (
    codNivel number(10) GENERATED AS IDENTITY,
    letra varchar2(250) NOT NULL UNIQUE,
    PRIMARY KEY (codNivel)
);
-- cliente_nivel
CREATE TABLE Cliente_Nivel (
    codClienteNivel number(10) GENERATED AS IDENTITY,
    codInt number(10) NOT NULL,
    codNivel number(10) NOT NULL,
    dataAtribuicao date NOT NULL,
    FOREIGN KEY (codInt) REFERENCES Cliente (codInt),
    FOREIGN KEY (codNivel) REFERENCES Nivel (codNivel)
);
-- moradaEntrega
CREATE TABLE MoradaEntrega (
    codMorada number(10) NOT NULL,
    codInt number(10) NOT NULL,
    FOREIGN KEY (codMorada) REFERENCES Morada (codMorada),
    FOREIGN KEY (codInt) REFERENCES Cliente (codInt),
    PRIMARY KEY (codMorada, codInt)
);
-- moradaCorrespondencia
CREATE TABLE MoradaCorrespondencia (
    codMorada number(10) NOT NULL,
    codInt number(10) NOT NULL,
    FOREIGN KEY (codMorada) REFERENCES Morada (codMorada),
    FOREIGN KEY (codInt) REFERENCES Cliente (codInt),
    PRIMARY KEY (codMorada, codInt)
);
--criar as funcoes que vao ser usadas
-- adicionar morada
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

-- adicionar nivel
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
-- adicionar utilizador
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
-- adicionar cliente
CREATE OR REPLACE FUNCTION adicionarNovoCliente (
    -- atributos do cliente
    c_codUtilizador IN Cliente.codUtilizador%TYPE,
    c_codInt IN Cliente.codInt%type,
    c_tipo IN Cliente.tipo%TYPE,
    c_nome IN Cliente.nome%type,
    c_nrFiscal IN Cliente.nrFiscal%type,
    c_email IN Cliente.email%type,
    c_plafond IN Cliente.plafond%type

) return Cliente.codInt%type

is
    codInt Cliente.codInt%type;

begin
    -- inserir cliente
    INSERT INTO Cliente (codUtilizador, codInt, tipo, nome, nrFiscal, email, plafond)
    VALUES (c_codUtilizador, c_codInt, c_tipo, c_nome, c_nrFiscal, c_email, c_plafond)
    RETURNING codInt INTO codInt;

    -- retornar o código interno do cliente
    return codInt;
end;
/
-- adicionar cliente_nivel
CREATE OR REPLACE FUNCTION adicionarClienteNivel (
    cn_codInt IN Cliente_Nivel.codInt%TYPE,
    cn_codNivel IN Cliente_Nivel.codClienteNivel%TYPE,
    cn_dataAtribuicao IN Cliente_Nivel.dataAtribuicao%TYPE
) return Cliente_Nivel.codClienteNivel%TYPE

is
    codClienteNivel Cliente_Nivel.codClienteNivel%TYPE;
begin
    INSERT INTO Cliente_Nivel (codInt, codNivel, dataAtribuicao)
    VALUES (cn_codInt, cn_codNivel, cn_dataAtribuicao)
    RETURNING codClienteNivel INTO codClienteNivel;
    RETURN codClienteNivel;
end;
/

-- adicionar moradaEntrega
CREATE OR REPLACE PROCEDURE adicionarMoradaEntrega (
    me_codMorada IN MoradaEntrega.codMorada%TYPE,
    me_codInt IN MoradaEntrega.codInt%TYPE
)

is
begin
    INSERT INTO MoradaEntrega (codMorada, codInt)
    VALUES (me_codMorada, me_codInt);
end;
/

-- adicionar moradaCorrespondencia
CREATE OR REPLACE PROCEDURE adicionarMoradaCorrespondencia (
    mc_codMorada IN MoradaCorrespondencia.codMorada%TYPE,
    mc_codInt IN MoradaCorrespondencia.codInt%TYPE
)

is
begin
    INSERT INTO MoradaCorrespondencia (codMorada, codInt)
    VALUES (mc_codMorada, mc_codInt);
end;
/

--criar os checks para verificar as restricoes de integridade
--check dos atributos da morada
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

-- checks dos atributos proprios do cliente
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

-- check dos atributos do utilizador
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

CREATE OR REPLACE PROCEDURE checkPass (pass IN Utilizador.pass%type)
is
begin
    if (pass is NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'password não pode ser nula!');
    elsif NOT (REGEXP_LIKE(pass, '[a-zA-Z]{5}')) then
        RAISE_APPLICATION_ERROR(-20000, 'password invalida!');
    end if;
end;
/

CREATE OR REPLACE FUNCTION criarCliente (
    -- atributos que tem de ser passados por parametro do utilizador
    u_email Utilizador.email%TYPE,
    u_pass Utilizador.pass%TYPE,
    -- atributos que tem de ser passados por parametro do cliente
    c_tipo Cliente.tipo%TYPE,
    c_nome Cliente.nome%TYPE,
    c_email Cliente.email%TYPE,
    c_plafond Cliente.plafond%TYPE,
    c_nrFiscal Cliente.nrFiscal%TYPE,
    -- atributos que tem de ser passados por parametro da morada
    m_codMorada Morada.codMorada%TYPE,
    m_codPostal Morada.codPostal%TYPE,
    m_rua Morada.rua%TYPE,
    m_andar Morada.andar%TYPE,
    m_pais Morada.pais%TYPE,
    m_nrPorta Morada.nrPorta%TYPE,
    m_localidade Morada.localidade%TYPE
)   return Cliente.codUtilizador%TYPE

is
    c_codInt Cliente.codInt%type;
    n_codNivel Nivel.codNivel%type;
    n_letra Nivel.letra%type;
    c_codUtilizador Utilizador.codUtilizador%type;
    c_codMorada Morada.codMorada%type;
    cn_dataAtribuicao Cliente_Nivel.dataAtribuicao%type;
    cn_codClienteNivel Cliente_Nivel.codClienteNivel%type;
begin
    --check do utilizador
    checkEmail(u_email);
    --check do cliente
    checkPass(u_pass);
    checkNrFiscalJaExiste(c_nrFiscal);
    checkEmailJaExiste(c_email);
    checkNome(c_nome);
    checkEmail(c_email);
    checkNrFiscal(c_nrFiscal);
    checkPlafond(c_plafond);
    --check da morada
    checkRua(m_rua);
    checkAndar(m_andar);
    checkNrPorta(m_nrPorta);
    checkLocalidade(m_localidade);
    checkCodPostal(m_codPostal);
    --atribuicao do nivel
    n_letra := 'C';
    --obter o codigo do nivel
    n_codNivel := adicionarNivel(n_letra);
    --obter o codigo do utilizador
    c_codUtilizador := adicionarNovoUtilizador(u_email, u_pass);
    --obter o codigo da morada
    c_codMorada := adicionarMorada(m_codPostal, m_rua, m_pais, m_andar, m_nrPorta, m_localidade);
    --obter o codigo do cliente
    c_codInt := adicionarNovoCliente(c_codUtilizador, c_codUtilizador, c_tipo, c_nome, c_nrFiscal, c_email, c_plafond);
    --obter a data de atribuicao do nivel
    cn_dataAtribuicao := sysdate;
    --obter codiogo ClienteNivel
    cn_codClienteNivel := adicionarClienteNivel(c_codInt, n_codNivel, cn_dataAtribuicao);
    --inserir na tabela MoradaEntrega
    adicionarMoradaEntrega(c_codMorada, c_codInt);
    --inserir na tabela MoradaCorresponencia
    adicionarMoradaCorrespondencia(c_codMorada, c_codInt);

    dbms_output.put_line('Cliente inserido com id: ' || c_codInt);
    return c_codInt;

    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Cliente nao foi inserido');
        RETURN NULL;

end;
/