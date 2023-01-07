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
SELECT COUNT(*) INTO numberClients FROM Clientes WHERE Clientes.codInterno = codInterno; -- verifica numero de clientes com aquele codigo
SELECT MAX(codPedido) INTO codPedido FROM Pedidos;                              -- seleciona valor maximo de codigo de pedido 
SELECT MAX(codPagamento) INTO codPagamento FROM Pagamentos;                     -- seleciona valor maximo de codigo de pagamento
SELECT MAX(codEntrega) INTO codEntrega FROM Entregas;                           -- seleciona valor maximo de codigo de entrega
IF (codMorada IS NULL) THEN                                                     -- verifica se foi escolhida uma morada de entrega
    SELECT codMorada INTO codMoradaEscolhido FROM MoradasEntrega WHERE MoradasEntrega.codInterno = codInterno;   -- guarda morada default do cliente
ELSE
    codMoradaEscolhido := codMorada;                                            -- guarda morada escolhida
END IF;
IF (numberClients = 1)                                                          -- verifica se existe cliente com aquele codigo
THEN
INSERT INTO Pedidos (codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (codPedido+1, codInterno, 0, CURRENT_DATE, CURRENT_DATE + diasAteVencimento); -- cria pedido com valores superiores aos máximos já existentes
INSERT INTO Pagamentos (codPagamento, dataPagamento) VALUES (codPagamento+1, NULL);                                                 -- cria pagamento com valores superiores aos máximos já existentes
INSERT INTO Entregas (codEntrega, codMorada, dataEntrega) VALUES (codEntrega+1, codMoradaEscolhido, NULL);                          -- cria entrega com valores superiores aos máximos já existentes
INSERT INTO Pedidos_Pagamentos_Entregas (codPedido, codPagamento, codEntrega) VALUES (codPedido+1, codPagamento+1, codEntrega+1);   -- cria ligação entre pedido, pagamento e entrega
ELSE
RAISE_APPLICATION_ERROR(-20011, 'Cliente não encontrado');
END IF;
RETURN codPedido;                                                               -- retorna codigo do pedido criado
END fncCreatePedido;


--Procedimento que adiciona um produto num pedido
CREATE OR REPLACE PROCEDURE createPedidoProduto(codPedido Pedidos.codPedido%type, codProduto Produtos.codProduto%type, quantidadeProduto INTEGER)
IS
numberPedidos INTEGER;
numberProdutos INTEGER;
precoKg FLOAT;
BEGIN
Select count(*) INTO numberPedidos from Pedidos where Pedidos.codPedido = codPedido;
Select count(*) INTO numberProdutos from Produtos where Produtos.codProduto = codProduto;
IF (numberPedidos = 1 AND numberProdutos = 1)                                       -- verifica se existe pedido e produto com aquele codigo
THEN
Select precoKg INTO precoKg from Produtos where Produtos.codProduto = codProduto;
INSERT INTO Pedidos_Produtos (codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (codPedido, codProduto, quantidadeProduto, quantidadeProduto*precoKg);  -- cria ligação entre pedido e produto
ELSE
RAISE_APPLICATION_ERROR(-20022, 'Pedido ou Produto não encontrado');
END IF;
END createPedidoProduto;

--Função que verifica se o valor total de encomendas de um cliente ultrapassa o plafond
CREATE OR REPLACE FUNCTION fncIsOverPlafond(codInterno Clientes.codInterno%type, codPedido Pedidos.codPedido%type) return BOOLEAN
IS
valorTotal FLOAT;
plafond FLOAT;
BEGIN
SELECT SUM(valorTotal) INTO valorTotal      -- soma dos valores totais de todos os pedidos do cliente, falta verificar que o valor total é de um pedido desse cliente
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido WHERE Pedidos_Pagamentos_Entregas.estadoAtual != 'P'; -- estado pago
SELECT plafond INTO plafond FROM Clientes WHERE Clientes.codInterno = codInterno;
IF (valorTotal > plafond)                       -- valor total encomendas maior que o plafond daquele cliente
RETURN TRUE;                                    -- ultrapassa plafond
ELSE
RETURN FALSE;                                   -- não ultrapassa plafond
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
Select count(*) INTO numberPedidos from Pedidos where Pedidos.codPedido = codPedido;
IF (numberPedidos = 1)                                                                  -- existe pedido
THEN
SELECT codEntrega INTO codEntrega FROM Pedidos_Pagamentos_Entregas WHERE Pedidos_Pagamentos_Entregas.codPedido = codPedido; -- seleciona o codigo de entrega do pedido_pagamento_entrega
UPDATE Entregas SET dataEntrega = dataEntrega WHERE Entregas.codEntrega = codEntrega;                                       -- faz set da data passada por parametro
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
Select count(*) INTO numberPedidos from Pedidos where Pedidos.codPedido = codPedido;
IF (numberPedidos = 1)                                                          -- o pedido existe
THEN
SELECT codPagamento INTO codPagamento FROM Pedidos_Pagamentos_Entregas WHERE Pedidos_Pagamentos_Entregas.codPedido = codPedido; -- encontra o pagamento
UPDATE Pagamentos SET dataPagamento = dataPagamento WHERE Pagamentos.codPagamento = codPagamento;           -- faz set da data de pagamento
ELSE
RAISE_APPLICATION_ERROR(-20044, 'Pedido não encontrado');
END IF;
END createDataPagamento;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Criterio Aceitacao 4

--View que lista pedidos por estado registado
CREATE OR REPLACE VIEW viewPedidosPorEstadoRegistado AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
-- inner join onde pedidos e pedidos_pagamentos_entregas têm o mesmo código de pedido e estado registado
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'R';

--View que lista pedidos por estado entregue
CREATE OR REPLACE VIEW viewPedidosPorEstadoEntregue AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
-- inner join onde pedidos e pedidos_pagamentos_entregas têm o mesmo código de pedido e estado entregue
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'E';

--View que lista pedidos por estado pago
CREATE OR REPLACE VIEW viewPedidosPorEstadoPago AS
SELECT Pedidos.codPedido, Pedidos.codInterno, Pedidos.valorTotal, Pedidos.dataPedido, Pedidos.dataVencimento, Pedidos_Pagamentos_Entregas.estadoAtual
-- inner join onde pedidos e pedidos_pagamentos_entregas têm o mesmo código de pedido e estado pago
FROM Pedidos INNER JOIN Pedidos_Pagamentos_Entregas ON Pedidos.codPedido = Pedidos_Pagamentos_Entregas.codPedido AND Pedidos_Pagamentos_Entregas.estadoAtual = 'P';