--Criterio Aceitacao 1

--Função que cria pedido de um cliente
CREATE OR REPLACE FUNCTION fncCreatePedido(
    codInterno IN Clientes.codInterno%type, diasAteVencimento integer, codMorada IN Moradas.codMorada%type) return INTEGER
IS
codPedido INTEGER;
codPagamento INTEGER;
codEntrega INTEGER;
numberClients INTEGER;
codMoradaEscolhido INTEGER;
BEGIN
SELECT COUNT(*) INTO numberClients FROM Clientes WHERE codInterno = codInterno;
SELECT MAX(codPedido) INTO codPedido FROM Pedidos;
SELECT MAX(codPagamento) INTO codPagamento FROM Pagamentos;
SELECT MAX(codEntrega) INTO codEntrega FROM Entregas;
IF (codMorada IS NULL) THEN
    SELECT MoradasEntrega.codMorada INTO codMoradaEscolhido FROM MoradasEntrega WHERE MoradasEntrega.codInterno = codInterno;
ELSE
    codMoradaEscolhido := codMorada;
END IF;
IF (numberClients = 1)
THEN
INSERT INTO Pedidos (codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (codPedido+1, codInterno, 0, CURRENT_DATE, CURRENT_DATE + diasAteVencimento);
INSERT INTO Pagamentos (codPagamento, dataPagamento) VALUES (codPagamento+1, NULL);
INSERT INTO Entregas (codEntrega, codMorada, dataEntrega) VALUES (codEntrega+1, codMoradaEscolhido, NULL);
INSERT INTO Pedidos_Pagamentos_Entregas (codPedido, codPagamento, codEntrega) VALUES (codPedido+1, codPagamento+1, codEntrega+1);
ELSE
RAISE_APPLICATION_ERROR(-20011, 'Cliente não encontrado');
END IF;
RETURN codPedido;
END fncCreatePedido;


--Procedimento que adiciona um produto num pedido
CREATE OR REPLACE PROCEDURE createPedidoProduto(codPedido Pedidos.codPedido%type, codProduto Produtos.codProduto%type, quantidadeProduto INTEGER)
IS
numberPedidos INTEGER;
numberProdutos INTEGER;
precoKg FLOAT;
BEGIN
Select count(*) INTO numberPedidos from Pedidos where codPedido = codPedido;
Select count(*) INTO numberProdutos from Produtos where codProduto = codProduto;
IF (numberPedidos = 1 AND numberProdutos = 1)
THEN
Select precoKg INTO precoKg from Produtos where codProduto = codProduto;
INSERT INTO Pedidos_Produtos (codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (codPedido, codProduto, quantidadeProduto, quantidadeProduto*precoKg);
ELSE
RAISE_APPLICATION_ERROR(-20022, 'Pedido ou Produto não encontrado');
END IF;
END createPedidoProduto;

--Procedimento que verifica se o valor total de encomendas de um cliente ultrapassa o plafond
CREATE OR REPLACE FUNCTION fncIsOverPlafond(codInterno Clientes.codInterno%type, codPedido Pedidos.codPedido%type) return BOOLEAN
IS
valorTotal FLOAT;
plafond FLOAT;
BEGIN
SELECT SUM(valorTotal) INTO valorTotal
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido WHERE Pedidos_Pagamentos_Entregas.estadoAtual != 'P';
SELECT plafond INTO plafond FROM Clientes WHERE Clientes.codInterno = codInterno;
IF (valorTotal > plafond)
RETURN TRUE;
ELSE
RETURN FALSE;
END IF;
END fncIsOverPlafond;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Criterio Aceitacao 2

--Procedimento que regista a data de entrega de um pedido
CREATE OR REPLACE PROCEDURE createDataEntrega(codPedido Pedidos.codPedido%type, dataEntrega DATE)
IS
numberPedidos INTEGER;
codEntrega INTEGER;
BEGIN
Select count(*) INTO numberPedidos from Pedidos where codPedido = codPedido;
IF (numberPedidos = 1)
THEN
SELECT codEntrega INTO codEntrega FROM Pedidos_Pagamentos_Entregas WHERE Pedidos_Pagamentos_Entregas.codPedido = codPedido;
UPDATE Entregas SET dataEntrega = dataEntrega WHERE Entregas.codEntrega = codEntrega;
ELSE
RAISE_APPLICATION_ERROR(-20044, 'Pedido não encontrado');
END IF;
END createDataEntrega;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Criterio Aceitacao 3

--Procedimento que regista o pagamento de um pedido numa determinada DATA
CREATE OR REPLACE PROCEDURE createDataPagamento(codPedido Pedidos.codPedido%type, dataPagamento DATE)
IS
numberPedidos INTEGER;
codPagamento INTEGER;
BEGIN
Select count(*) INTO numberPedidos from Pedidos where codPedido = codPedido;
IF (numberPedidos = 1)
THEN
SELECT codPagamento INTO codPagamento FROM Pedidos_Pagamentos_Entregas WHERE Pedidos_Pagamentos_Entregas.codPedido = codPedido;
UPDATE Pagamentos SET dataPagamento = dataPagamento WHERE Pagamentos.codPagamento = codPagamento;
ELSE
RAISE_APPLICATION_ERROR(-20044, 'Pedido não encontrado');
END IF;
END createDataPagamento;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Criterio Aceitacao 4

--View que lista pedidos por estado registado
CREATE OR REPLACE VIEW viewPedidosPorEstadoRegistado AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'R';

--View que lista pedidos por estado entregue
CREATE OR REPLACE VIEW viewPedidosPorEstadoEntregue AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'E';

--View que lista pedidos por estado pago
CREATE OR REPLACE VIEW viewPedidosPorEstadoPago AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'P';
