package esinf.controller;

import Controller.*;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

import domain.Pedido;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import stats.ListStatistics;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class ExpListStatsControllerTest {

    private ExpListStatsController instance;
    private final String pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
    private final String pathDsmall = "esinf/grafos/grafos/Small/distancias_small.csv";
    private final String pathCsmall = "esinf/grafos/grafos/Small/cabazes_small.csv";

    public ExpListStatsControllerTest() {
    }

    @BeforeEach
    void setUp() {
        App app = App.getInstance();
        ReadCSVController readCSVController = new ReadCSVController();
        try {
            readCSVController.readClientesProdutoresFile(new File(pathCPsmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste clientes-produtores_small.csv");
        }
        try {
            readCSVController.readDistancesFile(new File(pathDsmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste distancias_small.csv");
        }
        try {
            readCSVController.readCabazesFile(new File(pathCsmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste cabazes_small.csv");
        }
        //define hubs
        HubsDistributionController hubsDistributionController = new HubsDistributionController();
        hubsDistributionController.getMediaDistancia(app.getGraph(), 3);
        //define closest hubs
        ClosestHubController closestHubController = new ClosestHubController();
        closestHubController.getAllClosestHubs();
        //create expedition list for day 1 and day 2 with 3 producers delivering to the hubs
        CreateExpeditionListController createExpeditionListController = new CreateExpeditionListController();
        createExpeditionListController.createExpeditionList(1,3);
        createExpeditionListController.createExpeditionList(2,3);
        //create instance of ExpListStatsController
        instance = new ExpListStatsController();
    }
    @Test
    void testGetStatsByCliente() {
        System.out.println("getStatsByCliente");
        //for (ListStatistics line : instance.getStatsByCliente(1)) {
        //    System.out.println(line.toStringDetailed());
        //}
    }

    @Test
    void testGetStatsByCabaz() {
        System.out.println("getStatsByCliente");
        //for (ListStatistics line : instance.getStatsByCabaz(1)) {
        //    System.out.println(line.toStringDetailed());
        //}
    }

    @Test
    void testGetStatsByProdutor() {
    }

    @Test
    void testGetStatsByHub() {
    }

    @org.junit.Test
    public void numberOfCabazesTotallyDelivered() {
    }

    @org.junit.Test
    public void numberOfCabazesPartiallyDelivered() {
    }

    @org.junit.Test
    public void numberOfDistinctClientesDelivered() {
    }

    @org.junit.Test
    public void numberOfProductsOutOfStock() {
    }

    @org.junit.Test
    public void numberOfHubsSatisfiedByProducer() {
    }

    @org.junit.Test
    public void numberOfDistinctClientesByHub() {
    }

    @org.junit.Test
    public void numberOfProdutoresByHub() {
    }
}