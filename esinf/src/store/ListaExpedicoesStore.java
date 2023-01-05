package store;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;

import java.util.*;

public class ListaExpedicoesStore {
    private Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> expedicoes;
    private Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> expedicaoNumDia;

    public ListaExpedicoesStore() {
        expedicoes = new HashMap<>();
        expedicaoNumDia = new HashMap<>();
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

    public void setExpedicaoNumDia(Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> expedicaoNumDia) {
        this.expedicaoNumDia = expedicaoNumDia;
    }

    public Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> getExpedicaoNumDia() {
        return expedicaoNumDia;
    }

}

