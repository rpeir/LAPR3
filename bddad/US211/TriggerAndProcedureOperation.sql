-- trigger que verifica o estado das operacoes e impede que sejam alteradas
CREATE OR REPLACE TRIGGER trg_prevent_update_cancel
BEFORE UPDATE OR DELETE ON Operacoes
FOR EACH ROW
BEGIN
    IF :OLD.estadoOperacao = 'R' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Uma operacao ja realizada nao pode ser alterada ou cancelada');
    END IF;
END;
/

-- procedimento que atualiza a forma de aplicacao de uma operacao
CREATE OR REPLACE PROCEDURE update_operation_formaAplicacao (
    p_codOperacao IN Operacoes.codOperacao%TYPE,
    p_formaAplicacao IN Operacoes.formaAplicacao%TYPE
)
AS
BEGIN
    UPDATE Operacoes
    SET formaAplicacao = p_formaAplicacao
    WHERE codOperacao = p_codOperacao
      AND estadoOperacao = 'P';
END;
/

-- procedimento que atualiza a data de realizacao de uma operacao
CREATE OR REPLACE PROCEDURE update_data_operacao (
  p_codOperacao IN Operacoes.codOperacao%TYPE,
  p_dataOperacao IN Operacoes.dataOperacao%TYPE
)
AS
BEGIN
  UPDATE Operacoes
  SET dataOperacao = p_dataOperacao
  -- a data deve ficar do tipo: TO_DATE('2014-01-01', 'YYYY-MM-DD'))
  WHERE codOperacao = p_codOperacao
    AND estadoOperacao = 'P';
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

CREATE OR REPLACE PROCEDURE update_tempo_rega (
  p_codOperacao IN Operacoes.codOperacao%TYPE,
  p_tempoRega IN Regas.tempoRega%TYPE
)
AS
  l_count INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO l_count
  FROM Operacoes o
  WHERE o.codOperacao = p_codOperacao
    AND o.estadoOperacao = 'P';

  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'O codigo da operacao nao existe ou ja foi realizada');
  END IF;

  UPDATE Regas r
  SET r.tempoRega = p_tempoRega
  WHERE r.codOperacao = p_codOperacao;
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
  p_codOperacao IN AplicacaoFatorProducao.codOperacao%TYPE,
  p_codFatorProducao IN AplicacaoFatorProducao.codFatorProducao%TYPE,
  p_codSetorAgricola IN AplicacaoFatorProducao.codSetorAgricola%TYPE,
  p_codCultura IN AplicacaoFatorProducao.codCultura%TYPE,
  p_qtFatorProducao IN AplicacaoFatorProducao.qtFatorProducao%TYPE
)
AS
  l_count INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO l_count
  FROM Operacoes o
  WHERE o.codOperacao = p_codOperacao
    AND o.estadoOperacao = 'P';

  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'O codigo da operacao nao existe ou ja foi realizada');
  END IF;

  UPDATE AplicacaoFatorProducao afp
  SET afp.qtFatorProducao = p_qtFatorProducao
  WHERE afp.codOperacao = p_codOperacao
    AND afp.codFatorProducao = p_codFatorProducao
    AND afp.codSetorAgricola = p_codSetorAgricola
    AND afp.codCultura = p_codCultura;
END;
/

