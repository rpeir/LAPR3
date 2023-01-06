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
        List<AbstractMap.SimpleEntry<Integer, ClienteProdutorEmpresa>> produtoresList = new ArrayList<>();
        for (ClienteProdutorEmpresa currentCPE : App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            LinkedList<Localizacao> list = new LinkedList<>();
            if (currentCPE.isProdutor()) {
                Integer tempLenPath = Algorithms.shortestPath(graph, closestHub.getLocalizacao(), currentCPE.getLocalizacao(), Integer::compare, Integer::sum, 0, list);
                produtoresList.add(new AbstractMap.SimpleEntry<>(tempLenPath, currentCPE));
                if (produtoresList.size() > n) {
                    class DistanceComparator implements Comparator<AbstractMap.SimpleEntry<Integer, ClienteProdutorEmpresa>> {
                        public int compare(AbstractMap.SimpleEntry<Integer, ClienteProdutorEmpresa> o1, AbstractMap.SimpleEntry<Integer, ClienteProdutorEmpresa> o2) {
                            return o1.getKey().compareTo(o2.getKey());
                        }
                    }
                    produtoresList.sort(new DistanceComparator());
                    produtoresList.remove(produtoresList.size() - 1);
                }

            }
        }
        List<ClienteProdutorEmpresa> result = new ArrayList<>();
        for (AbstractMap.SimpleEntry<Integer, ClienteProdutorEmpresa> produtorEntry : produtoresList) {
            result.add(produtorEntry.getValue());
        }
        return result;
    }


    public Map<ClienteProdutorEmpresa, Cabaz> createExpeditionList(int dia, int n) {
        Map<ClienteProdutorEmpresa, Cabaz> result = new HashMap<>();
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
                do {
                    Pedido currentStock = validStock.get(indexProdutor);
                    if (qtdProduto > 0 && currentStock.getProduto(indexProduto) > 0) {
                        ClienteProdutorEmpresa currentProdutor = App.getInstance().getClienteProdutorEmpresaStore().getCPE(currentStock.getClienteProdutor());
                        if (currentStock.getProduto(indexProduto) >= qtdProduto) {
                            if (result.containsKey(currentCliente)) {
                                if (result.get(currentCliente).containsKey(currentProdutor)) {
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Produto" +( 1 + indexProduto) + ": ", qtdProduto));
                                } else {
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                    tempList.add(new AbstractMap.SimpleEntry<>("Produto" + (1 + indexProduto) + ": ", qtdProduto));
                                    result.get(currentCliente).put(currentProdutor, tempList);
                                }
                            } else {
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                tempList.add(new AbstractMap.SimpleEntry<>("Produto" +( 1 + indexProduto) + ": ", qtdProduto));
                                tempMap.put(currentProdutor, tempList);
                                Cabaz tempCabaz = new Cabaz(currentProdutor.getId(), tempMap);
                                result.put(currentCliente, tempCabaz);
                            }
                            validStock.get(indexProdutor).setProdutoByIndex(indexProduto, currentStock.getProduto(indexProduto) - qtdProduto);
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexProduto, 0);
                            qtdProduto = (float) 0;
                        } else {
                            if (result.containsKey(currentCliente)) {
                                if (result.get(currentCliente).containsKey(currentProdutor)) {
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Produto" + (1 + indexProduto) + ": ", currentStock.getProduto(indexProduto)));
                                } else {
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                    tempList.add(new AbstractMap.SimpleEntry<>("Produto" +( 1 + indexProduto) + ": ", currentStock.getProduto(indexProduto)));
                                    result.get(currentCliente).put(currentProdutor, tempList);
                                }
                            } else {
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();
                                tempList.add(new AbstractMap.SimpleEntry<>("Produto" + (1 + indexProduto) + ": ", currentStock.getProduto(indexProduto)));
                                tempMap.put(currentProdutor, tempList);
                                Cabaz tempCabaz = new Cabaz(currentProdutor.getId(), tempMap);
                                result.put(currentCliente, tempCabaz);
                            }
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexProduto, qtdProduto - currentStock.getProduto(indexProduto));
                            qtdProduto = qtdProduto - currentStock.getProduto(indexProduto);
                            validStock.get(indexProdutor).setProdutoByIndex(indexProduto, 0);
                        }
                    }
                    indexProdutor++;
                } while (qtdProduto > 0 && indexProdutor < validStock.size() && indexProduto < validStock.get(0).getProdutos().size());
                indexProduto++;
            }
            App.getInstance().getStockAfterExpedition().insertUpdatedStock(validStock);
            indexPedido++;
        }
        App.getInstance().getListaExpedicoesStore().setExpedicaoNumDia(result, dia);
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
