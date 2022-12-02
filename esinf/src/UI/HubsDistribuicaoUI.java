package UI;

import Controller.App;
import Controller.HubsDistribuicaoController;
import domain.ClienteProdutorEmpresa;
import domain.Distancia;
import graph.Graph;

import java.util.Map;
import java.util.Scanner;

public class HubsDistribuicaoUI {

    App app;
    HubsDistribuicaoController ctrl = new HubsDistribuicaoController();

    public HubsDistribuicaoUI() {
        app = App.getInstance();
    }

    public void run() {

        Graph<ClienteProdutorEmpresa, Distancia> grafoEmpresas = ctrl.getGrafoEmpresas(app.getGraph());

        int n;
        Scanner sc = new Scanner(System.in);
        System.out.println("\nIntroduza o numero de hubs que pretende definir: ");
        n = sc.nextInt();
        System.out.println("\nHubs mais proximos: ");
        ctrl.getMediaDistancia(grafoEmpresas, app.getGraph(), n);

    }
}
