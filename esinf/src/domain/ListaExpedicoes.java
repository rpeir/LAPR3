package domain;

import java.awt.*;
import java.util.ArrayList;
import java.util.RandomAccess;

public class ListaExpedicoes {
    private ArrayList<ListaExpedicoes> listaExpedicoes;

    public ListaExpedicoes() {
        listaExpedicoes = new ArrayList<>();
    }
    public ArrayList<ListaExpedicoes> get_listaExpedicoes() {
        return listaExpedicoes;
    }
    public void set_listaExpedicoes(ArrayList<ListaExpedicoes> listaExpedicoes) {
        this.listaExpedicoes = listaExpedicoes;
    }
    public void addExpedicao(ListaExpedicoes expedicao) {
        listaExpedicoes.add(expedicao);
    }
    public void removeExpedicao(ListaExpedicoes expedicao) {
        listaExpedicoes.remove(expedicao);
    }
    public void removeExpedicao(int index) {
        listaExpedicoes.remove(index);
    }
    public int size() {
        return listaExpedicoes.size();
    }
    public ListaExpedicoes getExpedicao(int index) {
        return listaExpedicoes.get(index);
    }
}
