package esinf.controller;

import Controller.*;
import domain.CreateExpeditionList;
import domain.Localizacao;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class MinimumRouteControllerTest {

    private final MinimumRouteController controller;
    private final ReadCSVController readCSVController;
    CreateExpeditionList createExpeditionList;
    HubsDistributionController hubsDistributionController;
    ClosestHubController closestHubController;
    App app = new App();

    public MinimumRouteControllerTest() {
        controller = new MinimumRouteController();
        readCSVController = new ReadCSVController();
        createExpeditionList = new CreateExpeditionList();
        hubsDistributionController = new HubsDistributionController();
        closestHubController = new ClosestHubController();
        app = App.getInstance();
    }

    @BeforeEach
    public void setUp() throws IOException {

        String smallCpe = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
        String smallDis = "esinf/grafos/grafos/Small/distancias_small.csv";
        String smallCabazes = "esinf/grafos/grafos/Small/cabazes_small.csv";

        File file1 = new File(smallCpe);
        readCSVController.readClientesProdutoresFile(file1);
        File file2 = new File(smallDis);
        readCSVController.readDistancesFile(file2);
        File file3 = new File(smallCabazes);
        readCSVController.readCabazesFile(file3);
    }

    @Test
    public void testGetMinimumRouteP1() {
        hubsDistributionController.getMediaDistancia(app.getGraph(), 3);
        closestHubController.getAllClosestHubs();
        createExpeditionList.createExpeditionList(1, 3);
        List<Localizacao> listaLocalizacoesActual = controller.getMinimumRoute("P1", 1);
        List<Localizacao> listaLocalizacoesExpected = new LinkedList<>();

        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P1").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P2").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E2").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E4").getLocalizacao());

        assertEquals(listaLocalizacoesExpected, listaLocalizacoesActual);

    }

    @Test
    public void testGetMinimumRouteP2() {
        hubsDistributionController.getMediaDistancia(app.getGraph(), 3);
        closestHubController.getAllClosestHubs();
        createExpeditionList.createExpeditionList(1, 3);
        List<Localizacao> listaLocalizacoesActual = controller.getMinimumRoute("P2", 1);
        List<Localizacao> listaLocalizacoesExpected = new LinkedList<>();

        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P2").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P2").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P1").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E4").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E2").getLocalizacao());

        assertEquals(listaLocalizacoesExpected, listaLocalizacoesActual);
    }

    @Test
    public void testGetMinimumRouteP3() {
        hubsDistributionController.getMediaDistancia(app.getGraph(), 3);
        closestHubController.getAllClosestHubs();
        createExpeditionList.createExpeditionList(1, 3);
        List<Localizacao> listaLocalizacoesActual = controller.getMinimumRoute("P3", 1);
        List<Localizacao> listaLocalizacoesExpected = new LinkedList<>();

        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P2").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("P1").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E4").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E3").getLocalizacao());
        listaLocalizacoesExpected.add(app.getClienteProdutorEmpresaStore().getCPE("E2").getLocalizacao());

        assertEquals(listaLocalizacoesExpected, listaLocalizacoesActual);
    }

}
