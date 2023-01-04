package domain;

import Controller.App;
import Controller.ClosestHubController;
import graph.Algorithms;
import graph.Graph;
import store.PedidosStore;
import store.Stock;

import java.util.*;

public class CreateExpeditionList {

    private final Graph<Localizacao, Integer> graph;

    public CreateExpeditionList() {
        this.graph = App.getInstance().getGraph();
    }

    public List<ClienteProdutorEmpresa> getNProdutores(ClienteProdutorEmpresa cpe, int n) {
        ClosestHubController closestHubController = new ClosestHubController();
        ClienteProdutorEmpresa closestHub = closestHubController.getClosestHub(cpe);
        Map<Integer, ClienteProdutorEmpresa> produtoresMap = new TreeMap<>();
        for (ClienteProdutorEmpresa currentCPE : App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            LinkedList<Localizacao> list = new LinkedList<>();
            if (currentCPE.isProdutor() || currentCPE.isEmpresa()) {
                Integer tempLenPath = Algorithms.shortestPath(graph, closestHub.getLocalizacao(), currentCPE.getLocalizacao(), Integer::compare, Integer::sum, 0, list);
                produtoresMap.put(tempLenPath, currentCPE);
                if (produtoresMap.keySet().size() > n)
                    produtoresMap.remove(produtoresMap.keySet().stream().max(Integer::compare));
            }
        }
        return (List<ClienteProdutorEmpresa>) produtoresMap.values();
    }


    public Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> createExpeditionList(int dia, int n) {
        Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> result = new HashMap<>();
        PedidosStore pedidosStore = App.getInstance().getPedidosStore();
        Stock stock = App.getInstance().getStock();
        List<Pedido> listaPedidos = pedidosStore.getPedidoMap().get(dia);
        List<Pedido> listaStock = stock.getStockMap().get(dia);
        int indexPedido = 0;
        for (Pedido currentPedido : listaPedidos) {
            ClienteProdutorEmpresa currentCliente = App.getInstance().getClienteProdutorEmpresaStore().getCPE(currentPedido.getClienteProdutor());
            List<ClienteProdutorEmpresa> closestProdutores = getNProdutores(currentCliente, n);
            List<Pedido> validStock = validStock(listaStock, closestProdutores);
            int indexProduto = 0;
            for (Float qtdProduto : currentPedido.getProdutos()) {
                int indexProdutor = 0;
                boolean success = false;
                do {
                    if (qtdProduto > 0 && validStock.get(indexProdutor).getProduto(indexProduto) > 0) {
                        ClienteProdutorEmpresa currentProdutor = App.getInstance().getClienteProdutorEmpresaStore().getCPE(validStock.get(indexProdutor).getClienteProdutor());
                        if (validStock.get(indexProdutor).getProduto(indexProduto) >= qtdProduto) {
                            if (result.containsKey(currentCliente)) {
                                if (result.get(currentCliente).containsKey(currentProdutor)) {
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto));
                                } else {
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                    tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto));
                                    result.get(currentCliente).put(currentProdutor, tempList);
                                }
                            } else {
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto));
                                tempMap.put(currentProdutor, tempList);
                                result.put(currentCliente, tempMap);
                            }
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexPedido, 0);
                            validStock.get(indexProdutor).setProdutoByIndex(indexPedido, validStock.get(indexProdutor).getProduto(indexProduto) - qtdProduto);
                            success = true;
                        } else {
                            if (result.containsKey(currentCliente)) {
                                if (result.get(currentCliente).containsKey(currentProdutor)) {
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, validStock.get(indexProdutor).getProduto(indexProduto)));
                                } else {
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                    tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, validStock.get(indexProdutor).getProduto(indexProduto)));
                                    result.get(currentCliente).put(currentProdutor, tempList);
                                }
                            } else {
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, validStock.get(indexProdutor).getProduto(indexProduto)));
                                tempMap.put(currentProdutor, tempList);
                                result.put(currentCliente, tempMap);
                            }
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexPedido, qtdProduto - validStock.get(indexProdutor).getProduto(indexProduto));
                            validStock.get(indexProdutor).setProdutoByIndex(indexPedido, 0);
                        }
                    }
                    indexProdutor++;
                } while (success);
                indexProduto++;
            }
            indexPedido++;
        }
        return result;
    }

    public List<Pedido> validStock(List<Pedido> listaStock, List<ClienteProdutorEmpresa> closestProdutores) {
        List<Pedido> result = new ArrayList<>();
        for (Pedido pedido : listaStock) {
            for (ClienteProdutorEmpresa produtor : closestProdutores) {
                if (pedido.getClienteProdutor().equals(produtor.getId()))
                    result.add(pedido);
            }
        }
        return result;
    }

}
