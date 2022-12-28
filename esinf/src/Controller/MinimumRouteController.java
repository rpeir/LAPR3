package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.ListaExpedicoes;
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

    public void getMinimumRoute(int dia) {

    }
}

