package esinf.domain;

import Controller.App;
import Controller.HubsDistributionController;
import Controller.ReadCSVController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.CreateExpeditionList;
import domain.Pedido;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import store.PedidosStore;
import store.Stock;

import java.io.File;
import java.io.IOException;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class CreateExpeditionListTest {

    private HubsDistributionController hubsDistributionController = new HubsDistributionController();
    private CreateExpeditionList createExpeditionList = new CreateExpeditionList();
    private final String pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
    private final String pathDsmall = "esinf/grafos/grafos/Small/distancias_small.csv";

    private final String pathCabazesSmall = "esinf/grafos/grafos/Small/cabazes_small.csv";

    @BeforeEach
    public void setUp() {
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
            readCSVController.readCabazesFile(new File(pathCabazesSmall));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste cabazes_small.csv");
        }
        hubsDistributionController.getMediaDistancia(App.getInstance().getGraph(), 3);
    }

    @Test
    void getNProdutores() {
        ClienteProdutorEmpresa C1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("C1");
        ClienteProdutorEmpresa P1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        ClienteProdutorEmpresa P2 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P2");
        ClienteProdutorEmpresa P3 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P3");
        List<ClienteProdutorEmpresa> expected = new ArrayList<>();
        List<ClienteProdutorEmpresa> result = createExpeditionList.getNProdutores(C1,3);
        expected.add(P1);
        expected.add(P2);
        expected.add(P3);
        assertEquals(expected,result);
    }

    @Test
    void validStock() {
        ClienteProdutorEmpresa C1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("C1");
        Stock stock = App.getInstance().getStock();
        List<Pedido> listaStock = stock.getStockMap().get(2);
        List<ClienteProdutorEmpresa> closestProdutores = createExpeditionList.getNProdutores(C1,3);
        List<Pedido> expected = new ArrayList<>();
        List<Pedido> result = createExpeditionList.validStock(listaStock,closestProdutores);
        expected.add(App.getInstance().getStock().getStockByProdutor(2,"P1"));
        expected.add(App.getInstance().getStock().getStockByProdutor(2,"P2"));
        expected.add(App.getInstance().getStock().getStockByProdutor(2,"P3"));
        assertEquals(expected,result);
    }
    @Test
    void createExpeditionListTest() {
        Map<ClienteProdutorEmpresa, Cabaz> result = createExpeditionList.createExpeditionList(2, 3);
        Set<ClienteProdutorEmpresa> expectedClientesKeySet = new HashSet<>();
        ClienteProdutorEmpresa C4 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C4");
        ClienteProdutorEmpresa C7 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C7");
        ClienteProdutorEmpresa C9 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C9");
        ClienteProdutorEmpresa E1 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E1");
        ClienteProdutorEmpresa C1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("C1");
        ClienteProdutorEmpresa C2 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C2");
        ClienteProdutorEmpresa C3 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C3");
        ClienteProdutorEmpresa P1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        ClienteProdutorEmpresa P2 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P2");
        ClienteProdutorEmpresa P3 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P3");
        expectedClientesKeySet.add(C4);
        expectedClientesKeySet.add(C7);
        expectedClientesKeySet.add(C9);
        expectedClientesKeySet.add(E1);
        expectedClientesKeySet.add(C1);
        expectedClientesKeySet.add(C2);
        expectedClientesKeySet.add(C3);
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC4 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC7 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC9 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetE1 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC1 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC2 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC3 = new HashSet<>();
        expectedProdutoresKeySetC4.add(P2);
        expectedProdutoresKeySetC4.add(P3);
        expectedProdutoresKeySetC7.add(P1);
        expectedProdutoresKeySetC7.add(P2);
        expectedProdutoresKeySetC7.add(P3);
        expectedProdutoresKeySetC9.add(P2);
        expectedProdutoresKeySetC9.add(P3);
        expectedProdutoresKeySetE1.add(P3);
        expectedProdutoresKeySetC1.add(P1);
        expectedProdutoresKeySetC1.add(P2);
        expectedProdutoresKeySetC1.add(P3);
        expectedProdutoresKeySetC2.add(P1);
        expectedProdutoresKeySetC2.add(P2);
        expectedProdutoresKeySetC2.add(P3);
        expectedProdutoresKeySetC3.add(P2);
        expectedProdutoresKeySetC3.add(P3);
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC4P2 = new ArrayList<>();
            expectedProdutosC4P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC4P3 = new ArrayList<>();
            expectedProdutosC4P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 2));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P1 = new ArrayList<>();
            expectedProdutosC7P1.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 4));
            expectedProdutosC7P1.add(new AbstractMap.SimpleEntry<>("Produto8: ",(float) 1));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P2 = new ArrayList<>();
            expectedProdutosC7P2.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 3));
            expectedProdutosC7P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 1.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P3 = new ArrayList<>();
            expectedProdutosC7P3.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 3.5));
            expectedProdutosC7P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 1.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC9P2 = new ArrayList<>();
            expectedProdutosC9P2.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 4.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC9P3 = new ArrayList<>();
            expectedProdutosC9P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 0.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosE1P3 = new ArrayList<>();
            expectedProdutosE1P3.add(new AbstractMap.SimpleEntry<>("Produto4: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P1 = new ArrayList<>();
            expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 3));
            expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 4));
            expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto8: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P2 = new ArrayList<>();
            expectedProdutosC1P2.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 2.5));
            expectedProdutosC1P2.add(new AbstractMap.SimpleEntry<>("Produto7: ",(float) 8.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P3 = new ArrayList<>();
            expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 1.5));
            expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 1));
            expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto10: ",(float) 5.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P1 = new ArrayList<>();
            expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 0.5));
            expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 5));
            expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 2.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P2 = new ArrayList<>();
            expectedProdutosC2P2.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 5));
            expectedProdutosC2P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 0.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P3 = new ArrayList<>();
            expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 8));
            expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto4: ",(float) 1.5));
            expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto10: ",(float) 2));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC3P2 = new ArrayList<>();
            expectedProdutosC3P2.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 3));
            expectedProdutosC3P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 3.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC3P3 = new ArrayList<>();
            expectedProdutosC3P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 4.5));
        //Testar os clientes
        assertEquals(expectedClientesKeySet, result.keySet());
        //Testar os Produtores
            //Testar Produtos
        assertEquals(expectedProdutoresKeySetC4, result.get(C4).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC4P2,result.get(C4).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC4P3,result.get(C4).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC7, result.get(C7).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC7P1,result.get(C7).getProdutorProdutos().get(P1));
            assertEquals(expectedProdutosC7P2,result.get(C7).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC7P3,result.get(C7).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC9, result.get(C9).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC9P2,result.get(C9).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC9P3,result.get(C9).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetE1, result.get(E1).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosE1P3,result.get(E1).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC1, result.get(C1).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC1P1,result.get(C1).getProdutorProdutos().get(P1));
            assertEquals(expectedProdutosC1P2,result.get(C1).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC1P3,result.get(C1).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC2, result.get(C2).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC2P1,result.get(C2).getProdutorProdutos().get(P1));
            assertEquals(expectedProdutosC2P2,result.get(C2).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC2P3,result.get(C2).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC3, result.get(C3).getProdutorProdutos().keySet());
            assertEquals(expectedProdutosC3P2,result.get(C3).getProdutorProdutos().get(P2));
            assertEquals(expectedProdutosC3P3,result.get(C3).getProdutorProdutos().get(P3));
    }
    @Test
    void createDailyExpeditionListTest() {
        Map<ClienteProdutorEmpresa, Cabaz> result = createExpeditionList.createDailyExpeditionList(2);
        Set<ClienteProdutorEmpresa> expectedClientesKeySet = new HashSet<>();
        ClienteProdutorEmpresa C4 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C4");
        ClienteProdutorEmpresa C7 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C7");
        ClienteProdutorEmpresa C9 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C9");
        ClienteProdutorEmpresa E1 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("E1");
        ClienteProdutorEmpresa C1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("C1");
        ClienteProdutorEmpresa C2 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C2");
        ClienteProdutorEmpresa C3 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("C3");
        ClienteProdutorEmpresa P1 =  App.getInstance().getClienteProdutorEmpresaStore().getCPE("P1");
        ClienteProdutorEmpresa P2 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P2");
        ClienteProdutorEmpresa P3 = App.getInstance().getClienteProdutorEmpresaStore().getCPE("P3");
        expectedClientesKeySet.add(C4);
        expectedClientesKeySet.add(C7);
        expectedClientesKeySet.add(C9);
        expectedClientesKeySet.add(E1);
        expectedClientesKeySet.add(C1);
        expectedClientesKeySet.add(C2);
        expectedClientesKeySet.add(C3);
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC4 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC7 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC9 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetE1 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC1 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC2 = new HashSet<>();
        Set<ClienteProdutorEmpresa> expectedProdutoresKeySetC3 = new HashSet<>();
        expectedProdutoresKeySetC4.add(P2);
        expectedProdutoresKeySetC4.add(P3);
        expectedProdutoresKeySetC7.add(P1);
        expectedProdutoresKeySetC7.add(P2);
        expectedProdutoresKeySetC7.add(P3);
        expectedProdutoresKeySetC9.add(P2);
        expectedProdutoresKeySetC9.add(P3);
        expectedProdutoresKeySetE1.add(P3);
        expectedProdutoresKeySetC1.add(P1);
        expectedProdutoresKeySetC1.add(P2);
        expectedProdutoresKeySetC1.add(P3);
        expectedProdutoresKeySetC2.add(P1);
        expectedProdutoresKeySetC2.add(P2);
        expectedProdutoresKeySetC2.add(P3);
        expectedProdutoresKeySetC3.add(P2);
        expectedProdutoresKeySetC3.add(P3);
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC4P2 = new ArrayList<>();
        expectedProdutosC4P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC4P3 = new ArrayList<>();
        expectedProdutosC4P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 2));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P1 = new ArrayList<>();
        expectedProdutosC7P1.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 4));
        expectedProdutosC7P1.add(new AbstractMap.SimpleEntry<>("Produto8: ",(float) 1));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P2 = new ArrayList<>();
        expectedProdutosC7P2.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 3));
        expectedProdutosC7P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 1.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC7P3 = new ArrayList<>();
        expectedProdutosC7P3.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 3.5));
        expectedProdutosC7P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 1.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC9P2 = new ArrayList<>();
        expectedProdutosC9P2.add(new AbstractMap.SimpleEntry<>("Produto6: ",(float) 4.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC9P3 = new ArrayList<>();
        expectedProdutosC9P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 0.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosE1P3 = new ArrayList<>();
        expectedProdutosE1P3.add(new AbstractMap.SimpleEntry<>("Produto4: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P1 = new ArrayList<>();
        expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 3));
        expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 4));
        expectedProdutosC1P1.add(new AbstractMap.SimpleEntry<>("Produto8: ",(float) 3));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P2 = new ArrayList<>();
        expectedProdutosC1P2.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 2.5));
        expectedProdutosC1P2.add(new AbstractMap.SimpleEntry<>("Produto7: ",(float) 8.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC1P3 = new ArrayList<>();
        expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 1.5));
        expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto3: ",(float) 1));
        expectedProdutosC1P3.add(new AbstractMap.SimpleEntry<>("Produto10: ",(float) 5.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P1 = new ArrayList<>();
        expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 0.5));
        expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 5));
        expectedProdutosC2P1.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 2.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P2 = new ArrayList<>();
        expectedProdutosC2P2.add(new AbstractMap.SimpleEntry<>("Produto5: ",(float) 5));
        expectedProdutosC2P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 0.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC2P3 = new ArrayList<>();
        expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto1: ",(float) 8));
        expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto4: ",(float) 1.5));
        expectedProdutosC2P3.add(new AbstractMap.SimpleEntry<>("Produto10: ",(float) 2));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC3P2 = new ArrayList<>();
        expectedProdutosC3P2.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 3));
        expectedProdutosC3P2.add(new AbstractMap.SimpleEntry<>("Produto12: ",(float) 3.5));
        List<AbstractMap.SimpleEntry<String, Float>> expectedProdutosC3P3 = new ArrayList<>();
        expectedProdutosC3P3.add(new AbstractMap.SimpleEntry<>("Produto9: ",(float) 4.5));
        //Testar os clientes
        assertEquals(expectedClientesKeySet, result.keySet());
        //Testar os Produtores
        //Testar Produtos
        assertEquals(expectedProdutoresKeySetC4, result.get(C4).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC4P2,result.get(C4).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC4P3,result.get(C4).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC7, result.get(C7).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC7P1,result.get(C7).getProdutorProdutos().get(P1));
        assertEquals(expectedProdutosC7P2,result.get(C7).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC7P3,result.get(C7).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC9, result.get(C9).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC9P2,result.get(C9).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC9P3,result.get(C9).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetE1, result.get(E1).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosE1P3,result.get(E1).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC1, result.get(C1).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC1P1,result.get(C1).getProdutorProdutos().get(P1));
        assertEquals(expectedProdutosC1P2,result.get(C1).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC1P3,result.get(C1).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC2, result.get(C2).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC2P1,result.get(C2).getProdutorProdutos().get(P1));
        assertEquals(expectedProdutosC2P2,result.get(C2).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC2P3,result.get(C2).getProdutorProdutos().get(P3));
        assertEquals(expectedProdutoresKeySetC3, result.get(C3).getProdutorProdutos().keySet());
        assertEquals(expectedProdutosC3P2,result.get(C3).getProdutorProdutos().get(P2));
        assertEquals(expectedProdutosC3P3,result.get(C3).getProdutorProdutos().get(P3));
    }



    @Test
    void getProdutores() throws IOException {
        List<ClienteProdutorEmpresa> listProdutores=new ArrayList<>();
        ClienteProdutorEmpresa cpe3= new ClienteProdutorEmpresa("CT17",40.6667f,-7.9167f,"P1");
        ClienteProdutorEmpresa cpe4= new ClienteProdutorEmpresa("CT6",40.2111f,-8.4291f,"P2");
        ClienteProdutorEmpresa cpe5= new ClienteProdutorEmpresa("CT10",39.7444f,-8.8072f,"P3");
        listProdutores.add(cpe3);
        listProdutores.add(cpe4);
        listProdutores.add(cpe5);
        Assertions.assertTrue(createExpeditionList.getProdutores().containsAll(listProdutores));
    }
}