package esinf.controller;

import Controller.App;
import Controller.ClosestHubController;
import Controller.HubsDistributionController;
import Controller.ReadCSVController;
import domain.ClienteProdutorEmpresa;
import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ClosestHubControllerTest {

    private final String pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
    private final String pathDsmall = "esinf/grafos/grafos/Small/distancias_small.csv";
    private final ClosestHubController ctrl = new ClosestHubController();

    public void setUp() {
        ReadCSVController readCSVController = new ReadCSVController();
        try {
            readCSVController.readClientesProdutoresFile(new File(pathCPsmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste clientes-produtores_big.csv");
        }
        try {
            readCSVController.readDistancesFile(new File(pathDsmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste distancias_big.csv");
        }
        HubsDistributionController ctrl1 = new HubsDistributionController();
        ctrl1.getMediaDistancia(App.getInstance().getGraph(), 3);
    }

    @Test
    public void getClosestHub() {
        setUp();
        Map<ClienteProdutorEmpresa,ClienteProdutorEmpresa> result = ctrl.getAllClosestHubs();
        ClienteProdutorEmpresa cliente = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C4");
        ClienteProdutorEmpresa hub = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E4");
        ClienteProdutorEmpresa cliente1 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C2");
        ClienteProdutorEmpresa hub1 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E2");
        assertEquals(hub,ctrl.getClosestHub(cliente));
        assertEquals(hub1,ctrl.getClosestHub(cliente1));
    }

    @Test
    public void getAllClosestHubs() {
        setUp();
        HashMap<String, String> closestHubsExpected =new HashMap<>();
        closestHubsExpected.put("C4", "E4");
        closestHubsExpected.put("C5", "E4");
        closestHubsExpected.put("C6", "E4");
        closestHubsExpected.put("C7", "E2");
        closestHubsExpected.put("C8", "E2");
        closestHubsExpected.put("C9", "E2");
        closestHubsExpected.put("C1", "E4");
        closestHubsExpected.put("C2", "E2");
        closestHubsExpected.put("C3", "E4");
        HashMap<String, String> closestHubsReal = new HashMap<>();
        for (Map.Entry<ClienteProdutorEmpresa,ClienteProdutorEmpresa> entry : ctrl.getAllClosestHubs().entrySet()){
            closestHubsReal.put(entry.getKey().getDesignacao(),entry.getValue().getDesignacao());
        }
        assertEquals(closestHubsExpected,closestHubsReal);
    }
}