package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.ListaExpedicoes;
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

    public MinimumRouteController() {
        app = App.getInstance();
        ctrl = new ClosestHubController();
        hubsStore = app.getHubsStore();
        cpeStore = app.getClienteProdutorEmpresaStore();
    }

    public void getMinimumRoute(int dia) {
        // lista de expedicao para o dia pretendido
        ListaExpedicoes expedicao = app.getListaExpedicoesStore().getExpedicao(dia);
        // lista de cabazes para o dia pretendido
        List<Cabaz> cabazes = expedicao.get_listaExpedicoes();
        System.out.println("Cabazes para o dia " + dia + ":\n");
        for (Cabaz cabaz : cabazes) {
            System.out.println(cabaz.getCliente() + " -> " + cabaz.getProdutos());
        }
        // lista dos clientes para o dia pretendido
        List<ClienteProdutorEmpresa> clientes = new ArrayList<>();
        for (Cabaz cabaz : cabazes) {
                if(cpeStore.containsCPE(cabaz.getCliente())) {
                    clientes.add(cpeStore.getCPE(cabaz.getCliente()));
                }
        }
        System.out.println("Clientes para o dia " + dia + ":\n");
        System.out.println(Arrays.toString(clientes.toArray()));
        // lista com o hub mais proximo de cada cliente
        List<ClienteProdutorEmpresa> hubsCliente = new ArrayList<>();
        for (ClienteProdutorEmpresa cliente : clientes) {
            hubsCliente.add(ctrl.getClosestHub(cliente));
        }
        System.out.println("Hubs mais proximos dos clientes para o dia " + dia + ":\n");
        System.out.println(Arrays.toString(hubsCliente.toArray()));

        // grafo geral
        Graph<Localizacao, Integer> grafo = app.getGraph();
        // numero de clientes e hubs
        int n = clientes.size();

    }
}

