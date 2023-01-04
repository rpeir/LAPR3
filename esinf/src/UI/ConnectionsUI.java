package UI;

import Controller.ConnectionsController;

import java.util.Scanner;

public class ConnectionsUI implements  Runnable{
private final ConnectionsController CTRL;

    public ConnectionsUI(ConnectionsController CTRL) {
        this.CTRL = CTRL;
    }
   public ConnectionsUI() {
        CTRL = new ConnectionsController();
    }


    @Override
    public void run() {
        int result = CTRL.minConnevtions();
        if(result == -1)
            System.out.println("O grafo nao e conexo");
        else
            System.out.println("O grafo é conexo, e com " + result + " conexões conseguimos atingir qualquer Destino a partir de qualquer Origem.");
    }

}
