package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import domain.WaterController.WaterController;
import graph.Graph;
import graph.map.MapGraph;
import store.*;
import store.WaterController.SectorStore;

import java.util.AbstractMap;
import java.util.List;
import java.util.Map;

public class App {

    private Graph<Localizacao, Integer> graph;
    private ClienteProdutorEmpresaStore cpeStore;
    private LocalizacaoStore localizacaoStore;

    private ListaExpedicoesStore leStore;

    private WaterController waterController;
    private SectorStore sectorStore;
    private HubsStore hubsStore;

    private PedidosStore pedidosStore;

    private Stock stock;

    private Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> expeditionList;

    public Stock getStock() {
        return stock;
    }

    public Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> getExpeditionList() {
        return expeditionList;
    }

    public PedidosStore getPedidosStore() {
        return pedidosStore;
    }

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

    public void setExpeditionList(Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> expeditionList) {
        this.expeditionList = expeditionList;
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
        pedidosStore = new PedidosStore();
        stock = new Stock();

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
