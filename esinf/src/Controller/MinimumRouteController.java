package Controller;

import domain.CaminhoMinimo;
import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;
import store.ClienteProdutorEmpresaStore;
import store.HubsStore;
import store.ListaExpedicoesStore;

import java.util.*;

public class MinimumRouteController {
    App app;
    ClosestHubController ctrl;
    HubsStore hubsStore;
    ClienteProdutorEmpresaStore cpeStore;
    ListaExpedicoesStore listaExpedicoesStore;

    public MinimumRouteController() {
        app = App.getInstance();
        ctrl = new ClosestHubController();
        hubsStore = app.getHubsStore();
        cpeStore = app.getClienteProdutorEmpresaStore();
        listaExpedicoesStore = app.getListaExpedicoesStore();
    }

    public List<Localizacao> getMinimumRoute(int dia) {
        // Produtor, Hub
        Map<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> map = new HashMap<>();
        // teste
        ClienteProdutorEmpresa produtor = cpeStore.getCPE("P3");
        ClienteProdutorEmpresa hub1 = cpeStore.getCPE("E1");
        ClienteProdutorEmpresa hub2 = cpeStore.getCPE("E2");
        ClienteProdutorEmpresa hub3 = cpeStore.getCPE("E3");
        ClienteProdutorEmpresa hub4 = cpeStore.getCPE("E4");
        ClienteProdutorEmpresa hub5 = cpeStore.getCPE("E5");
        ClienteProdutorEmpresa produtor2 = cpeStore.getCPE("P2");
        map.put(produtor, Arrays.asList(hub2, hub3, hub4));
        map.put(produtor2, Arrays.asList(hub2, hub3, hub5, hub1));
        //
        //map = listaExpedicoesStore.hubsASerVisitados(listaExpedicoesStore.getExpedicao(dia));
        // para cada produtor
        Graph<Localizacao, Integer> graph = app.getGraph();
        List<ClienteProdutorEmpresa> produtores = new ArrayList<>();
        List<Localizacao> totalPath = new ArrayList<>();
        for (Map.Entry<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> entry : map.entrySet()) {
            //  colocar produtores numa lista
            produtores.add(entry.getKey());
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        int distanciaTotal = 0;
        LinkedList<Localizacao> caminhoMinimoEntreProdutores = new LinkedList<>();
        //iterar sobre a lista de produtores
        Localizacao current = produtores.get(0).getLocalizacao();
        while (!produtores.isEmpty()) {
            int minDistance = Integer.MAX_VALUE;
            Localizacao nextProd = null;
            LinkedList<Localizacao> path = new LinkedList<>();
            for (int i = 0; i < produtores.size()-1; i++) {
                Localizacao next = produtores.get(i+1).getLocalizacao();
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
            }else {
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
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        for (Map.Entry<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> entry : map.entrySet()) {
            for (ClienteProdutorEmpresa hub : entry.getValue()) {
                if (!hubs.contains(hub)) {
                    hubs.add(hub);
                }
            }
        }
        int distanciaTotal2 = 0;
        LinkedList<Localizacao> caminhoMinimoEntreHubs = new LinkedList<>();
        //ultima posicao do caminho minimo entre produtores
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
            }else {
                // sair do loop quando todos os hubs ja foram visitados
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
        int d = distanciaTotal + distanciaTotal2;
        System.out.println("Distancia total: " + d);
        System.out.print("Caminho Total: ");
        for (Localizacao l : totalPath) {
            System.out.print(cpeStore.getCPEbyID(l.getLocID()) + " ");
        }
        return totalPath;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
