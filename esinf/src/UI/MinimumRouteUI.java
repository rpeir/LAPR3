package UI;

import Controller.App;
import Controller.MinimumRouteController;
import domain.ClienteProdutorEmpresa;
import domain.CreateExpeditionList;

public class MinimumRouteUI {
    App app;
    MinimumRouteController ctrl;
    CreateExpeditionList createExpeditionList;


    public MinimumRouteUI() {
        app = App.getInstance();
        ctrl = new MinimumRouteController();
    }

    public void run() {
        ctrl.getMinimumRoute();
    }
}
