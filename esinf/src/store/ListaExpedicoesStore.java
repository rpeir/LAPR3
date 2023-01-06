package store;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

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

    public void setExpedicaoNumDia(Map<ClienteProdutorEmpresa, Cabaz> expedicaoNumDia, int dia) {
        this.expedicoes.put(dia, expedicaoNumDia);
    }

    public Map<ClienteProdutorEmpresa, Cabaz> getExpedicaoNumDia(int dia) {
        return this.expedicoes.get(dia);
    }

}

