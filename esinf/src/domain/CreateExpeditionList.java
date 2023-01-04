//package domain;
//
//import Controller.App;
//import Controller.ClosestHubController;
//import graph.Algorithms;
//import graph.Graph;
//import store.PedidosStore;
//import store.Stock;
//
//import java.util.*;
//
//public class CreateExpeditionList {
//
//    private final Graph<Localizacao, Integer> graph;
//
//    public CreateExpeditionList() {
//        this.graph = App.getInstance().getGraph();
//    }
//
//    public List<ClienteProdutorEmpresa>  getNProdutores(ClienteProdutorEmpresa cpe, int n){
//        ClosestHubController closestHubController = new ClosestHubController();
//        ClienteProdutorEmpresa closestHub = closestHubController.getClosestHub(cpe);
//        Map<Integer,ClienteProdutorEmpresa> produtoresMap = new TreeMap<>();
//        for (ClienteProdutorEmpresa currentCPE: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
//            LinkedList<Localizacao> list = new LinkedList<>();
//            if (currentCPE.isProdutor() || currentCPE.isEmpresa()){
//                Integer tempLenPath = Algorithms.shortestPath(graph, closestHub.getLocalizacao(), currentCPE.getLocalizacao(), Integer::compare,Integer::sum, 0,list );
//                produtoresMap.put(tempLenPath,currentCPE);
//                if (produtoresMap.keySet().size() > n)
//                    produtoresMap.remove(produtoresMap.keySet().stream().max(Integer::compare));
//            }
//        }
//        return (List<ClienteProdutorEmpresa>) produtoresMap.values();
//    }
//
//
//    public Map<ClienteProdutorEmpresa, List<Float>> createExpeditionList(int dia, int n){
//        Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<Float>>> result = new HashMap<>();
//        PedidosStore pedidosStore = App.getInstance().getPedidosStore();
//        Stock stock = App.getInstance().getStock();
//        Graph<Localizacao, Integer> graph = App.getInstance().getGraph();
//        List<Pedido> listaPedidos = pedidosStore.getPedidoMap().get(dia);
//        List<Pedido> listaStock = stock.getStockMap().get(dia);
//        for (Pedido currentPedido:listaPedidos) {
//            ClienteProdutorEmpresa currentCliente = App.getInstance().getClienteProdutorEmpresaStore().getCPE(currentPedido.getClienteProdutor());
//            List<ClienteProdutorEmpresa> closestProdutores = getNProdutores(currentCliente,n);
//            for (Float produto: currentPedido.getProdutos()) {
//                int currentIndex = 0;
//                boolean success = false;
//                do{
//
//                }while (success!=false);
//
//            }
//
//        }
//    }
//
//    public boolean retirarStock(List<Float> currentPedido, int indexPedido, List)
//}
