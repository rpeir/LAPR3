package UI;

import Controller.MSTNetworkController;
import domain.Localizacao;
import graph.Graph;

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
        try {
            Graph<Localizacao, Integer> result = CTRL.getMSTNetwork();
            System.out.println(result);
            System.out.println("Distância total: " + CTRL.getMSTNetworkDistance(result) + " m");
            System.out.println("Numero de Clientes: " + result.numVertices());
            System.out.println("Numero de Caminhos: " + result.numEdges() / 2);
        } catch (IllegalStateException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println("Ocorreu um erro inesperado");
        }
    }
}
