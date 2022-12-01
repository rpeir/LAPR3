package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Distancia;
import domain.Localizacao;
import graph.Graph;
import graph.map.MapGraph;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

    public void getGrafoEmpresas(Graph<Localizacao, Integer> grafo) {
        Graph<ClienteProdutorEmpresa, Distancia> grafoEmpresas = new MapGraph<>(false);
        for (ClienteProdutorEmpresa e : getEmpresas()) {
            grafoEmpresas.addVertex(e);
            for(Map.Entry<String, ClienteProdutorEmpresa> cpe : app.getClienteProdutorEmpresaStore().getMapCPE().entrySet()) {
                if(!cpe.getValue().isEmpresa() && !cpe.getValue().isHub()) {
                    if(grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()) != null) {
                        Distancia add = new Distancia(e, cpe.getValue(), grafo.edge(e.getLocalizacao(), cpe.getValue().getLocalizacao()).getWeight());
                        grafoEmpresas.addEdge(e, cpe.getValue(), add);
                    }
                }
            }
        }
        System.out.println(grafoEmpresas);
   }
}

