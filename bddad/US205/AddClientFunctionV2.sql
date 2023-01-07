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
    VALUES (codInterno, c_tipo, c_nome, c_nrFiscal, c_email, c_plafond)
    RETURNING codInterno INTO codInterno;

    -- retornar o código interno do cliente
    return codInterno;
end;
/
-- adicionar cliente_nivel
CREATE OR REPLACE procedure adicionarClienteNiveis (
    cn_codInt IN Clientes_Niveis.codInterno%TYPE,
    cn_codNivel IN Clientes_Niveis.codNivel%TYPE,
    cn_dataAtribuicao IN Clientes_Niveis.dataAtribuicao%TYPE
)
is
begin
    INSERT INTO Clientes_Niveis (codInterno, codNivel, dataAtribuicao)
    VALUES (cn_codInt, cn_codNivel, cn_dataAtribuicao);
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
    elsif NOT (REGEXP_LIKE(pass, '^.{5,}$')) then
        RAISE_APPLICATION_ERROR(-20000, 'password invalida!');
    end if;
end;
/

CREATE OR REPLACE PROCEDURE criarClientes (
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
    m_codPostal Moradas.codPostal%TYPE,
    m_rua Moradas.rua%TYPE,
    m_nrEdificio Moradas.nrEdificio%TYPE,
    m_andar Moradas.andar%TYPE,
    m_pais Moradas.pais%TYPE,
    m_nrPorta Moradas.porta%TYPE,
    m_localidade Moradas.localidade%TYPE
)

is
    c_codInt Clientes.codInterno%type;
    n_codNivel Niveis.codNivel%type;
    n_letra Niveis.designacaoNivel%type;
    c_codUtilizador Utilizador.codUtilizador%type;
    c_codMorada Moradas.codMorada%type;
    cn_dataAtribuicao Clientes_Niveis.dataAtribuicao%type;
begin
    --check do utilizador
    checkEmail(u_email);
    --check do cliente
    checkPass(u_pass);
    --atribuicao do nivel
    n_letra := 'C';
    --obter o codigo do nivel
    SELECT codNivel INTO n_codNivel
    FROM Niveis
    WHERE designacaoNivel = n_letra;

    --obter o codigo do utilizador
    c_codUtilizador := adicionarNovoUtilizador(u_email, u_pass);
    --obter o codigo da morada
    c_codMorada := adicionarMorada(m_codPostal, m_rua, m_nrEdificio, m_pais, m_andar, m_nrPorta, m_localidade);
    --obter o codigo do cliente
    c_codInt := adicionarNovoCliente(c_tipo, c_nome, c_nrFiscal, c_email, c_plafond);
    --obter a data de atribuicao do nivel
    cn_dataAtribuicao := sysdate;
    --obter codiogo ClienteNivel
    adicionarClienteNiveis(c_codInt, n_codNivel, cn_dataAtribuicao);
    --inserir na tabela MoradaEntrega
    adicionarMoradaEntrega(c_codMorada, c_codInt);
    --inserir na tabela MoradaCorresponencia
    adicionarMoradaCorrespondencia(c_codMorada, c_codInt);

    dbms_output.put_line('Cliente inserido com id: ' || c_codInt);


end;
/

    DELETE FROM Utilizador;
    DELETE FROM Clientes;
    DELETE FROM Moradas;
    DELETE FROM MoradasEntrega;
    DELETE FROM MoradasCorrespondencia;

begin
    criarClientes('user1234@gmail.com',
                'abcd1234',
                'E',
                'nomeCliente',
                'cliente1234@gmail.com',
                1000,
                987654321,
                '4445-320',
                'rua',
                5,
                5,
                'portugal',
                '5',
                'porto');

end;
/

    SELECT * FROM Utilizador;
    SELECT * FROM Clientes;
    SELECT * FROM Moradas;
    SELECT * FROM MoradasEntrega;
    SELECT * FROM MoradasCorrespondencia;
    SELECT * FROM Clientes_Niveis;