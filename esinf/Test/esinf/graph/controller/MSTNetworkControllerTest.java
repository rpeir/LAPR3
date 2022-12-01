package esinf.graph.controller;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import pi.sem3.esinf.Controller.MSTNetworkController;
import pi.sem3.esinf.Controller.ReadCSVController;
import pi.sem3.esinf.graph.Graph;

import java.io.File;
import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;



public class MSTNetworkControllerTest {

    private final MSTNetworkController instance;
    public MSTNetworkControllerTest() {
        instance = new MSTNetworkController();
    }

    @BeforeEach
    public void setUp() {
        ReadCSVController readCSVController = new ReadCSVController();
        try {
            readCSVController.readClientesProdutoresFile(new File("esinf/grafos/grafos/Big/clientes-produtores_big.csv"));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste clientes-produtores_big.csv");
        }
        try {
            readCSVController.readDistancesFile(new File("esinf/grafos/grafos/Big/distancias_big.csv"));
        } catch (IOException e) {
            System.out.println("Erro ao ler o ficheiro de teste distancias_big.csv");
        }
    }

    @Test
    public void testGetMSTNetwork() {
        System.out.println("getMSTNetwork");
        Graph<?, ?> result = instance.getMSTNetwork();
        System.out.println(result);
        Assertions.assertNotNull(result);
    }

}
