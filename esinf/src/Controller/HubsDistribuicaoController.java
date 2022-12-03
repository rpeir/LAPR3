package Controller;

import domain.ClienteProdutorEmpresa;
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

    public void getMediaDistancia(Graph<Localizacao, Integer> grafo, int n) {
        Graph<ClienteProdutorEmpresa, Integer> grafoEmpresas2 = new MapGraph<>(false);
        Map<ClienteProdutorEmpresa, Double> medias = new HashMap<>();
        double media;
        for (ClienteProdutorEmpresa e : getEmpresas()) {
            grafoEmpresas2.addVertex(e);
            for (Map.Entry<String, ClienteProdutorEmpresa> cpe : app.getClienteProdutorEmpresaStore().getMapCPE().entrySet()) {
                if (!cpe.getValue().getId().contains("E")) {
                    if (grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()) != null) {
                        grafoEmpresas2.addEdge(e, cpe.getValue(), grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()).getWeight());
                    }
                }
            }
        }
        System.out.println(grafoEmpresas2);

        LinkedList<ClienteProdutorEmpresa> caminho = new LinkedList<>();
        for(ClienteProdutorEmpresa cpe1 : grafoEmpresas2.vertices()){
            if(cpe1.getDesignacao().contains("E")) {

                Double soma = (double)0;
                Double numeroCPE = (double)0;

                for (ClienteProdutorEmpresa cpe2 : grafoEmpresas2.vertices()) {
                    if (!(cpe2.getDesignacao().contains("E"))) {

                        if (Algorithms.shortestPath(grafoEmpresas2, cpe1, cpe2, Integer::compare, Integer::sum, 0, caminho) != null) {
                            soma += Algorithms.shortestPath(
                                    grafoEmpresas2,
                                    cpe1,
                                    cpe2,
                                    Integer::compare,
                                    Integer::sum,
                                    0,
                                    caminho
                            );


                            numeroCPE++;
                        }

                    }
                }

                if (numeroCPE != 0) {
                    media = soma / numeroCPE;
                    medias.put(cpe1, media);
                }
            }
        }

        System.out.println("\nMedia dos caminhos mais curtos: ");
        for (Map.Entry<ClienteProdutorEmpresa, Double> entry : medias.entrySet()) {
            System.out.println(entry.getKey().getDesignacao() + " -> " + entry.getValue());
        }

        System.out.println("\nAs n empresas mais proximas de cada cliente/produtora sao, em media: ");
        // ordenar mapa por valor
        Map<ClienteProdutorEmpresa, Double> sorted = new LinkedHashMap<>();
        medias.entrySet()
                .stream()
                .sorted(Map.Entry.comparingByValue())
                .forEachOrdered(x -> sorted.put(x.getKey(), x.getValue()));
        // imprimir os n primeiros elementos do mapa ordenado
        int i = 0;
        for (Map.Entry<ClienteProdutorEmpresa, Double> entry : sorted.entrySet()) {
            if (i < n) {
                entry.getKey().setHub();
                System.out.println(entry.getKey().getDesignacao() + " -> " + entry.getValue());
                i++;
            }
        }
    }
}
