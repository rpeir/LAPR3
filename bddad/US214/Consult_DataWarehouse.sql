-- View que mostra a evolução de uma determinada cultura num determinado setor agrícola nos últimos 5 anos
CREATE OR REPLACE VIEW ProducaoCulturaSetorAgricola
AS
SELECT t.ano, c.tipoCultura, SUM(pr.producaoToneladas) as producao
FROM Producoes pr
INNER JOIN Tempo t ON pr.codTempo = t.codTempo
INNER JOIN Produto p ON pr.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
WHERE t.ano >= (EXTRACT(YEAR FROM sysdate)-5)
GROUP BY t.ano, c.tipoCultura;

-- Query que avalia a evolução de uma cultura num determinado setor agricola ao longo dos anos
SELECT t.ano, c.tipoCultura, SUM(pr.producaoToneladas) as producao 
FROM Producoes pr
INNER JOIN Tempo t ON pr.codTempo = t.codTempo
INNER JOIN Produto p ON pr.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
GROUP BY t.ano, c.tipoCultura;

-- View que mostra a evolução das vendas mensais de um tipo de cultura
CREATE OR REPLACE VIEW VendasMensaisTipoCultura AS 
  SELECT t.mes, c.tipoCultura, v.vendasMilharesEuros as valor
FROM Vendas v
INNER JOIN Tempo t ON v.codTempo = t.codTempo
INNER JOIN Produto p ON v.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura;