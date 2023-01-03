package UI;

import Controller.App;
import Controller.MinimumRouteController;
import Controller.Test;
import store.HubsStore;

import java.util.Scanner;

public class MinimumRouteUI {
    App app;
    MinimumRouteController ctrl;
    Test test;


    public MinimumRouteUI() {
        app = App.getInstance();
        ctrl = new MinimumRouteController();
        test = new Test();
    }

    public void run() {
        Scanner sc = new Scanner(System.in);
        int diaPretendido;
        System.out.println("Dias disponíveis: ");
        for (int dia : app.getListaExpedicoesStore().getExpedicoes().keySet()) {
            System.out.println(dia);
        }
        diaPretendido = sc.nextInt();
        //test.getTest(diaPretendido);
        //if(app.getListaExpedicoesStore().getExpedicoes().containsKey(diaPretendido) && diaPretendido > 0) {
            ctrl.getMinimumRoute(diaPretendido);
        //} else {
            //System.out.println("Dia inválido");
           // run();
       //}
    }
}
