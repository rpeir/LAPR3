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

    public List<CaminhoMinimo> getMinimumRoute(int dia) {
        List<CaminhoMinimo> caminhos = new ArrayList<>();

        // Produtor, Hub
        Map<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> map = new HashMap<>();
        // teste
        ClienteProdutorEmpresa produtor = cpeStore.getCPE("P3");
        ClienteProdutorEmpresa hub2 = cpeStore.getCPE("E2");
        ClienteProdutorEmpresa hub3 = cpeStore.getCPE("E3");
        ClienteProdutorEmpresa hub4 = cpeStore.getCPE("E4");
        ClienteProdutorEmpresa hub5 = cpeStore.getCPE("E5");
        map.put(produtor, Arrays.asList(hub2, hub3, hub4));
        //
        //map = listaExpedicoesStore.hubsASerVisitados(listaExpedicoesStore.getExpedicao(dia));
        // print info
        for (Map.Entry<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> entry : map.entrySet()) {
            System.out.println(entry.getKey().getId() + " -> Hubs por onde tem de passar: " + entry.getValue());
        }
        // para cada produtor
        Graph<Localizacao, Integer> graph = app.getGraph();
        for (Map.Entry<ClienteProdutorEmpresa, List<ClienteProdutorEmpresa>> entry : map.entrySet()) {
            //para cada produtor
            ClienteProdutorEmpresa producer = entry.getKey();
            // criar um grafo com os hubs do produtor
            List<ClienteProdutorEmpresa> hubs = new ArrayList<>(entry.getValue());
            // criar um caminho minimo entre nodes
            LinkedList<Localizacao> caminhoMinimo = new LinkedList<>();
            // para cada produtor, criar uma lista de hubs ja visitados
            List<ClienteProdutorEmpresa> hubsAlreadyVisited = new ArrayList<>();
            // comecar com o produtor
            Localizacao currentLocation = producer.getLocalizacao();
            // contem o caminho final para este produtor
            List<Localizacao> totalPath = new ArrayList<>();
            int distanciaTotal = 0;
            // enquanto nao tiver visitado todos os hubs
            while (!hubs.isEmpty()) {
                // encontrar o menor dos menores caminhos desde o current location ate aos hubs
                ClienteProdutorEmpresa nextHub = null;
                int minDistance = Integer.MAX_VALUE;
                for (ClienteProdutorEmpresa hub : hubs) {
                    if (!hubsAlreadyVisited.contains(hub)) {
                        // short caminhoMinimo desde o current location ate ao hub
                        LinkedList<Localizacao> shortPath = new LinkedList<>();
                        Integer distance = Algorithms.shortestPath(graph, currentLocation, hub.getLocalizacao(), Integer::compare, Integer::sum, 0, shortPath);
                        if (distance != null && distance < minDistance) {
                            nextHub = hub;
                            minDistance = distance;
                            caminhoMinimo = shortPath;
                        }
                    }
                }
                if (nextHub != null) {
                    // atualizar o current location e o hub visitado
                    currentLocation = nextHub.getLocalizacao();
                    hubsAlreadyVisited.add(nextHub);
                    hubs.remove(nextHub);
                    // adicionar o caminho minimo encontrado a lista de caminhos
                    totalPath.addAll(caminhoMinimo);
                    distanciaTotal += minDistance;
                } else {
                    // sair do loop quando todos os hubs ja foram visitados
                    break;
                }
            }
            // remover os duplicados adjacentes
            int i = 1;
            while (i < totalPath.size()) {
                if (totalPath.get(i).equals(totalPath.get(i - 1))) {
                    totalPath.remove(i);
                } else {
                    i++;
                }
            }
            List<Integer> distances = new ArrayList<>();
            CaminhoMinimo caminhoMinimoFinal = new CaminhoMinimo(cpeStore.getCPE(producer.getId()), totalPath, distanciaTotal, distances);
            System.out.println("Distancia total: " + distanciaTotal);
            System.out.println("Caminho minimo para o produtor " + producer.getId());
            for (int j = 0; j < totalPath.size() - 1; j++) {
                Localizacao current = totalPath.get(j);
                Localizacao nextLocation = totalPath.get(j + 1);
                distances.add(graph.edge(current, nextLocation).getWeight());
                System.out.println(cpeStore.getCPEbyID(current.getLocID()) + " -> " + cpeStore.getCPEbyID(nextLocation.getLocID()) +
                        "Distancia : " + graph.edge(current, nextLocation).getWeight());
            }
            caminhoMinimoFinal.setDistancias(distances);
            caminhos.add(caminhoMinimoFinal);
        }
        return caminhos;
    }
}
