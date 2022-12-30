package store;

import Controller.App;
import Controller.ClosestHubController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;
import domain.ListaExpedicoes;

import java.util.*;

public class ListaExpedicoesStore {
    private Map<Integer, ListaExpedicoes> expedicoes;
    ClienteProdutorEmpresaStore cpeStore;
    App app;
    ClosestHubController closestHubController;

    public ListaExpedicoesStore() {
        app = App.getInstance();
        expedicoes = new HashMap<>();
        cpeStore = app.getClienteProdutorEmpresaStore();
        closestHubController = new ClosestHubController();
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
    public static List<Pedido> getListaExpedicoesDia(int dia, HashMap<Integer, ListaExpedicoes> expedicoes) {
        List<Pedido> listaExpedicoesDia = new ArrayList<>();
        for (Pedido pedido : listaExpedicoesDia) {
            if (pedido.getDiaDeProducao() == dia) {
                listaExpedicoesDia.add(pedido);
            }
        }
        return listaExpedicoesDia;
    }

    public List<Cabaz> cabazesASerEntregues(int dia, String idHub, String idProd) {
        List<Cabaz> cabazesASerEntregues = new ArrayList<>();
        ListaExpedicoes espedicaoDia = expedicoes.get(dia);
        List<Cabaz> cabazesDestaExp = espedicaoDia.get_listaExpedicoes();
        List<Cabaz> cabazesDestaExpNesteHub = new ArrayList<>();
        for (Cabaz cabaz : cabazesDestaExp) {
            ClienteProdutorEmpresa cliente = cpeStore.getCPE(cabaz.getClienteProdutor());
            ClienteProdutorEmpresa hubDoCliente = closestHubController.getClosestHub(cliente);
            if(hubDoCliente.getId().equals(idHub)) {
                cabazesDestaExpNesteHub.add(cabaz);
            }

        }
        for (Cabaz cabaz : cabazesDestaExpNesteHub) {
            List<String> produtoresCabaz = cabaz.getProdutores();
            for(String prod : produtoresCabaz) {
                if(prod.equals(idProd) && !cabazesASerEntregues.contains(cabaz)) {
                    cabazesASerEntregues.add(cabaz);
                }
            }

        }

        return cabazesASerEntregues;
    }
}

