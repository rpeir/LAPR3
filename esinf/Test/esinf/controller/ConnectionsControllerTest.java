package esinf.controller;

import Controller.App;
import Controller.ConnectionsController;
import Controller.ReadCSVController;
import domain.Localizacao;
import graph.Graph;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;

class ConnectionsControllerTest {

    private final ConnectionsController ctrl;
    public ConnectionsControllerTest() {
        ctrl = new ConnectionsController();
    }

    private final String   pathCPsmall = "esinf/grafos/grafos/Small/clientes-produtores_small.csv";
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
    void minConnevtions() {
        int result = ctrl.minConnevtions();
        assertEquals(6,result);
    }
}