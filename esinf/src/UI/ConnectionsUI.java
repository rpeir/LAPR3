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
            System.out.println("The graph isn't connect");
        else
            System.out.println("The graph is connect, and with " + result + " connections we can reach any destination from any origin");
    }

}
