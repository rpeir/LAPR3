package pi.sem3.esinf.Controller;

import pi.sem3.esinf.domain.ClienteProdutorEmpresa;
import pi.sem3.esinf.graph.Graph;

public class App {

    private Graph<ClienteProdutorEmpresa, Integer> graph;

    public Graph<ClienteProdutorEmpresa, Integer> getGraph() {
        return graph;
    }

    public void setGraph(Graph<ClienteProdutorEmpresa, Integer> graph) {
        this.graph = graph;
    }

    private App() {
        bootstrap();
    }

    private void bootstrap() {

    }

    // Extracted from https://www.javaworld.com/article/2073352/core-java/core-java-simply-singleton.html?page=2
    private static App singleton = null;

    public static App getInstance() {
        if (singleton == null) {
            synchronized (App.class) {
                singleton = new App();
            }
        }
        return singleton;
    }

}
