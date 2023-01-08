-- View que mostra a evolução da produção de uma determinada cultura num determinado setor agrícola nos últimos 5 anos
CREATE OR REPLACE VIEW vProducaoCulturaSetorAgricola
AS
SELECT t.ano, c.tipoCultura, SUM(pr.producaoToneladas) as producao
FROM Producoes pr
INNER JOIN Tempo t ON pr.codTempo = t.codTempo
INNER JOIN Produto p ON pr.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
WHERE t.ano >= (EXTRACT(YEAR FROM sysdate)-5)
GROUP BY t.ano, c.tipoCultura;

-- Procedimento que compara as vendas de um ano com as vendas de outro ano
CREATE OR REPLACE PROCEDURE prcCompararVendas (ano1 IN NUMBER, ano2 IN NUMBER)
IS
  vendas1 INTEGER;
  vendas2 INTEGER;
  occurrences_ano1 INTEGER;
  occurrences_ano2 INTEGER;
BEGIN
SELECT COUNT(*) INTO occurrences_ano1 FROM Tempo WHERE Tempo.ano = ano1;
SELECT COUNT(*) INTO occurrences_ano2 FROM Tempo WHERE Tempo.ano = ano2;
IF (occurrences_ano1 > 0 AND occurrences_ano2 > 0)
THEN
  SELECT SUM(vendasMilharesEuros) INTO vendas1 FROM Vendas WHERE Vendas.codTempo IN (SELECT codTempo FROM Tempo WHERE ano = ano1);
  SELECT SUM(vendasMilharesEuros) INTO vendas2 FROM Vendas WHERE Vendas.codTempo IN (SELECT codTempo FROM Tempo WHERE ano = ano2);
  IF vendas1 > vendas2 THEN
    DBMS_OUTPUT.PUT_LINE('O ano ' || ano1 || ' teve mais vendas que o ano ' || ano2);
  ELSIF (vendas1 < vendas2) THEN
    DBMS_OUTPUT.PUT_LINE('O ano ' || ano2 || ' teve mais vendas que o ano ' || ano1);
  ELSE
    DBMS_OUTPUT.PUT_LINE('O ano ' || ano1 || ' teve o mesmo número de vendas que o ano ' || ano2);  
  END IF;
  DBMS_OUTPUT.PUT_LINE('Vendas ano ' || ano1 || ': ' || vendas1);
  DBMS_OUTPUT.PUT_LINE('Vendas ano ' || ano2 || ': ' || vendas2);
ELSE
  RAISE_APPLICATION_ERROR(-20111, 'Ano inválido');
END IF;  
END;

-- View que mostra a evolução das vendas mensais de um tipo de cultura
CREATE OR REPLACE VIEW VendasMensaisTipoCultura AS 
SELECT t.mes, c.tipoCultura, v.vendasMilharesEuros as valor
FROM Vendas v
INNER JOIN Tempo t ON v.codTempo = t.codTempo
INNER JOIN Produto p ON v.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura;  