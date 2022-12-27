package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;
import store.HubsStore;

import java.util.*;

public class HubsDistributionController {

    App app;
    HubsStore hubsStore;

    public HubsDistributionController() {
        app = App.getInstance();
        hubsStore = app.getHubsStore();
    }


    /**
     * It returns a list of all the companies
     *
     * @return A list of ClienteProdutorEmpresa objects.
     */
    public List<ClienteProdutorEmpresa> getEmpresas() {
        Map<String, ClienteProdutorEmpresa> mapCPE = app.getClienteProdutorEmpresaStore().getMapCPE();
        List<ClienteProdutorEmpresa> listaEmpresas = new ArrayList<>();
        for (Map.Entry<String, ClienteProdutorEmpresa> entry : mapCPE.entrySet()) {
            if (entry.getValue().isEmpresa()) {
                entry.getValue().setNotHub();
                listaEmpresas.add(entry.getValue());
            }
        }
        return listaEmpresas;
        // 5 empresas - small
    }

    /**
     * It calculates the average distance between each client/producer and the hubs, and returns a map with the hubs and
     * their average distance
     *
     * @param grafo the graph we want to use
     * @param n number of hubs to be selected
     * @return A map with the distance between each client/producer and the hubs.
     */
    public Map<ClienteProdutorEmpresa, Double> getMediaDistancia(Graph<Localizacao, Integer> grafo, int n) {
        if(n > getEmpresas().size() || n < 1) System.out.println("O numero de hubs inserido e invalido");
        else {
        Map<ClienteProdutorEmpresa, Double> medias = new HashMap<>();
        List<ClienteProdutorEmpresa> listaEmpresas = getEmpresas();
        ArrayList<LinkedList<Localizacao>> listaCaminhos = new ArrayList<>();
        for (ClienteProdutorEmpresa e : listaEmpresas) {
            ArrayList<Integer> distancias = new ArrayList<>();
            Double soma = (double) 0;
            Double numeroCPE = (double) 0;
            Algorithms.shortestPaths(grafo,
                    e.getLocalizacao(),
                    Integer::compare,
                    Integer::sum,
                    0,
                    listaCaminhos,
                    distancias);

            for (Integer value : distancias) {
                if (value != 0) {
                    soma += value;
                    numeroCPE++;
                }
            }
            if(numeroCPE != 0) {
                double m = soma / numeroCPE;
                medias.put(e, m);
            }

        }

        System.out.println("\nAs n empresas mais proximas de cada cliente/produtora sao, em media:");
        // ordenar mapa por valor
        Map<ClienteProdutorEmpresa, Double> sorted = new LinkedHashMap<>();
        Map<ClienteProdutorEmpresa, Double> nHubs = new LinkedHashMap<>();
        medias.entrySet()
                .stream()
                .sorted(Map.Entry.comparingByValue())
                .forEachOrdered(x -> sorted.put(x.getKey(), x.getValue()));
        // imprimir os n primeiros elementos do mapa ordenado
        int i = 0;
        for (Map.Entry<ClienteProdutorEmpresa, Double> entry : sorted.entrySet()) {
            if (i < n) {
                entry.getKey().setHub();
                nHubs.put(entry.getKey(), entry.getValue());
                System.out.println(entry.getKey().getDesignacao() + " -> " + entry.getValue());
                i++;
                }
            }
            hubsStore.setHubs(nHubs);
            return nHubs;
        }
        return null;
    }
}

