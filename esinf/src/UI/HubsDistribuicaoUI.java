package UI;

import Controller.App;
import Controller.HubsDistribuicaoController;

import java.util.Scanner;

public class HubsDistribuicaoUI {

    App app;
    HubsDistribuicaoController ctrl = new HubsDistribuicaoController();

    public HubsDistribuicaoUI() {
        app = App.getInstance();
    }

    public void run() {

        int n;
        Scanner sc = new Scanner(System.in);
        System.out.println("Introduza o numero de hubs que pretende definir:");
        n = sc.nextInt();
        ctrl.getGrafoEmpresas(app.getGraph());
    }
}
