package pi.sem3.esinf.Controller;

import pi.sem3.esinf.domain.ClienteProdutorEmpresa;
import pi.sem3.esinf.graph.Algorithms;
import pi.sem3.esinf.graph.Graph;

public class MSTNetworkController {

    private final Graph<ClienteProdutorEmpresa, Integer> graph;
    public MSTNetworkController() {
        graph = App.getInstance().getGraph();
    }

    public MSTNetworkController(Graph<ClienteProdutorEmpresa, Integer> graph) {
        this.graph = graph;
    }


    /**
     * Get the minimum spanning tree of the graph
     * @return the minimum spanning tree of the graph
     */
    public Graph<?, ?> getMSTNetwork(){
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

}
