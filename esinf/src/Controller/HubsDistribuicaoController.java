package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;

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

    public Map<ClienteProdutorEmpresa, Double> getMediaDistancia(Graph<Localizacao, Integer> grafo, int n) {
        if(n > getEmpresas().size()) System.out.println("O numero de hubs nao pode ser menor que o numero de empresas");
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
            return sorted;
        }
        return null;
    }
}

