package store;

import domain.Pedido;
import domain.ListaExpedicoes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ListaExpedicoesStore {
    private Map<Integer, ListaExpedicoes> expedicoes;

    public ListaExpedicoesStore() {
        expedicoes = new HashMap<>();
    }
    public Map<Integer, ListaExpedicoes> getExpedicoes() {
        return expedicoes;
    }
    public void setExpedicoes(Map<Integer, ListaExpedicoes> expedicoes) {
        this.expedicoes = expedicoes;
    }

    public void addExpedicoes(List<ListaExpedicoes> expedicoes) {
        for (ListaExpedicoes exp : expedicoes) {
            this.expedicoes.put(exp.getDiaExpedicao(), exp);
        }
    }
    public void addExpedicao(ListaExpedicoes expedicao) {
        expedicoes.put(expedicao.getDiaExpedicao(), expedicao);
    }
    public void removeExpedicao(ListaExpedicoes expedicao) {
        expedicoes.remove(expedicao.getDiaExpedicao());
    }
    public void removeExpedicao(int dia) {
        expedicoes.remove(dia);
    }
    public int size() {
        return expedicoes.size();
    }
    public ListaExpedicoes getExpedicao(int dia) {
        return expedicoes.get(dia);
    }
    public List<Pedido> getListaExpedicoesDia(int dia, HashMap<Integer,ListaExpedicoes>expedicoes) {
        List<Pedido> listaExpedicoesDia = new ArrayList<>();
        for (Pedido pedido : listaExpedicoesDia) {
            if (pedido.getDiaDeProducao() == dia) {
                listaExpedicoesDia.add(pedido);
            }
        }
        return listaExpedicoesDia;
    }
}

