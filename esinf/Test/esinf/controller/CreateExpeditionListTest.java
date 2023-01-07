package esinf.controller;

import Controller.App;
import Controller.ReadCSVController;
import domain.*;
import graph.Graph;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import store.PedidosStore;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class CreateExpeditionListTest {

    private final CreateExpeditionList expeditionList = new CreateExpeditionList();
    private final ReadCSVController readCSVController = new ReadCSVController();


    private final File file_test_CPE_small = new File("esinf/grafos/grafos/Small/clientes-produtores_small.csv");

    private final List<ClienteProdutorEmpresa> listProdutores=new ArrayList<>();

    @Test
    void getProdutores() throws IOException {
        readCSVController.readClientesProdutoresFile( file_test_CPE_small );
        ClienteProdutorEmpresa cpe3= new ClienteProdutorEmpresa("CT17",40.6667f,-7.9167f,"P1");
        ClienteProdutorEmpresa cpe4= new ClienteProdutorEmpresa("CT6",40.2111f,-8.4291f,"P2");
        ClienteProdutorEmpresa cpe5= new ClienteProdutorEmpresa("CT10",39.7444f,-8.8072f,"P3");
        listProdutores.add(cpe3);
        listProdutores.add(cpe4);
        listProdutores.add(cpe5);
        Assertions.assertTrue(expeditionList.getProdutores().containsAll(listProdutores));


    }
}