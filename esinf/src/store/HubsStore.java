package store;

import domain.ClienteProdutorEmpresa;

import java.util.HashMap;
import java.util.Map;

public class HubsStore {
    private Map<ClienteProdutorEmpresa, Double> hubs;
    HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubToEachClient;

    public HubsStore() {
        hubs = new HashMap<>();
        closestHubToEachClient = new HashMap<>();
    }

    public Map<ClienteProdutorEmpresa, Double> getHubs() {
        return hubs;
    }

    public void setHubs(Map<ClienteProdutorEmpresa, Double> hubs) {
        this.hubs = hubs;
    }

    public HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> getClosestHubToEachClient() {
        return closestHubToEachClient;
    }

    public void setClosestHubToEachClient(HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubToEachClient) {
        this.closestHubToEachClient = closestHubToEachClient;
    }

}
