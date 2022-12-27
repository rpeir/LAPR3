package Controller;

import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Algorithms;
import graph.Graph;
import store.HubsStore;

import java.util.HashMap;
import java.util.LinkedList;

public class ClosestHubController {

    HubsStore hubsStore;
    private final Graph<Localizacao, Integer> graph;
    public ClosestHubController() {
        graph = App.getInstance().getGraph();
        hubsStore = App.getInstance().getHubsStore();
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
        Integer minlenpath = Integer.MAX_VALUE;
        ClienteProdutorEmpresa result = null;
        for (ClienteProdutorEmpresa cpe2: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            if (cpe2.isHub()) {
                if (cpe2.getLocalizacao().equals(cpe.getLocalizacao())) {
                    return cpe2;
                }
                else{
                    Integer tempLenPath = Algorithms.shortestPath(graph, cpe.getLocalizacao(), cpe2.getLocalizacao(), Integer::compare,Integer::sum, 0,list );

                    try{
                        if (tempLenPath < minlenpath) {
                            minlenpath = tempLenPath;
                            result = cpe2;
                        }
                    }catch (NullPointerException e){
                        System.out.println("Não existe caminho entre " + cpe.getLocalizacao() + " e " + cpe2.getLocalizacao());
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
   public HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> getAllClosestHubs (){
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> result = new HashMap<>();
        for (ClienteProdutorEmpresa cpe: App.getInstance().getClienteProdutorEmpresaStore().getMapCPE().values()) {
            if (ClienteProdutorEmpresa.validateClienteID(cpe.getId())) {
                result.put(cpe,getClosestHub(cpe));
            }
        }
        hubsStore.setClosestHubToEachClient(result);
        return result;
   }
}
