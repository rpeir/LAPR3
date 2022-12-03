package Controller;

import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;

public class MSTNetworkController {

    private final Graph<Localizacao, Integer> graph;
    public MSTNetworkController() {
        graph = App.getInstance().getGraph();
    }

    public MSTNetworkController(Graph<Localizacao, Integer> graph) {
        this.graph = graph;
    }


    /**
     * Get the minimum spanning tree of the graph
     * @return the minimum spanning tree of the graph
     */
    public Graph<Localizacao, Integer> getMSTNetwork(){
        if (graph == null || graph.numVertices() == 0) throw new IllegalStateException("O grafo não pode ser nulo ou vazio");
        if (kruskallBetterToUse()) {
            return Algorithms.kruskall(graph, Integer::compare);
        } else {
            return Algorithms.prim(graph, Integer::compare, 0);
        }
    }

    /**
     * Return true if the best algorithm to use is Kruskal
     * @return true if the best algorithm to use is Kruskal
     */
    private boolean kruskallBetterToUse() {
        int nVertices = graph.numVertices();
        int nEdges = graph.numEdges();
        return nVertices*nVertices > nEdges*Math.log(nVertices);
    }

    /**
     * Return the total distance of the network
     * @param mst mst
     * @return total distance
     */
    public int getMSTNetworkDistance(Graph<Localizacao, Integer> mst) {
        return Algorithms.totalWeight(mst, Integer::sum, 0);
    }

}
