package domain;

import java.util.*;

public class Cabaz {

    private String cliente;

    private Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtorProdutos;

    public Cabaz(String cliente, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtorProdutos) {
        this.cliente = cliente;
        this.produtorProdutos = produtorProdutos;
    }

    public Cabaz(String cliente) {
        this.cliente = cliente;
        produtorProdutos = new HashMap<>();
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> getProdutorProdutos() {
        return produtorProdutos;
    }

    public void setProdutorProdutos(Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtorProdutos) {
        this.produtorProdutos = produtorProdutos;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cabaz cabaz = (Cabaz) o;
        return Objects.equals(getCliente(), cabaz.getCliente()) && Objects.equals(getProdutorProdutos(), cabaz.getProdutorProdutos());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getCliente());
    }

    @Override
    public String toString() {
        return "Cabaz de " + cliente;
    }

    public boolean containsKey(ClienteProdutorEmpresa key) {
        return produtorProdutos.containsKey(key);
    }

    public List<AbstractMap.SimpleEntry<String, Float>> get(ClienteProdutorEmpresa key) {
        return produtorProdutos.get(key);
    }

    public void put(ClienteProdutorEmpresa key, List<AbstractMap.SimpleEntry<String, Float>> value) {
        produtorProdutos.put(key, value);
    }

}
