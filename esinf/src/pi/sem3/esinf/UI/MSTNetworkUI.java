package pi.sem3.esinf.UI;

import pi.sem3.esinf.Controller.MSTNetworkController;
import pi.sem3.esinf.domain.Localizacao;
import pi.sem3.esinf.graph.Graph;

public class MSTNetworkUI implements  Runnable{
    private final MSTNetworkController CTRL;

    public MSTNetworkUI(MSTNetworkController CTRL) {
        this.CTRL = CTRL;
    }

    public MSTNetworkUI() {
        CTRL = new MSTNetworkController();
    }

    @Override
    public void run() {
        System.out.println();
        System.out.println("Rede de distribuição com distância total mínima:\n");
        Graph<Localizacao, Integer> result = CTRL.getMSTNetwork();
        System.out.println(result);
        System.out.println("Distância total: " + CTRL.getMSTNetworkDistance(result) + " m");
        System.out.println("Numero de Clientes: " + result.numVertices());
        System.out.println("Numero de Caminhos: " + result.numEdges()/2);
    }
}
