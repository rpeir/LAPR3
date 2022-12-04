package UI;

import Controller.ConnectionsController;

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
            System.out.println("O grafo e conexo, e com " + result + " conecoes conseguimos atingir qualquer destino a partir de qualquer origem");
    }

}
