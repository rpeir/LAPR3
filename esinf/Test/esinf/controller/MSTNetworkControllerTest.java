package esinf.controller;

import graph.map.MapGraph;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import Controller.App;
import Controller.MSTNetworkController;
import Controller.ReadCSVController;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;

import java.io.File;
import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;



public class MSTNetworkControllerTest {

    private final Graph<Localizacao, Integer> g;
    private final MSTNetworkController instance;
    public MSTNetworkControllerTest() {
        instance = new MSTNetworkController();
        g = new MapGraph<>(false);
        App.getInstance().setGraph(g);
    }

    private final String pathCPbig = "esinf/grafos/grafos/Big/clientes-produtores_big.csv";

    private final String pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";

    private final String pathDbig = "esinf/grafos/grafos/Big/distancias_big.csv";

    private final String pathDsmall = "esinf/grafos/grafos/Small/distancias_small.csv";

    @BeforeEach
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
    }

    @Test
    public void testGetMSTNetwork() {
        System.out.println("getMSTNetwork");
        Graph<?, ?> result = instance.getMSTNetwork();
        testMST(result);
        System.out.println(result);
        Assertions.assertNotNull(result);
    }

    @Test
    public void testKruskall() {
        System.out.println("Test of Kruskall Algorithm");
        Graph<?, ?> kruskall = Algorithms.kruskall(g, Integer::compare);
        testMST(kruskall);
        System.out.println(kruskall);
    }

    @Test
    public void testPrim() {
        System.out.println("Test of Prim Algorithm");
        Graph<?, ?> prim = Algorithms.prim(g, Integer::compare, 0);
        testMST(prim);
        System.out.println(prim);
    }

    private void testMST(Graph<?, ?> mst) {
        assertEquals(g.numVertices(), mst.numVertices(), "The number of vertices in the MST is not the same as the original graph");
        assertEquals((App.getInstance().getGraph().numVertices()-1)*2, mst.numEdges(), "The number of edges in the MST is not the number of vertices - 1");
    }

}
