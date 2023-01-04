package store;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;

import java.util.*;

public class ListaExpedicoesStore {
    private Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> expedicoes;

    public ListaExpedicoesStore() {
        expedicoes = new HashMap<>();
    }
    public Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> getExpedicoes() {
        return expedicoes;
    }
    public void setExpedicoes(Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> expedicoes) {
        this.expedicoes = expedicoes;
    }

    public int size() {
        return expedicoes.size();
    }

}

