package esinf.controller;

import Controller.App;
import Controller.MinimumRouteController;
import Controller.ReadCSVController;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

public class MinimumRouteControllerTest {

    private MinimumRouteController controller;
    private ReadCSVController readCSVController;
    App app = new App();

    public MinimumRouteControllerTest() {
        controller = new MinimumRouteController();
        readCSVController = new ReadCSVController();
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
    public void testGetMinimumRoute() {

    }

}
