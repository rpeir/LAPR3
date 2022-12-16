-- ATUALIZA O VALOR TOTAL DA COLHEITA-CULTURA QUANDO É ADICIONADO UMA NOVA COLHEITA-CULTURA DE UM SETOR AGRÍCOLA

CREATE OR REPLACE TRIGGER atualizarValorTotalNOVAColheitaCultura_trg
AFTER INSERT ON SetoresAgricolas_Colheitas_Culturas
FOR EACH ROW

DECLARE

    l_newValorTotal Colheitas_Culturas.valorTotalColheita%TYPE;

BEGIN

    SELECT valorTotalColheita INTO l_newValorTotal
    FROM Colheitas_Culturas cc
    WHERE cc.codColheita = :new.codColheita 
    AND cc.codCultura = :new.codCultura;
    l_newValorTotal := l_newValorTotal + :new.valorSetor;

    UPDATE Colheitas_Culturas cc SET valorTotalColheita = l_newValorTotal
    WHERE cc.codColheita = :new.codColheita
    AND cc.codCultura = :new.codCultura;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado a colheita-cultura correspondente.');
END;

-- ATUALIZA O VALOR TOTAL DA COLHEITA-CULTURA QUANDO É ALTERADO UMA COLHEITA-CULTURA DE UM SETOR AGRÍCOLA

CREATE OR REPLACE TRIGGER atualizarValorTotalUPDATEColheitaCultura_trg
AFTER UPDATE ON SetoresAgricolas_Colheitas_Culturas
FOR EACH ROW

DECLARE

    l_newValorTotal Colheitas_Culturas.valorTotalColheita%TYPE;

BEGIN

    SELECT valorTotalColheita INTO l_newValorTotal
    FROM Colheitas_Culturas cc
    WHERE cc.codColheita = :new.codColheita 
    AND cc.codCultura = :new.codCultura;
    l_newValorTotal := l_newValorTotal + :new.valorSetor - :old.valorSetor;

    UPDATE Colheitas_Culturas cc SET valorTotalColheita = l_newValorTotal
    WHERE cc.codColheita = :new.codColheita
    AND cc.codCultura = :new.codCultura;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado a colheita-cultura correspondente.');
END;

-- ATUALIZA O VALOR TOTAL DO PEDIDO QUANDO É ADICIONADO UM NOVO PRODUTO AO PEDIDO

CREATE OR REPLACE TRIGGER atualizarValorTotalNOVOPedido_trg
AFTER INSERT ON PEDIDOS_PRODUTOS
FOR EACH ROW

DECLARE 

    l_newValorTotal Pedidos.valorTotal%TYPE;

BEGIN

    SELECT valorTotal INTO l_newValorTotal
    FROM Pedidos p
    WHERE p.codPedido = :new.codPedido;
    l_newValorTotal := l_newValorTotal + :new.precoPedido * :new.quantidadeProduto;

    UPDATE Pedidos p SET valorTotal = l_newValorTotal
    WHERE p.codPedido = :new.codPedido;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado o pedido correspondente.');
END;

-- ATUALIZA O VALOR TOTAL DO PEDIDO QUANDO É ALTERADO PRODUTO DO PEDIDO

CREATE OR REPLACE TRIGGER atualizarValorTotalUPDATEPedido_trg
AFTER INSERT ON PEDIDOS_PRODUTOS
FOR EACH ROW

DECLARE 

    l_newValorTotal Pedidos.valorTotal%TYPE;

BEGIN

    SELECT valorTotal INTO l_newValorTotal
    FROM Pedidos p
    WHERE p.codPedido = :new.codPedido;
    l_newValorTotal := l_newValorTotal + (:new.precoPedido * :new.quantidadeProduto) - (:old.precoPedido * :old.quantidadeProduto);

    UPDATE Pedidos p SET valorTotal = l_newValorTotal
    WHERE p.codPedido = :new.codPedido;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado o pedido correspondente.');
END;

--- FUNCAO QUE RETORNA O PRECO DO PRODUTO ATRAVES DE UM CODIGO DE PRODUTO

CREATE OR REPLACE FUNCTION fncPrecoProdutoByCodProduto(
    in_codProduto IN Produtos.codProduto%TYPE
    ) RETURN Produtos.precokg%TYPE IS
    l_precoProduto Produtos.precokg%TYPE;

BEGIN

    SELECT precokg INTO l_precoProduto
    FROM Produtos p
    WHERE p.codProduto = in_codProduto;

    RETURN l_precoProduto;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado o produto correspondente.');
END;

-- TRIGGER QUE COPIA O VALOR DO PRECO DO PRODUTO PARA O PRECO DO PEDIDO_PRODUTO QUANDO NAO É INFORMADO O PRECO DO PEDIDO_PRODUTO

CREATE OR REPLACE TRIGGER copiarPrecoProdutoPedido_trg
BEFORE INSERT ON PEDIDOS_PRODUTOS
FOR EACH ROW

DECLARE

    l_precoProduto Produtos.precokg%TYPE;

BEGIN

    IF :new.precoPedido IS NULL THEN
        l_precoProduto := fncPrecoProdutoByCodProduto(:new.codProduto);
        :new.precoPedido := l_precoProduto;
    END IF;

END;

-- TRIGGER QUE ATUALIZA O STOCK DO PRODUTO QUANDO É ADICIONADO UM NOVO PEDIDO_PRODUTO

CREATE OR REPLACE TRIGGER atualizarStockNOVOPedido_trg
AFTER INSERT ON PEDIDOS_PRODUTOS
FOR EACH ROW

DECLARE

    newStock Produtos.stockkg%TYPE;

BEGIN

    SELECT stockkg INTO newStock
    FROM Produtos p
    WHERE p.codProduto = :new.codProduto;
    newStock := newStock - :new.quantidadeProduto;

    UPDATE Produtos p SET stockkg = newStock
    WHERE p.codProduto = :new.codProduto;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado o produto correspondente.');
END;

-- TRIGGER QUE ATUALIZA O STOCK DO PRODUTO QUANDO É ALTERADO UM PEDIDO_PRODUTO

CREATE OR REPLACE TRIGGER atualizarStockUPDATEPedido_trg
AFTER UPDATE ON PEDIDOS_PRODUTOS
FOR EACH ROW

DECLARE

    newStock Produtos.stockkg%TYPE;

BEGIN

    SELECT stockkg INTO newStock
    FROM Produtos p
    WHERE p.codProduto = :new.codProduto;
    newStock := newStock - (:new.quantidadeProduto - :old.quantidadeProduto);

    UPDATE Produtos p SET stockkg = newStock
    WHERE p.codProduto = :new.codProduto;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrado o produto correspondente.');
END;

-- TRIGGER QUE ATUALIZA O ESTADO DO PEDIDO_PAGAMENTO_ENTREGA QUANDO ENTREGA É ATUALIZADA

CREATE OR REPLACE TRIGGER updateEstadoPedidosPagamentosEntregasWhenEntrega_trg
AFTER UPDATE ON Entregas
FOR EACH ROW

BEGIN

    IF :new.dataEntrega IS NOT NULL THEN
        UPDATE Pedidos_Pagamentos_Entregas ppe SET estadoAtual = 'Entregue'
    WHERE ppe.codEntrega = :new.codEntrega;
    END IF;

END;

-- TRIGGER QUE ATUALIZA O ESTADO DO PEDIDO_PAGAMENTO_ENTREGA QUANDO PAGAMENTO É ATUALIZADA

CREATE OR REPLACE TRIGGER updateEstadoPedidosPagamentosEntregasWhenPagamento_trg
AFTER UPDATE ON Pagamentos
FOR EACH ROW

BEGIN

    IF :new.dataPagamento IS NOT NULL THEN
        UPDATE Pedidos_Pagamentos_Entregas ppe SET estadoAtual = 'Paga'
        WHERE ppe.codPagamento = :new.codPagamento;
    END IF;

END;

