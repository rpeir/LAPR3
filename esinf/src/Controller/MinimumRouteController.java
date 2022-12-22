package Controller;

import domain.Localizacao;
import graph.Graph;

public class MinimumRouteController {
    App app;

    public MinimumRouteController() {
        app = App.getInstance();
    }

    public void getMinimumRoute() {
        Graph<Localizacao, Integer> graph = app.getGraph();


    }
}
