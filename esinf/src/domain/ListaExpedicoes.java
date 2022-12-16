package domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ListaExpedicoes {
    int diaExpedicao;
    private List<Cabaz> listaExpedicoes;

    public ListaExpedicoes(int dia) {
        this.listaExpedicoes = new ArrayList<>();
        this.diaExpedicao = dia;
    }

    public int getDiaExpedicao() {
        return diaExpedicao;
    }

    public boolean checkDiaExpedicao(Cabaz expedicao) {
        return expedicao.getDiaDeProducao()==diaExpedicao;
    }

    public void setDiaExpedicao(int diaExpedicao) {
        this.diaExpedicao = diaExpedicao;
    }

    public List<Cabaz> get_listaExpedicoes() {
        return listaExpedicoes;
    }
    public void set_listaExpedicoes(ArrayList<Cabaz> listaExpedicoes) {
        this.listaExpedicoes = listaExpedicoes;
    }
    public void addExpedicao(Cabaz expedicao) {
        listaExpedicoes.add(expedicao);
    }
    public void removeExpedicao(Cabaz expedicao) {
        listaExpedicoes.remove(expedicao);
    }
    public void removeExpedicao(int index) {
        listaExpedicoes.remove(index);
    }
    public int size() {
        return listaExpedicoes.size();
    }
    public Cabaz getExpedicao(int index) {
        return listaExpedicoes.get(index);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ListaExpedicoes that = (ListaExpedicoes) o;
        return diaExpedicao == that.diaExpedicao && Objects.equals(listaExpedicoes, that.listaExpedicoes);
    }

    @Override
    public int hashCode() {
        return Objects.hash(diaExpedicao);
    }
}
