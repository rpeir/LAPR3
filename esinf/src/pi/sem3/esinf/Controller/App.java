package pi.sem3.esinf.Controller;

import pi.sem3.esinf.domain.ClienteProdutorEmpresa;
import pi.sem3.esinf.domain.Localizacao;
import pi.sem3.esinf.graph.Graph;
import pi.sem3.esinf.graph.map.MapGraph;
import pi.sem3.esinf.store.ClienteProdutorEmpresaStore;
import pi.sem3.esinf.store.LocalizacaoStore;
import pi.sem3.esinf.store.ProdutoStore;

public class App {

    private Graph<Localizacao, Integer> graph;
    private ProdutoStore produtoStore;
    private ClienteProdutorEmpresaStore cpeStore;
    private LocalizacaoStore localizacaoStore;


    public Graph<Localizacao, Integer> getGraph() {
        return graph;
    }

    public void setGraph(Graph<Localizacao, Integer> graph) {
        this.graph = graph;
    }

    private App() {
        bootstrap();
    }

    private void bootstrap() {
        graph = new MapGraph<>(false);
        produtoStore = new ProdutoStore();
        cpeStore = new ClienteProdutorEmpresaStore();
        localizacaoStore = new LocalizacaoStore();

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

    public ProdutoStore getProdutoStore() {
        return produtoStore;
    }
    public LocalizacaoStore getLocalizacaoStore() {
        return localizacaoStore;
    }
    public ClienteProdutorEmpresaStore getClienteProdutorEmpresaStore() {
        return cpeStore;
    }

}
