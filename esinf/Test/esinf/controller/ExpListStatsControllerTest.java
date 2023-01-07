package esinf.controller;

import Controller.ExpListStatsController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

import domain.Pedido;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import stats.ListStatistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

class ExpListStatsControllerTest {

    private ExpListStatsController instance;

    public ExpListStatsControllerTest() {
    }

    @BeforeEach
    void setUp() {
        // Temporário enquanto os metodos de criacao de listas de expedicoes nao estao implementados
        //Map<Integer, ListaExpedicoes> expedicoes = new HashMap<>();
        Map<String, ClienteProdutorEmpresa > mapCPE = new HashMap<>();

        //ListaExpedicoes exp1 = new ListaExpedicoes(1);
        //expedicoes.put(1, exp1);

        ClienteProdutorEmpresa c1 = new ClienteProdutorEmpresa("CT1",1,1,"C1");
        ClienteProdutorEmpresa c2 = new ClienteProdutorEmpresa("CT2",2,2,"C2");
        ClienteProdutorEmpresa p1 = new ClienteProdutorEmpresa("CT3",3,3,"P1");
        ClienteProdutorEmpresa p2 = new ClienteProdutorEmpresa("CT4",4,4,"P2");
        ClienteProdutorEmpresa p3 = new ClienteProdutorEmpresa("CT5",5,5,"P3");

        mapCPE.put("C1", c1);
        mapCPE.put("C2", c2);
        mapCPE.put("P1", p1);
        mapCPE.put("P2", p2);
        mapCPE.put("P3", p3);

        List<String> produtores = List.of("P1", "P2", "P2");

        List<Float> c1p1Produtos = List.of(1f,2f,3f);
        List<Float> c2p1Produtos = List.of(4f,5f,6f);

        Pedido c1p1 = new Pedido("C1",1, c1p1Produtos);
        Pedido c2p1 = new Pedido("C1",1, c2p1Produtos);

        c1.setCabaz(c1p1);
        c2.setCabaz(c2p1);

        //Cabaz cabaz1 = new Cabaz("C1", 1, c1p1Produtos,produtores);
        //Cabaz cabaz2 = new Cabaz("C2", 1, List.of(0f,4f,4f),produtores);

        //exp1.addExpedicao(cabaz1);
        //exp1.addExpedicao(cabaz2);

        //instance = new ExpListStatsController(expedicoes, mapCPE);
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