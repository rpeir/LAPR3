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


    public Map<ClienteProdutorEmpresa, Cabaz> createExpeditionList(int dia, int n) {
        Map<ClienteProdutorEmpresa, Cabaz> result = new HashMap<>(); // mapa de clientes a mapa de produtores a lista de produtores e a quantidade do produto
        PedidosStore pedidosStore = App.getInstance().getPedidosStore();    // lista de pedidos
        Stock stock = App.getInstance().getStock();                         // lista de stock
        List<Pedido> listaPedidos = pedidosStore.getPedidoMap().get(dia);   // lista de pedidos do dia
        List<Pedido> listaStock = stock.getStockMap().get(dia);             // lista de stock do dia
        int indexPedido = 0;
        for (Pedido currentPedido : listaPedidos) {                         // para cada pedido
            ClienteProdutorEmpresa currentCliente = App.getInstance().getClienteProdutorEmpresaStore().getCPE(currentPedido.getClienteProdutor()); // cliente do pedido
            List<ClienteProdutorEmpresa> closestProdutores = getNProdutores(currentCliente, n);         // lista de produtores mais proximos
            List<Pedido> validStock = validStock(listaStock, closestProdutores);                        // lista de stock que satisfaz os produtores mais proximos
            int indexProduto = 0;
            for (Float qtdProduto : currentPedido.getProdutos()) {                                      // para cada produto do pedido
                int indexProdutor = 0;                                                                  // indice do produtor
                boolean success = false;                                                                // flag para saber se foi possivel satisfazer o pedido
                do {
                    Pedido currentStock = validStock.get(indexProdutor);                                // stock do produtor
                    if (qtdProduto > 0 && currentStock.getProduto(indexProduto) > 0) {                  // se a quantidade do produto for maior que 0 e o stock for maior que 0
                        ClienteProdutorEmpresa currentProdutor = App.getInstance().getClienteProdutorEmpresaStore().getCPE(currentStock.getClienteProdutor()); // produtor do stock
                        if (currentStock.getProduto(indexProduto) >= qtdProduto) {                      // se o stock for maior ou igual a quantidade do produto
                            if (result.containsKey(currentCliente)) {                                   // se o cliente ja estiver no mapa
                                if (result.get(currentCliente).containsKey(currentProdutor)) {          // se o produtor ja estiver no mapa
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto)); // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                } else {                                                                // se o produtor nao estiver no mapa
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();  // cria uma lista temporaria
                                    tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto));    // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                    result.get(currentCliente).put(currentProdutor, tempList);          // adiciona o produtor ao mapa do cliente com a lista temporaria
                                }
                            } else {                                                                    // se o cliente nao estiver no mapa
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();    // cria um mapa temporario
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();  // cria uma lista temporaria
                                tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, qtdProduto));    // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                tempMap.put(currentProdutor, tempList);                                 // adiciona o produtor ao mapa temporario com a lista temporaria
                                Cabaz tempCabaz = new Cabaz(currentCliente.getId(), tempMap);                                   // cria um cabaz temporario com o mapa temporario
                                result.put(currentCliente, tempCabaz);                                    // adiciona o cliente ao mapa com o mapa temporario
                            }
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexPedido, 0);        // remove a quantidade do produto do pedido
                            validStock.get(indexProdutor).setProdutoByIndex(indexPedido, currentStock.getProduto(indexProduto) - qtdProduto);   // remove a quantidade do produto do stock
                            success = true;                                                             // marca a flag como true
                        } else {                                                                        // se o stock for menor que a quantidade do produto
                            if (result.containsKey(currentCliente)) {                                   // se o cliente ja estiver no mapa
                                if (result.get(currentCliente).containsKey(currentProdutor)) {          // se o produtor ja estiver no mapa
                                    result.get(currentCliente).get(currentProdutor).add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, validStock.get(indexProdutor).getProduto(indexProduto)));     // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                } else {                                                                // se o produtor nao estiver no mapa
                                    List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();  // cria uma lista temporaria
                                    tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, currentStock.getProduto(indexProduto))); // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                    result.get(currentCliente).put(currentProdutor, tempList);          // adiciona o produtor ao mapa do cliente com a lista temporaria
                                }
                            } else {                                                                    // se o cliente nao estiver no mapa
                                Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> tempMap = new HashMap<>();    // cria um mapa temporario
                                List<AbstractMap.SimpleEntry<String, Float>> tempList = new ArrayList<>();  // cria uma lista temporaria
                                tempList.add(new AbstractMap.SimpleEntry<>("Prod" + 1 + indexProdutor, currentStock.getProduto(indexProduto)));     // adiciona a quantidade do produto do pedido ao produtor fornecida pelo mesmo
                                tempMap.put(currentProdutor, tempList);                                 // adiciona o produtor ao mapa temporario com a lista temporaria
                                Cabaz tempCabaz = new Cabaz(currentCliente.getId(), tempMap);                                   // cria um cabaz temporario com o mapa temporario
                                result.put(currentCliente, tempCabaz);                                    // adiciona o cliente ao mapa com o mapa temporario
                            }
                            listaPedidos.get(indexPedido).setProdutoByIndex(indexPedido, qtdProduto - currentStock.getProduto(indexProduto));   // remove a quantidade do produto do pedido
                            validStock.get(indexProdutor).setProdutoByIndex(indexPedido, 0);        // remove a quantidade do produto do stock
                        }
                    }
                    indexProdutor++;                                                                     // incrementa o index do produtor
                } while (success);                                                                       // enquanto a flag for verdadeira
                indexProduto++;                                                                          // incrementa o index do produto
            }
            indexPedido++;                                                                               // incrementa o index do pedido
        }
        App.getInstance().getListaExpedicoesStore().getExpedicoes().put(dia, result);                    // guarda o mapa na instância da aplicação
        return result;                                                                                  // retorna o mapa
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
