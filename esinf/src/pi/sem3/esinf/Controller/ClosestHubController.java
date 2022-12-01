package pi.sem3.esinf.Controller;

import pi.sem3.esinf.domain.ClienteProdutorEmpresa;
import pi.sem3.esinf.domain.Localizacao;
import pi.sem3.esinf.graph.Algorithms;
import pi.sem3.esinf.graph.Graph;

import java.util.LinkedList;
import java.util.Map;

public class ClosestHubController {
    private final Graph<Localizacao, Integer> graph;
    public ClosestHubController() {
        graph = App.getInstance().getGraph();
    }

    public ClosestHubController(Graph<Localizacao, Integer> graph) {
        this.graph = graph;
    }

    /**
     * It returns the closest hub to a given client/producer/company
     *
     * @param cpe The client/producer/company that we want to find the closest hub to.
     * @return The closest hub to the given ClienteProdutorEmpresa.
     */
    public ClienteProdutorEmpresa getClosestHub(ClienteProdutorEmpresa cpe) {
        LinkedList<Localizacao> list = new LinkedList<>();
        Integer minlenpath = 0;
        ClienteProdutorEmpresa result = null;
        for (ClienteProdutorEmpresa cpe2: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            if (cpe2.isHub()) {
                if (cpe2.getLocalizacao().equals(cpe.getLocalizacao())) {
                    return cpe2;
                }
                else{
                    Integer tempLenPath = Algorithms.shortestPath(graph, cpe.getLocalizacao(), cpe2.getLocalizacao(), Integer::compare,Integer::sum, 0,list );
                    if (tempLenPath < minlenpath || minlenpath == 0) {
                        minlenpath = tempLenPath;
                        result = cpe2;
                    }
                }
            }
        }
        return result;
    }


   /**
    * For each ClienteProdutorEmpresa in the map, if it's a client, add it to the result map with the closest hub as the
    * value
    *
    * @return A map of ClienteProdutorEmpresa objects, where the key is the ClienteProdutorEmpresa object and the value is
    * the closest hub to the ClienteProdutorEmpresa object.
    */
   public Map<ClienteProdutorEmpresa,ClienteProdutorEmpresa> getAllClosestHubs (){
        Map<ClienteProdutorEmpresa,ClienteProdutorEmpresa> result = null;
        for (ClienteProdutorEmpresa cpe: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            if (ClienteProdutorEmpresa.validateClienteID(cpe.getId())) {
                result.put(cpe,getClosestHub(cpe));
            }
        }
        return result;
   }
}
