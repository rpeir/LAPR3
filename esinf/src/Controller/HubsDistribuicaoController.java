package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Distancia;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;
import graph.map.MapGraph;

import java.util.*;

public class HubsDistribuicaoController {

    App app;


    public HubsDistribuicaoController() {
        app = App.getInstance();
    }


    public List<ClienteProdutorEmpresa> getEmpresas() {
        Map<String, ClienteProdutorEmpresa> mapCPE = app.getClienteProdutorEmpresaStore().getMapCPE();
        List<ClienteProdutorEmpresa> listaEmpresas = new ArrayList<>();
        for (Map.Entry<String, ClienteProdutorEmpresa> entry : mapCPE.entrySet()) {
            if (entry.getValue().isEmpresa()) {
                listaEmpresas.add(entry.getValue());
            }
        }
        return listaEmpresas;
        // 5 empresas - small
    }

    public Graph<ClienteProdutorEmpresa, Distancia> getGrafoEmpresas(Graph<Localizacao, Integer> grafo) {
        Graph<ClienteProdutorEmpresa, Distancia> grafoEmpresas = new MapGraph<>(false);
        for (ClienteProdutorEmpresa e : getEmpresas()) {
            grafoEmpresas.addVertex(e);
            for (Map.Entry<String, ClienteProdutorEmpresa> cpe : app.getClienteProdutorEmpresaStore().getMapCPE().entrySet()) {
                if (!cpe.getValue().isEmpresa() && !cpe.getValue().isHub()) {
                    if (grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()) != null) {
                        Distancia add = new Distancia(e, cpe.getValue(), grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()).getWeight());
                        grafoEmpresas.addEdge(e, cpe.getValue(), add);
                    }
                }
            }
        }
        System.out.println(grafoEmpresas);
        return grafoEmpresas;
    }

    public Map<ClienteProdutorEmpresa, Double> getMediaDistancia(Graph<ClienteProdutorEmpresa, Distancia> grafoEmpresas, Graph<Localizacao, Integer> grafo) {
        Graph<ClienteProdutorEmpresa, Integer> grafoEmpresas2 = new MapGraph<>(false);
        Map<ClienteProdutorEmpresa, Double> medias = new HashMap<>();
        Double media;
        for (ClienteProdutorEmpresa e : getEmpresas()) {
            grafoEmpresas2.addVertex(e);
            for (Map.Entry<String, ClienteProdutorEmpresa> cpe : app.getClienteProdutorEmpresaStore().getMapCPE().entrySet()) {
                if (!cpe.getValue().isEmpresa() && !cpe.getValue().isHub()) {
                    if (grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()) != null) {
                        Distancia add = new Distancia(e, cpe.getValue(), grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()).getWeight());
                        grafoEmpresas2.addEdge(e, cpe.getValue(), add.getLength());
                    }
                }
            }
        }
        LinkedList<ClienteProdutorEmpresa> caminho = new LinkedList<>();

        for(ClienteProdutorEmpresa cpe1 : grafoEmpresas2.vertices()){
            int i = 0;
            if(cpe1.getDesignacao().contains("E")) {
                double soma = 0;
                double numeroCPE = 0;
                for (ClienteProdutorEmpresa cpe2 : grafoEmpresas2.vertices()) {
                    if (!(cpe2.getDesignacao().contains("E"))) {
                        soma += Algorithms.shortestPath(grafoEmpresas2, cpe1, cpe2, Integer::compare, Integer::sum, 0, caminho);
                        System.out.println(i+ "O caminho mais curto de " + cpe1.getDesignacao() + " para " + cpe2.getDesignacao() + " e: " + caminho + " com " + soma + " de distancia");
                        numeroCPE++;
                        i++;
                    }
                }

                if (numeroCPE != 0) {
                    media = soma / numeroCPE;
                    medias.put(cpe1, media);
                }
            }

//        int menor = Integer.MAX_VALUE;
//        int distanciaTotal = 0;
//        for (ClienteProdutorEmpresa cpe1 : grafoEmpresas.vertices()) {
//            for (ClienteProdutorEmpresa cpe2 : grafoEmpresas.vertices()) {
//                if (grafoEmpresas.edge(cpe1, cpe2) != null) {
//
//                    int distanciaEdge = grafoEmpresas.edge(cpe1, cpe2).getWeight().getLength();
//                    if (distanciaEdge < menor) {
//                        menor = distanciaEdge;
//                    }
//                }
//            }
//            distanciaTotal = distanciaTotal + menor;
//            menor = Integer.MAX_VALUE;
//        }
//        double media = distanciaTotal / grafoEmpresas.numVertices();
        }
        System.out.println("\nMedia dos caminhos mais curtos: ");
        for (Map.Entry<ClienteProdutorEmpresa, Double> entry : medias.entrySet()) {
            System.out.println(entry.getKey().getDesignacao() + " -> " + entry.getValue());
        }
        return medias;
    }

    public void getNumEmpresasProximas(int n, Map<ClienteProdutorEmpresa, Double> medias) {

    }
}
