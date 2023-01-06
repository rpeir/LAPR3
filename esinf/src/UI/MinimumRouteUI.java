package UI;

import Controller.App;
import Controller.MinimumRouteController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

import java.util.*;

public class MinimumRouteUI {
    App app;
    MinimumRouteController ctrl;

    public MinimumRouteUI() {
        app = App.getInstance();
        ctrl = new MinimumRouteController();
    }

    public void run() {
        Scanner sc = new Scanner(System.in);
        String produtorInicial = "";
        int dia;
        System.out.println("Selecione um dia:");
        for(Map.Entry<Integer, Map<ClienteProdutorEmpresa, Cabaz>> listaExpedicoes : app.getListaExpedicoesStore().getExpedicoes().entrySet()) {
            System.out.println(listaExpedicoes.getKey());
        }
        dia = sc.nextInt();
        if(app.getListaExpedicoesStore().getExpedicaoNumDia(dia) == null) {
            System.out.println("Não existem expedicoes nesse dia");
            run();
        }
        List<ClienteProdutorEmpresa> listaProdutores = new ArrayList<>();
        System.out.println("Selecione um produtor inicial:");
        for(Map.Entry<ClienteProdutorEmpresa, Cabaz> expedicao : app.getListaExpedicoesStore().getExpedicaoNumDia(dia).entrySet()) {
            Cabaz cabaz = expedicao.getValue();
            for(Map.Entry<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtor : cabaz.getProdutorProdutos().entrySet()) {
                if(!listaProdutores.contains(produtor.getKey())) {
                    listaProdutores.add(produtor.getKey());
                    System.out.println(produtor.getKey().getDesignacao());
                }
            }
        }
        produtorInicial = sc.next();
        if(!listaProdutores.contains(app.getClienteProdutorEmpresaStore().getCPE(produtorInicial))) {
            System.out.println("Produtor não existe");
            run();
        }
        else {
            ctrl.getMinimumRoute(produtorInicial, dia);
        }
    }
}
