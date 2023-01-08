-- on snowflake2 sesion

-- opcao 1 - query que retorna a quantidade de vendas por tipo de cultura, agrupado por mês
SELECT t.mes, c.tipoCultura, SUM(v.vendasMilharesEuros) as totalVendas
FROM Vendas v
INNER JOIN Tempo t ON v.codTempo = t.codTempo
INNER JOIN Produto p ON v.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
GROUP BY t.mes, c.tipoCultura;

-- opcao 2 - query que retorna a quantidade de vendas por tipo de cultura, agrupado por mês num ano especifico
SELECT t.mes, c.tipoCultura, SUM(v.vendasMilharesEuros) as totalVendas
FROM Vendas v
INNER JOIN Tempo t ON v.codTempo = t.codTempo
INNER JOIN Produto p ON v.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
WHERE t.ano = 2021
GROUP BY t.mes, c.tipoCultura;

-- opcao 3 - Cria uma view que mostra o total de vendas por tipo de cultura e hub de distribuição, por mes
CREATE VIEW vVendasPorTipoCulturaHub AS
SELECT t.mes, c.tipoCultura, h.codHub, SUM(v.vendasMilharesEuros) as totalVendas
FROM Vendas v
INNER JOIN Tempo t ON v.codTempo = t.codTempo
INNER JOIN Produto p ON v.codProduto = p.codProduto
INNER JOIN Cultura c ON p.codCultura = c.codCultura
INNER JOIN Hub h ON v.codHub = h.codHub
GROUP BY t.mes, c.tipoCultura, h.codHub;


