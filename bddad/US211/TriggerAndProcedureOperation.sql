-- trigger que verifica o estado das operacoes e impede que sejam alteradas caso ja tenham sido executadas
CREATE OR REPLACE TRIGGER trg_prevent_update_cancel
BEFORE UPDATE OR DELETE ON Operacoes
FOR EACH ROW
BEGIN
    IF :OLD.estadoOperacao = 'C' THEN       -- erro: estadoOperacao = 'C'
        -- old analisa apenas a coluna que existe antes antes do update ou delete
        RAISE_APPLICATION_ERROR(-20001, 'Uma operacao ja realizada nao pode ser alterada ou cancelada');
    END IF;
END;
/

-- procedimento que atualiza a forma de aplicacao de uma operacao
CREATE OR REPLACE PROCEDURE update_operation_formaAplicacao (
    p_codOperacao IN Operacoes.codOperacao%TYPE,                -- IN: codigo da operacao que se pretende alterar
    p_formaAplicacao IN Operacoes.formaAplicacao%TYPE           -- IN: nova forma de aplicacao
)
AS
BEGIN
    UPDATE Operacoes
    SET formaAplicacao = p_formaAplicacao                       -- update da forma de aplicacao
    WHERE codOperacao = p_codOperacao                           -- where com a condicao de que o codigo da operacao seja o mesmo que o passado como parametro
      AND estadoOperacao = 'M';                                 -- erro: estadoOperacao = 'M'
END;
/

-- procedimento que atualiza a data de realizacao de uma operacao
CREATE OR REPLACE PROCEDURE update_data_operacao (
  p_codOperacao IN Operacoes.codOperacao%TYPE,                  -- IN: codigo da operacao que se pretende alterar
  p_dataOperacao IN Operacoes.dataOperacao%TYPE                 -- IN: nova data de realizacao
)
AS
BEGIN
  UPDATE Operacoes
  SET dataOperacao = p_dataOperacao                             -- update da data de realizacao
  -- a data deve ficar do tipo: TO_DATE('2014-01-01', 'YYYY-MM-DD'))
  WHERE codOperacao = p_codOperacao                             -- where com a condicao de que o codigo da operacao seja o mesmo que o passado como parametro
    AND estadoOperacao = 'M';                                   -- erro: estadoOperacao = 'M'
END;
/

--CREATE OR REPLACE PROCEDURE update_tempo_rega (
--  p_codOperacao IN Operacoes.codOperacao%TYPE,
--  p_tempoRega IN Regas.tempoRega%TYPE
--)
--AS
--BEGIN
--  UPDATE Regas r
--  SET r.tempoRega = p_tempoRega
--  WHERE r.codOperacao = p_codOperacao
--    -- garantir que a operacao esta pendente
--    AND EXISTS (
--      SELECT 1
--      FROM Operacoes o
--      WHERE o.codOperacao = p_codOperacao
--        AND o.estadoOperacao = 'P'
--    );
--END;
--/

-- abordagem mais correta pois levanta uma excecao caso a operacao nao esteja pendente ou nao exista
CREATE OR REPLACE PROCEDURE update_tempo_rega (
  p_codOperacao IN Operacoes.codOperacao%TYPE,          -- IN: codigo da operacao que se pretende alterar
  p_tempoRega IN Regas.tempoRega%TYPE                   -- IN: novo tempo de rega
)
AS
  l_count INTEGER;                                      -- variavel que verifica se existem operacoes com aquele codigo e que estejam pendentes
BEGIN
  SELECT COUNT(*)
  INTO l_count
  FROM Operacoes o
  WHERE o.codOperacao = p_codOperacao
    AND o.estadoOperacao = 'M';                         -- erro: estadoOperacao = 'M'

  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'O codigo da operacao nao existe ou ja foi realizada');
  END IF;

  UPDATE Regas r
  SET r.tempoRega = p_tempoRega                         -- update do tempo de rega
  WHERE r.codOperacao = p_codOperacao;                -- where com a condicao de que o codigo da operacao seja o mesmo que o passado como parametro
END;
/

-- procedimento que atualiza a quantidade de fator de producao de uma operacao
--CREATE OR REPLACE PROCEDURE update_qt_fator_producao (
--  p_codOperacao IN AplicacaoFatorProducao.codOperacao%TYPE,
--  p_codFatorProducao IN AplicacaoFatorProducao.codFatorProducao%TYPE,
--  p_codSetorAgricola IN AplicacaoFatorProducao.codSetorAgricola%TYPE,
--  p_codCultura IN AplicacaoFatorProducao.codCultura%TYPE,
--  p_qtFatorProducao IN AplicacaoFatorProducao.qtFatorProducao%TYPE
--)
--AS
--BEGIN
--  UPDATE AplicacaoFatorProducao afp
--  SET afp.qtFatorProducao = p_qtFatorProducao
--  WHERE afp.codOperacao = p_codOperacao
--    AND afp.codFatorProducao = p_codFatorProducao
--    AND afp.codSetorAgricola = p_codSetorAgricola
--    AND afp.codCultura = p_codCultura
--    -- garantir que a operacao esta pendente
--    AND EXISTS (
--      SELECT 1
--      FROM Operacoes o
--      WHERE o.codOperacao = p_codOperacao
--        AND o.estadoOperacao = 'P'
--    );
--END;
--/

CREATE OR REPLACE PROCEDURE update_qt_fator_producao (
  p_codOperacao IN AplicacaoFatorProducao.codOperacao%TYPE,             -- IN: codigo da operacao que se pretende alterar
  p_codFatorProducao IN AplicacaoFatorProducao.codFatorProducao%TYPE,   -- IN: codigo do fator de producao que se pretende alterar
  p_codSetorAgricola IN AplicacaoFatorProducao.codSetorAgricola%TYPE,   -- IN: codigo do setor agricola que se pretende alterar
  p_codCultura IN AplicacaoFatorProducao.codCultura%TYPE,               -- IN: codigo da cultura que se pretende alterar
  p_qtFatorProducao IN AplicacaoFatorProducao.qtFatorProducao%TYPE      -- IN: nova quantidade de fator de producao
)
AS
  l_count INTEGER;                                                      -- variavel que verifica se existem operacoes com aquele codigo e que estejam pendentes
BEGIN
  SELECT COUNT(*)
  INTO l_count
  FROM Operacoes o
  WHERE o.codOperacao = p_codOperacao
    AND o.estadoOperacao = 'M';                                             -- erro: estadoOperacao = 'M'

  IF l_count = 0 THEN                                                       -- se nao existir nenhuma operacao com aquele codigo ou se ja tiver sido realizada
    RAISE_APPLICATION_ERROR(-20001, 'O codigo da operacao nao existe ou ja foi realizada');
  END IF;

  UPDATE AplicacaoFatorProducao afp                                          -- update da quantidade de fator de producao
  SET afp.qtFatorProducao = p_qtFatorProducao                                -- update da quantidade de producao
  WHERE afp.codOperacao = p_codOperacao                                      -- quando o codigo da operacao for o mesmo que o passado como parametro
    AND afp.codFatorProducao = p_codFatorProducao                            -- quando o codigo do fator de producao for o mesmo que o passado como parametro
    AND afp.codSetorAgricola = p_codSetorAgricola                            -- quando o codigo do setor agricola for o mesmo que o passado como parametro
    AND afp.codCultura = p_codCultura;                                       -- quando o codigo da cultura for o mesmo que o passado como parametro
END;
/

