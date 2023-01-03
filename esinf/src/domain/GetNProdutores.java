package domain;

import Controller.App;
import Controller.ClosestHubController;
import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;

import java.util.*;

public class GetNProdutores {

    private final Graph<Localizacao, Integer> graph;

    public GetNProdutores(Graph<Localizacao, Integer> graph) {
        this.graph = App.getInstance().getGraph();
    }

//    public Map<Integer,ClienteProdutorEmpresa>  getNProdutores(ClienteProdutorEmpresa cpe, int n){
//        ClosestHubController closestHubController = new ClosestHubController();
//        ClienteProdutorEmpresa closestHub = closestHubController.getClosestHub(cpe);
//        Map<Integer,ClienteProdutorEmpresa> produtoresMap = new TreeMap<>();
//        for (ClienteProdutorEmpresa currentCPE: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
//            LinkedList<Localizacao> list = new LinkedList<>();
//            Integer tempLenPath = Algorithms.shortestPath(graph, cpe.getLocalizacao(), currentCPE.getLocalizacao(), Integer::compare,Integer::sum, 0,list );
//            produtoresMap.put(tempLenPath,currentCPE);
//            if (produtoresMap.keySet().size() > n)
//                produtoresMap.remove(produtoresMap.las);
//
//        }
//        return produtoresMap;
//    }

}
