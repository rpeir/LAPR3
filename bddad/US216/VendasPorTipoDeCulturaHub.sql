-- on snowflae sesion

-- opcao 1 - query que retorna a quantidade de vendas por tipo de cultura, agrupado por mês
SELECT Tempo.mes, Cultura.tipoCultura, SUM(Estatistica.vendasMilharesEuros) as totalVendas
FROM Estatistica
INNER JOIN Produto ON Estatistica.codProduto = Produto.codProduto
INNER JOIN Cultura ON Produto.codCultura = Cultura.codCultura
INNER JOIN Tempo ON Estatistica.codTempo = Tempo.codTempo
GROUP BY Tempo.mes, Cultura.tipoCultura;


-- opcao 2 - query que retorna a quantidade de vendas por tipo de cultura, agrupado por mês num ano especifico
SELECT Tempo.mes, Cultura.tipoCultura, SUM(Estatistica.vendasMilharesEuros) as totalVendas
FROM Estatistica
INNER JOIN Produto ON Estatistica.codProduto = Produto.codProduto
INNER JOIN Cultura ON Produto.codCultura = Cultura.codCultura
INNER JOIN Tempo ON Estatistica.codTempo = Tempo.codTempo
WHERE Tempo.ano = 2021
GROUP BY Tempo.mes, Cultura.tipoCultura;

-- opcao 3 - Cria uma view que mostra o total de vendas por tipo de cultura e hub de distribuição, por mes
CREATE VIEW VendasPorCulturaHub AS
SELECT Tempo.mes, Cultura.tipoCultura, Hub.tipoHub, SUM(Estatistica.vendasMilharesEuros) as totalVendas
FROM Estatistica
INNER JOIN Produto ON Estatistica.codProduto = Produto.codProduto
INNER JOIN Cultura ON Produto.codCultura = Cultura.codCultura
INNER JOIN Tempo ON Estatistica.codTempo = Tempo.codTempo
INNER JOIN Hub ON Estatistica.codHub = Hub.codHub
GROUP BY Tempo.mes, Cultura.tipoCultura, Hub.tipoHub;

