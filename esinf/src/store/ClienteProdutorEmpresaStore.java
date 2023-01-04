package store;

import domain.Pedido;
import domain.ClienteProdutorEmpresa;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ClienteProdutorEmpresaStore {
    private Map<String, ClienteProdutorEmpresa> mapCPE;

    private ArrayList<Pedido> listCabazes;

    public ClienteProdutorEmpresaStore() {
       mapCPE = new HashMap<>();
    }
    public void addCPE(ClienteProdutorEmpresa cpe) {
        mapCPE.put(cpe.getId(), cpe);
    }
    public ClienteProdutorEmpresa getCPE(String id) {
        return mapCPE.get(id);
    }
    public Map<String, ClienteProdutorEmpresa> getMapCPE() {
        return mapCPE;
    }
    public boolean containsCPE(String id) {
        return mapCPE.containsKey(id);
    }
    public void removeCPE(String id) {
        mapCPE.remove(id);
    }
    public void clear() {
        mapCPE.clear();
    }
    public int size() {
        return mapCPE.size();
    }
    public boolean isEmpty() {
        return mapCPE.isEmpty();
    }
    public String toString() {
        return "Size of the map: " + mapCPE.size();
    }

    //get object by locID
    public ClienteProdutorEmpresa getCPEbyID(String locID) {
        for (ClienteProdutorEmpresa cpe : mapCPE.values()) {
            if (cpe.getLocalizacao().getLocID().equals(locID)) {
                return cpe;
            }
        }
        return null;
    }
}
