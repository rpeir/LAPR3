package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.CreateExpeditionList;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;
import store.ClienteProdutorEmpresaStore;
import store.HubsStore;

import java.util.*;

public class MinimumRouteController {
    App app;
    ClosestHubController ctrl;
    HubsStore hubsStore;
    ClienteProdutorEmpresaStore cpeStore;
    CreateExpeditionList createExpeditionList;


    public MinimumRouteController() {
        app = App.getInstance();
        ctrl = new ClosestHubController();
        hubsStore = app.getHubsStore();
        cpeStore = app.getClienteProdutorEmpresaStore();
        createExpeditionList = new CreateExpeditionList();
    }

    public List<Localizacao> getMinimumRoute(String produtorInicial, int dia) {
        Map<ClienteProdutorEmpresa, Cabaz> expeditionList = app.getListaExpedicoesStore().getExpedicaoNumDia(dia);
        Graph<Localizacao, Integer> graph = app.getGraph();
        List<ClienteProdutorEmpresa> produtores = new ArrayList<>();
        for(Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionList.entrySet()) {
            Cabaz cabaz = entry.getValue();
            Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtorProdutos = cabaz.getProdutorProdutos();
            for(Map.Entry<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> entry2 : produtorProdutos.entrySet()) {
                if(!produtores.contains(entry2.getKey())) {
                    produtores.add(entry2.getKey());
                }
            }
        }
        List<Localizacao> totalPath = new ArrayList<>();
        int distanciaTotal = 0;
        LinkedList<Localizacao> caminhoMinimoEntreProdutores = new LinkedList<>();
        Localizacao current = cpeStore.getCPE(produtorInicial).getLocalizacao();
        while (!produtores.isEmpty()) {
            int minDistance = Integer.MAX_VALUE;
            Localizacao nextProd = null;
            LinkedList<Localizacao> path = new LinkedList<>();
            for (int i = 0; i < produtores.size(); i++) {
                Localizacao next = produtores.get(i).getLocalizacao();
                LinkedList<Localizacao> shortPath = new LinkedList<>();
                Integer distance = Algorithms.shortestPath(graph, current, next, Integer::compare, Integer::sum, 0, shortPath);
                if (distance != null && distance < minDistance) {
                    minDistance = distance;
                    nextProd = next;
                    path = shortPath;
                }
            }
            if (nextProd != null) {
                distanciaTotal += minDistance;
                caminhoMinimoEntreProdutores.addAll(path);
                current = nextProd;
                produtores.remove(cpeStore.getCPEbyID(nextProd.getLocID()));
                produtores.removeIf(p -> caminhoMinimoEntreProdutores.contains(p.getLocalizacao()));
            } else {
                // sair do loop quando todos os hubs ja foram visitados
                break;
            }
        }
        int i = 1;
        while (i < caminhoMinimoEntreProdutores.size()) {
            if (caminhoMinimoEntreProdutores.get(i).equals(caminhoMinimoEntreProdutores.get(i - 1))) {
                caminhoMinimoEntreProdutores.remove(i);
            } else {
                i++;
            }
        }
        totalPath.addAll(caminhoMinimoEntreProdutores);
        List<ClienteProdutorEmpresa> hubs = new ArrayList<>();
        for(Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionList.entrySet()) {
            ClienteProdutorEmpresa hub = ctrl.getClosestHub(entry.getKey());
            if(!hubs.contains(hub)) {
                hubs.add(hub);
            }
        }
        List<String> aux = new ArrayList<>();
        System.out.println("Cabazes a entregar: ");
        for(ClienteProdutorEmpresa hub : hubs) {
            System.out.println("Hub: " + hub.getDesignacao() + " ");
            for(Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionList.entrySet()) {
                if(ctrl.getClosestHub(entry.getKey()).equals(hub)) {
                    if(!aux.contains(entry.getValue().getCliente())) {
                    System.out.println("Cabaz: " + entry.getValue());
                    aux.add(entry.getValue().getCliente());
                    }
                }
            }
        }
        int distanciaTotal2 = 0;
        LinkedList<Localizacao> caminhoMinimoEntreHubs = new LinkedList<>();
        Localizacao current2 = totalPath.get(totalPath.size() - 1);
        while (!hubs.isEmpty()) {
            int minDistance2 = Integer.MAX_VALUE;
            Localizacao nextHub = null;
            LinkedList<Localizacao> path = new LinkedList<>();
            for (int j = 0; j < hubs.size(); j++) {
                Localizacao next2 = hubs.get(j).getLocalizacao();
                LinkedList<Localizacao> shortPath = new LinkedList<>();
                Integer distance2 = Algorithms.shortestPath(graph, current2, next2, Integer::compare, Integer::sum, 0, shortPath);
                if (distance2 != null && distance2 < minDistance2) {
                    minDistance2 = distance2;
                    nextHub = next2;
                    path = shortPath;
                }
            }
            if (nextHub != null) {
                distanciaTotal2 += minDistance2;
                caminhoMinimoEntreHubs.addAll(path);
                current2 = nextHub;
                hubs.remove(cpeStore.getCPEbyID(nextHub.getLocID()));
                hubs.removeIf(h -> caminhoMinimoEntreHubs.contains(h.getLocalizacao()));
            } else {
                break;
            }
        }
        int j = 1;
        while (j < caminhoMinimoEntreHubs.size()) {
            if (caminhoMinimoEntreHubs.get(j).equals(caminhoMinimoEntreHubs.get(j - 1))) {
                caminhoMinimoEntreHubs.remove(j);
            } else {
                j++;
            }
        }
        totalPath.addAll(caminhoMinimoEntreHubs);
        int y = 1;
        while (y < totalPath.size()) {
            if (totalPath.get(y).equals(totalPath.get(y - 1))) {
                totalPath.remove(y);
            } else {
                y++;
            }
        }
        int x = totalPath.size();
        int d = distanciaTotal + distanciaTotal2;
        System.out.println("Distancia total: " + d);
        System.out.print("Caminho Total: ");
        for (Localizacao l : totalPath) {
            System.out.print(cpeStore.getCPEbyID(l.getLocID()) + " ");
        }
        System.out.println();
        for (int k = 0; k < totalPath.size(); k++) {
            if (k < x - 1) {
                System.out.println("Distancia entre " + cpeStore.getCPEbyID(totalPath.get(k).getLocID()) + " e "
                        + cpeStore.getCPEbyID(totalPath.get(k + 1).getLocID()) + ": "
                        + graph.edge(totalPath.get(k), totalPath.get(k + 1)).getWeight());
            }
        }
        System.out.println();

        return totalPath;
    }
}
