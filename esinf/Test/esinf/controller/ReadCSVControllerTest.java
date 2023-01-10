package esinf.controller;

import Controller.App;
import Controller.ReadCSVController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import domain.Pedido;
import graph.Edge;
import graph.Graph;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import store.PedidosStore;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ReadCSVControllerTest {
    private final ReadCSVController readCSVController = new ReadCSVController();
    private final File file_test_CPE_small = new File("esinf/grafos/grafos/Small/clientes-produtores_small.csv");

    private final File file_test_CPE_big= new File("esinf/grafos/grafos/Big/clientes-produtores_big.csv");

    private final File file_test_dist_small = new File("esinf/grafos/grafos/Small/distancias_small.csv");

    private final File file_test_dist_big = new File("esinf/grafos/grafos/Big/distancias_big.csv");

    private final File file_test_cabaz_small = new File("esinf/grafos/grafos/Small/cabazes_small.csv");

    private final File file_test_cabaz_big = new File("esinf/grafos/grafos/Big/cabazes_big.csv");





    @Test
    void readClientesProdutoresFileSmall() throws IOException {
        Graph<Localizacao, Integer> graph = App.getInstance().getGraph();
        readCSVController.readClientesProdutoresFile( file_test_CPE_small );
        ClienteProdutorEmpresa cpe1 = new ClienteProdutorEmpresa("CT1",40.6389f,-8.6553f,"C1");
        ClienteProdutorEmpresa cpe2 = new ClienteProdutorEmpresa("CT2",38.0333f,-7.8833f,"C2");
        ClienteProdutorEmpresa cpe3 = new ClienteProdutorEmpresa("CT3",41.5333f,-8.4167f,"C3");
        Assertions.assertEquals(graph.vertices().get(0), cpe1.getLocalizacao());
        Assertions.assertEquals(graph.vertices().get(1), cpe2.getLocalizacao());
        Assertions.assertEquals(graph.vertices().get(2), cpe3.getLocalizacao());
    }
    @Test
    void readDistancesFileSmall() throws IOException {
        Graph<Localizacao, Integer> graph = App.getInstance().getGraph();
        readCSVController.readClientesProdutoresFile( file_test_CPE_small );
        readCSVController.readDistancesFile(file_test_dist_small);
        //Assertions.assertEquals( 66, graph.numEdges() );
        Localizacao lc1=new Localizacao("CT1",40.6389f,-8.6553f);
        Localizacao lc2=new Localizacao("CT6",40.2111f,-8.4291f);
        Localizacao lc3= new Localizacao("CT5",39.823f,-7.4931f);
        Localizacao lc4=new Localizacao("CT17",40.6667f,-7.9167f);
        graph.addEdge(lc1,lc2, 56717);
        graph.addEdge(lc3,lc4,111134);
        assertTrue(graph.edges().contains(new Edge<>(lc1, lc2, 56717)));
        assertTrue(graph.edges().contains(new Edge<>(lc3, lc4, 111134)));


    }
    @Test
    void readDistancesFileBig() throws IOException {
        Graph<Localizacao, Integer> graph = App.getInstance().getGraph();
        readCSVController.readClientesProdutoresFile( file_test_CPE_big );
        readCSVController.readDistancesFile(file_test_dist_big);
        //Assertions.assertEquals( 1566, graph.numEdges() );
        Localizacao lc5=new Localizacao("CT39",37.1f,-8.3667f);
        Localizacao lc6=new Localizacao("CT7",37.0889f,-8.2511f);
        Localizacao lc7= new Localizacao("CT32",40.4333f,-8.4333f);
        Localizacao lc8=new Localizacao("CT160",40.3781f,-8.4514f);
        graph.addEdge(lc5,lc6, 11460);
        graph.addEdge(lc7,lc8,6992);
        assertTrue(graph.edges().contains(new Edge<>(lc5, lc6, 11460)));
        assertTrue(graph.edges().contains(new Edge<>(lc7, lc8, 6992)));


    }

    @Test
    void readCabazesFileSmall() throws IOException {
        readCSVController.readClientesProdutoresFile( file_test_CPE_small );
        readCSVController.readDistancesFile(file_test_dist_small);
        readCSVController.readCabazesFile(file_test_cabaz_small);

        List<Float> prod1 = new ArrayList<>();
        prod1.add(0,0.0f);
        prod1.add(1,0.0f);
        prod1.add(2,0.0f);
        prod1.add(3,0.0f);
        prod1.add(4,5.0f);
        prod1.add(5,2.0f);
        prod1.add(6,0.0f);
        prod1.add(7,0.0f);
        prod1.add(8,0.0f);
        prod1.add(9,0.0f);
        prod1.add(10,2.5f);
        prod1.add(11,0.0f);

        List<Float> prod2 = new ArrayList<>();
        prod2.add(0,0.0f);
        prod2.add(1,5.5f);
        prod2.add(2,4.5f);
        prod2.add(3,0.0f);
        prod2.add(4,4.0f);
        prod2.add(5,0.0f);
        prod2.add(6,0.0f);
        prod2.add(7,0.0f);
        prod2.add(8,1.0f);
        prod2.add(9,9.0f);
        prod2.add(10,10.0f);
        prod2.add(11,0.0f);

        Pedido pedido1=new Pedido("C1",1,prod1);
        Pedido pedido2=new Pedido("C2",10,prod2);
        Assertions.assertEquals("C1", pedido1.getClienteProdutor());
        Assertions.assertEquals("C2", pedido2.getClienteProdutor());
        Assertions.assertEquals(2.5f , pedido1.getProduto(10));
        Assertions.assertEquals(5.5f , pedido2.getProduto(1));
        Assertions.assertEquals(10, pedido2.getDiaDeProducao());
    }
    @Test
    void readCabazesFileBig() throws IOException {
        readCSVController.readClientesProdutoresFile( file_test_CPE_big);
        readCSVController.readDistancesFile(file_test_dist_big);
        readCSVController.readCabazesFile(file_test_cabaz_big);

        //C1,1,0,0,4.5,0,3,0,0,9.5,0,0,0,2.5,0,10,0,2,0,5,0,0
        //C2,1,0,0,0,0,5.5,0,0,0,7.5,0,0,0,4,8.5,9.5,0,3.5,0,9,0

        List<Float> prod3 = new ArrayList<>();
       prod3.add(0,0.0f);
       prod3.add(1,0.0f);
       prod3.add(2,4.5f);
       prod3.add(3,0.0f);
       prod3.add(4,3.0f);
       prod3.add(5,0.0f);
       prod3.add(6,0.0f);
       prod3.add(7,9.5f);
       prod3.add(8,0.0f);
       prod3.add(9,0.0f);
       prod3.add(10,0.0f);
       prod3.add(11,2.5f);
       prod3.add(12,0.0f);
       prod3.add(13,10.0f);
       prod3.add(14,0.0f);
       prod3.add(15,2.0f);
       prod3.add(16,0.0f);
       prod3.add(17,5.0f);
       prod3.add(18,0.0f);
       prod3.add(19,0.0f);


        List<Float> prod4 = new ArrayList<>();
        prod4.add(0,0.0f);
        prod4.add(1,0.0f);
        prod4.add(2,0.0f);
        prod4.add(3,0.0f);
        prod4.add(4,5.5f);
        prod4.add(5,0.0f);
        prod4.add(6,0.0f);
        prod4.add(7,0.0f);
        prod4.add(8,7.5f);
        prod4.add(9,0.0f);
        prod4.add(10,0.0f);
        prod4.add(11,0.0f);
        prod4.add(12,4.0f);
        prod4.add(13,8.5f);
        prod4.add(14,9.5f);
        prod4.add(15,0.0f);
        prod4.add(16,3.5f);
        prod4.add(17,0.0f);
        prod4.add(18,9.0f);
        prod4.add(19,0.0f);





        Pedido pedido3=new Pedido("C1",1,prod3);
        Pedido pedido4=new Pedido("C2",10,prod4);
        Assertions.assertEquals("C1", pedido3.getClienteProdutor());
        Assertions.assertEquals("C2", pedido4.getClienteProdutor());
        Assertions.assertEquals(10.0f , pedido3.getProduto(13));
        Assertions.assertEquals(7.5f , pedido4.getProduto(8));
        Assertions.assertEquals(10, pedido4.getDiaDeProducao());
    }
}