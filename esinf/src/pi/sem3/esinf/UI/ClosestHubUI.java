package pi.sem3.esinf.UI;

import pi.sem3.esinf.Controller.ClosestHubController;
import pi.sem3.esinf.domain.ClienteProdutorEmpresa;
import pi.sem3.esinf.domain.Localizacao;
import pi.sem3.esinf.graph.Graph;

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
        System.out.println(result);
        for ( Map.Entry<ClienteProdutorEmpresa,ClienteProdutorEmpresa> entry : result.entrySet()) {
            System.out.println("Cliente: " + entry.getKey().getDesignacao() + " - Hub: " + entry.getValue().getDesignacao());
        }
    }
}
