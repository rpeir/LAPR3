DROP TABLE Niveis CASCADE CONSTRAINTS;
DROP TABLE Moradas CASCADE CONSTRAINTS;
DROP TABLE Utilizador CASCADE CONSTRAINTS;
DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Clientes_Niveis CASCADE CONSTRAINTS;
DROP TABLE MoradasEntrega CASCADE CONSTRAINTS;
DROP TABLE MoradasCorrespondencia CASCADE CONSTRAINTS;
-- criar tables que vao ser usadas
-- utilizador
CREATE TABLE Utilizador (
    codUtilizador NUMBER(10) GENERATED AS IDENTITY,
    email VARCHAR2(50) NOT NULL UNIQUE,
    pass VARCHAR2(50) NOT NULL,
    PRIMARY KEY (codUtilizador)
);
--cliente
create table Clientes (
codInterno integer,
tipo varchar(1) constraint ckTipoCliente CHECK(tipo='P' OR tipo='E'),
nome varchar(100) constraint nnNomeCliente NOT NULL,
emailCliente varchar(255) constraint unEmailCliente UNIQUE,
plafond float constraint nnPlafondCliente NOT NULL,
nrFiscal integer constraint unNrFiscalCliente UNIQUE,
    constraint pk_CodInterno PRIMARY KEY (codInterno)
);
alter table Clientes add CONSTRAINT ckemailvalidation CHECK ( REGEXP_LIKE ( emailCliente, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}$' ) );
-- morada
create table Moradas (
codMorada integer,
rua varchar(100) constraint nnRuaMorada NOT NULL,
nrEdificio integer constraint nnNrEdificio NOT NULL,
andar integer,
porta varchar(100),
codPostal varchar(8) constraint nnCodPostal NOT NULL,
localidade varchar(100) constraint nnLocalidade NOT NULL,
pais varchar(100) constraint nnPais NOT NULL,
    constraint pk_CodMorada PRIMARY KEY (codMorada)
);
alter table Moradas add constraint  ckCodPostal CHECK(REGEXP_LIKE (codPostal, '^\d{4}(-\d{3})?$'));
-- nivel
create table Niveis(
codNivel integer,
designacaoNivel varchar(1),
    constraint pk_codnivel PRIMARY KEY (codNivel)
);
alter table Niveis add constraint ckDesignacaoNivel CHECK(designacaoNivel='A' OR designacaoNivel='B' OR designacaoNivel='C');
-- cliente_nivel
create table Clientes_Niveis(
codClienteNivel integer,
codInterno integer,
codNivel integer,
dataAtribuicao Date constraint nnDataAtribuicao NOT NULL,
    constraint pk_codClienteNivel PRIMARY KEY (codClienteNivel)
);
alter table Clientes_Niveis add constraint fk_clienteNivel_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table Clientes_Niveis add constraint fk_clienteNivel_CodNivel FOREIGN KEY (codNivel) references Niveis (codNivel);
-- moradaEntrega
create table MoradasEntrega(
codInterno integer,
codMorada integer,
    constraint pk_MoradasEntrega_CodInterno_CodMorada PRIMARY KEY (codInterno,codMorada)
);
alter table MoradasEntrega add constraint fk_moradasEntrega_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table MoradasEntrega add constraint fk_moradasEntrega_CodMorada FOREIGN KEY (codMorada) references Moradas(codMorada);
-- moradaCorrespondencia
create table MoradasCorrespondencia(
codInterno integer,
codMorada integer,
    constraint pk_MoradasCorrespondencia_CodInterno_CodMorada PRIMARY KEY (codInterno,codMorada)
);
alter table MoradasCorrespondencia add constraint fk_moradaCorrespondencia_CodInterno FOREIGN KEY (codInterno) references Clientes(codInterno);
alter table MoradasCorrespondencia add constraint fk_moradaCorrespondencia_CodMorada FOREIGN KEY (codMorada) references Moradas(codMorada);
--criar as funcoes que vao ser usadas
-- adicionar morada
CREATE OR REPLACE FUNCTION adicionarMorada (
    m_codPostal IN Moradas.codPostal%TYPE,
    m_rua IN Moradas.rua%TYPE,
    m_nrEdificio IN Moradas.nrEdificio%TYPE,
    m_pais IN Moradas.pais%TYPE,
    m_andar IN Moradas.andar%TYPE,
    m_nrPorta IN Moradas.porta%TYPE,
    m_localidade IN Moradas.localidade%TYPE
) return Moradas.codMorada%TYPE

is
    codMorada Moradas.codMorada%TYPE;
begin
    INSERT INTO Moradas (codPostal, rua, pais, nrEdificio, andar, porta, localidade)
    VALUES (m_codPostal, m_rua, m_pais, m_nrEdificio, m_andar, m_nrPorta, m_localidade)
    RETURNING codMorada INTO codMorada;
    RETURN codMorada;
end;
/

-- adicionar nivel
CREATE OR REPLACE FUNCTION adicionarNivel (
    n_letra IN Niveis.designacaoNivel%TYPE
)  return Niveis.codNivel%TYPE

is
    codNivel Niveis.codNivel%TYPE;
begin
    INSERT INTO Niveis (designacaoNivel)
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
    c_codInt IN Clientes.codInterno%type,
    c_tipo IN Clientes.tipo%TYPE,
    c_nome IN Clientes.nome%type,
    c_nrFiscal IN Clientes.nrFiscal%type,
    c_email IN Clientes.emailCliente%type,
    c_plafond IN Clientes.plafond%type

) return Clientes.codInterno%type

is
    codInterno Clientes.codInterno%type;

begin
    -- inserir cliente
    INSERT INTO Clientes (codInterno, tipo, nome, nrFiscal, emailCliente, plafond)
    VALUES (c_codInt, c_tipo, c_nome, c_nrFiscal, c_email, c_plafond)
    RETURNING codInterno INTO codInterno;

    -- retornar o código interno do cliente
    return codInterno;
end;
/
-- adicionar cliente_nivel
CREATE OR REPLACE FUNCTION adicionarClienteNiveis (
    cn_codInt IN Clientes_Niveis.codInterno%TYPE,
    cn_codNivel IN Clientes_Niveis.codClienteNivel%TYPE,
    cn_dataAtribuicao IN Clientes_Niveis.dataAtribuicao%TYPE
) return Clientes_Niveis.codClienteNivel%TYPE

is
    codClienteNivel Clientes_Niveis.codClienteNivel%TYPE;
begin
    INSERT INTO Clientes_Niveis (codInterno, codNivel, dataAtribuicao)
    VALUES (cn_codInt, cn_codNivel, cn_dataAtribuicao)
    RETURNING codClienteNivel INTO codClienteNivel;
    RETURN codClienteNivel;
end;
/

-- adicionar moradaEntrega
CREATE OR REPLACE PROCEDURE adicionarMoradaEntrega (
    me_codMorada IN MoradasEntrega.codMorada%TYPE,
    me_codInt IN MoradasEntrega.codInterno%TYPE
)

is
begin
    INSERT INTO MoradasEntrega (codMorada, codInterno)
    VALUES (me_codMorada, me_codInt);
end;
/

-- adicionar moradaCorrespondencia
CREATE OR REPLACE PROCEDURE adicionarMoradaCorrespondencia (
    mc_codMorada IN MoradasCorrespondencia.codMorada%TYPE,
    mc_codInt IN MoradasCorrespondencia.codInterno%TYPE
)

is
begin
    INSERT INTO MoradasCorrespondencia (codMorada, codInterno)
    VALUES (mc_codMorada, mc_codInt);
end;
/

--criar os checks para verificar as restricoes de integridade
--check dos atributos da morada
CREATE OR REPLACE PROCEDURE checkRua (
    rua IN Moradas.rua%TYPE
) IS

begin
    IF rua IS NULL THEN
        raise_application_error(-20000, 'Rua não pode ser nula');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkPais (
    pais IN Moradas.pais%TYPE
) IS

begin
    IF pais IS NULL THEN
        raise_application_error(-20000, 'Pais não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkAndar (
    andar IN Moradas.andar%TYPE
) IS

begin
    IF andar IS NULL THEN
        raise_application_error(-20000, 'Andar não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkNrPorta (
    nrPorta IN Moradas.porta%TYPE
) IS
begin
    IF nrPorta IS NULL THEN
        raise_application_error(-20000, 'Numero da porta não pode ser nulo');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkLocalidade (
    localidade IN Moradas.localidade%TYPE
) IS
begin
    IF localidade IS NULL THEN
        raise_application_error(-20000, 'Localidade não pode ser nula');
    END IF;
end;
/

CREATE OR REPLACE PROCEDURE checkCodPostal (
    codPostal IN Moradas.codPostal%type
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
CREATE OR REPLACE PROCEDURE checkNome (nome IN Clientes.nome%type)
is
begin
    if (nome is NULL) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nome não pode ser nulo!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkNrFiscal (nrFiscal IN Clientes.nrFiscal%type)
is
begin
    if (nrFiscal is NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'nrFiscal não pode ser nulo!');
    elsif NOT (REGEXP_LIKE(nrFiscal, '[0-9]{9}')) then
        RAISE_APPLICATION_ERROR(-20000, 'nrFiscal deve conter 9 digitos!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE checkPlafond (plafond IN Clientes.Plafond%TYPE)

IS

BEGIN
    IF (plafond IS NULL) then
        RAISE_APPLICATION_ERROR(-20000, 'Plafond não pode ser nulo!');
    ELSIF (plafond < 0) then
        RAISE_APPLICATION_ERROR(-20000, 'Plafond inválido!');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE checkNrFiscalJaExiste (c_nrFiscal IN Clientes.nrFiscal%TYPE)

IS
    cc_nrFiscal Clientes.nrFiscal%TYPE;

begin
    SELECT nrFiscal INTO cc_nrFiscal FROM Clientes c WHERE c.nrFiscal = c_nrFiscal;

    RAISE_APPLICATION_ERROR(-20000, 'nrFiscal ja existe!');
EXCEPTION
    WHEN NO_DATA_FOUND then
        dbms_output.put_line('nrFiscal valido!');
end;
/

CREATE OR REPLACE PROCEDURE checkEmailJaExiste (c_email IN Clientes.emailCliente%TYPE)

IS
    cc_email Clientes.emailCliente%TYPE;

begin
    SELECT emailCliente INTO cc_email FROM Clientes c WHERE c.emailCliente = c_email;

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
    c_tipo Clientes.tipo%TYPE,
    c_nome Clientes.nome%TYPE,
    c_email Clientes.emailCliente%TYPE,
    c_plafond Clientes.plafond%TYPE,
    c_nrFiscal Clientes.nrFiscal%TYPE,
    -- atributos que tem de ser passados por parametro da morada
    m_codMorada Moradas.codMorada%TYPE,
    m_codPostal Moradas.codPostal%TYPE,
    m_rua Moradas.rua%TYPE,
    m_nrEdificio Moradas.nrEdificio%TYPE,
    m_andar Moradas.andar%TYPE,
    m_pais Moradas.pais%TYPE,
    m_nrPorta Moradas.porta%TYPE,
    m_localidade Moradas.localidade%TYPE
)   return Clientes.codInterno%TYPE

is
    c_codInt Clientes.codInterno%type;
    n_codNivel Niveis.codNivel%type;
    n_letra Niveis.designacaoNivel%type;
    c_codUtilizador Utilizador.codUtilizador%type;
    c_codMorada Moradas.codMorada%type;
    cn_dataAtribuicao Clientes_Niveis.dataAtribuicao%type;
    cn_codClienteNivel Clientes_Niveis.codClienteNivel%type;
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
    c_codMorada := adicionarMorada(m_codPostal, m_rua, m_nrEdificio, m_pais, m_andar, m_nrPorta, m_localidade);
    --obter o codigo do cliente
    c_codInt := adicionarNovoCliente(c_tipo, c_nome, c_nrFiscal, c_email, c_plafond);
    --obter a data de atribuicao do nivel
    cn_dataAtribuicao := sysdate;
    --obter codiogo ClienteNivel
    cn_codClienteNivel := adicionarClienteNiveis(c_codInt, n_codNivel, cn_dataAtribuicao);
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