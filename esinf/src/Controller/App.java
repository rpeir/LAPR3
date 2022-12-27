package Controller;

import domain.Localizacao;
import domain.WaterController.WaterController;
import graph.Graph;
import graph.map.MapGraph;
import store.ClienteProdutorEmpresaStore;
import store.HubsStore;
import store.ListaExpedicoesStore;
import store.LocalizacaoStore;
import store.WaterController.SectorStore;

public class App {

    private Graph<Localizacao, Integer> graph;
    private ClienteProdutorEmpresaStore cpeStore;
    private LocalizacaoStore localizacaoStore;

    private ListaExpedicoesStore leStore;

    private WaterController waterController;
    private SectorStore sectorStore;
    private HubsStore hubsStore;

    public SectorStore getSectorStore() {
        return sectorStore;
    }

    public WaterController getWaterController() {
        return waterController;
    }

    public Graph<Localizacao, Integer> getGraph() {
        return graph;
    }

    public void setGraph(Graph<Localizacao, Integer> graph) {
        this.graph = graph;
    }

    public App() {
        bootstrap();
    }

    private void bootstrap() {
        graph = new MapGraph<>(false);
        cpeStore = new ClienteProdutorEmpresaStore();
        localizacaoStore = new LocalizacaoStore();
        waterController = new WaterController();
        sectorStore = new SectorStore();
        leStore = new ListaExpedicoesStore();
        hubsStore = new HubsStore();

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


    public LocalizacaoStore getLocalizacaoStore() {
        return localizacaoStore;
    }
    public ClienteProdutorEmpresaStore getClienteProdutorEmpresaStore() {
        return cpeStore;
    }

    public ListaExpedicoesStore getListaExpedicoesStore() {
        return leStore;
    }

    public HubsStore getHubsStore() {
        return hubsStore;
    }
}
