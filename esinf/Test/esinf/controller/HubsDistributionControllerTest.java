package esinf.controller;

import Controller.App;
import Controller.HubsDistributionController;
import Controller.ReadCSVController;
import domain.ClienteProdutorEmpresa;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class HubsDistributionControllerTest {

    // class to test HubsDistribuicaoController
    private HubsDistributionController controller;
    private ReadCSVController readCSVController;
    App app = new App();

    public HubsDistributionControllerTest() {
        controller = new HubsDistributionController();
        readCSVController = new ReadCSVController();
        app = App.getInstance();
    }

    @BeforeEach
    public void setUp() throws IOException {

        String smallCpe = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
        String smallDis = "esinf/grafos/grafos/Small/distancias_small.csv";

        File file1 = new File(smallCpe);
        readCSVController.readClientesProdutoresFile(file1);
        File file2 = new File(smallDis);
        readCSVController.readDistancesFile(file2);
    }

    @Test
    public void testGetEmpresas() {


        List<ClienteProdutorEmpresa> listaEmpresasActual = controller.getEmpresas();
        List<ClienteProdutorEmpresa> listaEmpresasExpected = new ArrayList<>();

        ClienteProdutorEmpresa cpe1 = new ClienteProdutorEmpresa("CT14", (float)38.5243, (float)-8.8926, "E1");
        ClienteProdutorEmpresa cpe2 = new ClienteProdutorEmpresa("CT11", (float)39.3167, (float)-7.4167, "E2");
        ClienteProdutorEmpresa cpe3 = new ClienteProdutorEmpresa("CT5", (float)39.823, (float)-7.4931, "E3");
        ClienteProdutorEmpresa cpe4 = new ClienteProdutorEmpresa("CT9", (float)40.5364, (float)-7.2683, "E4");
        ClienteProdutorEmpresa cpe5 = new ClienteProdutorEmpresa("CT4", (float)41.8, (float)-6.75, "E5");

        listaEmpresasExpected.add(cpe1);
        listaEmpresasExpected.add(cpe2);
        listaEmpresasExpected.add(cpe3);
        listaEmpresasExpected.add(cpe4);
        listaEmpresasExpected.add(cpe5);

        assertEquals(listaEmpresasExpected, listaEmpresasActual);

    }

    @Test
    public void testGetMediaDistancia() throws IOException {

        Map<ClienteProdutorEmpresa, Double> mapActual = controller.getMediaDistancia(app.getGraph(), 3);
        Map<ClienteProdutorEmpresa, Double> mapExpected = new HashMap<>();

        ClienteProdutorEmpresa cpe2 = new ClienteProdutorEmpresa("CT11", (float)39.3167, (float)-7.4167, "E2");
        ClienteProdutorEmpresa cpe3 = new ClienteProdutorEmpresa("CT5", (float)39.823, (float)-7.4931, "E3");
        ClienteProdutorEmpresa cpe4 = new ClienteProdutorEmpresa("CT9", (float)40.5364, (float)-7.2683, "E4");

        Double d2 = 216120.0;
        Double d3 = 199366.9375;
        Double d4 = 211525.6875;

        mapExpected.put(cpe3, d3);
        mapExpected.put(cpe4, d4);
        mapExpected.put(cpe2, d2);

        assertEquals(mapExpected, mapActual);

    }

}
