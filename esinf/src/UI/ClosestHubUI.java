package UI;

import Controller.ClosestHubController;
import domain.ClienteProdutorEmpresa;

import java.util.Map;

public class ClosestHubUI implements Runnable{
    private final ClosestHubController CTRL;
    public ClosestHubUI(ClosestHubController CTRL) {
        this.CTRL = CTRL;
    }
    public ClosestHubUI() {
        CTRL = new ClosestHubController();
    }
    public void run() {
        System.out.println();
        System.out.println("Hubs mais proximos para cada cliente:\n");
        Map<ClienteProdutorEmpresa,ClienteProdutorEmpresa> result = CTRL.getAllClosestHubs();
        if (result.containsValue(null) || result.isEmpty()) {
            System.out.println("Nao existem hubs.");
        }else{
            for ( Map.Entry<ClienteProdutorEmpresa,ClienteProdutorEmpresa> entry : result.entrySet()) {
                System.out.println("Cliente: " + entry.getKey().getDesignacao() + " - Hub: " + entry.getValue().getDesignacao());
            }
        }
    }
}
