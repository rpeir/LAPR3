package esinf.controller;

import Controller.*;
import domain.ClienteProdutorEmpresa;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.io.IOException;

class ExpListStatsControllerTest {

    private ExpListStatsController instance;
    private final String pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
    private final String pathDsmall = "esinf/grafos/grafos/Small/distancias_small.csv";
    private final String pathCsmall = "esinf/grafos/grafos/Small/cabazes_small.csv";

    public ExpListStatsControllerTest() {
        setUp();
    }
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
    public void numberOfCabazesTotallyDelivered() {
        ClienteProdutorEmpresa produtor = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        Assertions.assertEquals((Integer) 0, instance.numberOfCabazesTotallyDelivered(produtor, 1));
    }

    @Test
    public void numberOfCabazesPartiallyDelivered() {
        ClienteProdutorEmpresa produtor = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        Assertions.assertEquals((Integer) 6, instance.numberOfCabazesPartiallyDelivered(produtor, 1));
    }

    @Test
    public void numberOfDistinctClientesDelivered() {
        ClienteProdutorEmpresa produtor = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        Assertions.assertEquals((Integer) 6, instance.numberOfDistinctClientesDelivered(produtor, 1));
    }

    @Test
    public void numberOfProductsOutOfStock() {
        ClienteProdutorEmpresa produtor = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        Assertions.assertEquals((Integer) 10, instance.numberOfProductsOutOfStock(produtor, 1));
    }

    @Test
    public void numberOfHubsSatisfiedByProducer() {
        ClienteProdutorEmpresa produtor = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        Assertions.assertEquals((Integer) 3, instance.numberOfHubsSatisfiedByProducer(produtor, 1));
    }

    @Test
    public void numberOfDistinctClientesByHub() {
        ClienteProdutorEmpresa hub = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E2");
        Assertions.assertEquals((Integer) 2, instance.numberOfDistinctClientesByHub(hub, 1));
    }

    @Test
    public void numberOfProdutoresByHub() {
        ClienteProdutorEmpresa hub = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E2");
        Assertions.assertEquals((Integer) 3, instance.numberOfProdutoresByHub(hub, 1));
    }
}