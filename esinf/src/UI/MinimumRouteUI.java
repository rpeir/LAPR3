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
        app = App.getInstance();
        Map<ClienteProdutorEmpresa, Cabaz> expeditionList = app.getListaExpedicoesStore().getExpedicaoNumDia();
        System.out.println("Em qual produtor deseja comecar o precurso?");
        List<ClienteProdutorEmpresa> produtores = new ArrayList<>();
        for(Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionList.entrySet()) {
            Cabaz cabaz = entry.getValue();
            Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtorProdutos = cabaz.getProdutorProdutos();
            for(Map.Entry<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> entry2 : produtorProdutos.entrySet()) {
                if(!produtores.contains(entry2.getKey())) {
                    produtores.add(entry2.getKey());
                    System.out.println(entry2.getKey().getDesignacao());
                }
            }
        }
        produtorInicial = sc.nextLine();
        if(produtores.contains(app.getClienteProdutorEmpresaStore().getCPE(produtorInicial))) {
            ctrl.getMinimumRoute(produtorInicial);
        }
        else {
            System.out.println("Produtor nao existe");
            run();
        }
    }
}
