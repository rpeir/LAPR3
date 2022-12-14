package store;

import domain.ListaExpedicoes;

public class ListaExpedicoesStore {
    private ListaExpedicoes listaExpedicoes;

    public ListaExpedicoesStore() {
        listaExpedicoes = new ListaExpedicoes();
    }
    public ListaExpedicoes get_listaExpedicoes() {
        return listaExpedicoes;
    }
    public void set_listaExpedicoes(ListaExpedicoes listaExpedicoes) {
        this.listaExpedicoes = listaExpedicoes;
    }
    public void addExpedicao(ListaExpedicoes expedicao) {
        listaExpedicoes.addExpedicao(expedicao);
    }
    public void removeExpedicao(ListaExpedicoes expedicao) {
        listaExpedicoes.removeExpedicao(expedicao);
    }
    public void removeExpedicao(int index) {
        listaExpedicoes.removeExpedicao(index);
    }
    public int size() {
        return listaExpedicoes.size();
    }
    public ListaExpedicoes getExpedicao(int index) {
        return listaExpedicoes.getExpedicao(index);
    }
}

