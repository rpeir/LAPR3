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

    public List<Float> getProdutos() {
        TreeMap<Integer, Float> produtos = new TreeMap<>();
        for (ClienteProdutorEmpresa produtor : produtorProdutos.keySet()) {
            for (AbstractMap.SimpleEntry<String, Float> produto : produtorProdutos.get(produtor)) {
                int key = Integer.parseInt(produto.getKey().substring(7));
                if (produtos.containsKey(key))
                    produtos.put(key, produtos.get(key) + produto.getValue());
                else
                    produtos.put(key, produto.getValue());
            }
        }
        return produtos.values().stream().toList();
    }

    /**
     * Return -1 if the cabaz is not satisfied, 0 if partially satisfied and 1 if fully satisfied, reciving the list of products of one cabaz and one pedido
     * @param produtos1 the list of products of the cabaz
     * @param produtos2 the list of products of the pedido
     * @return -1 if the cabaz is not satisfied, 0 if partially satisfied and 1 if fully satisfied
     */
    public static int satisfiedCabaz(List<Float> produtos1, List<Float> produtos2) {
        boolean diffCatched = false;
        for (int i = 0; i < produtos1.size(); i++) {
            if (produtos1.get(i).compareTo(produtos2.get(i)) != 0) {
                diffCatched = true;
            } else {
                if (diffCatched)
                    return 0;
            }
        }
        return diffCatched? -1 : 1;
    }

    /**
     * Return -1 if the cabaz is not satisfied, 0 if partially satisfied and 1 if fully satisfied, reciving the list of products of the pedido
     * @param produtos the list of products of the pedido
     * @return -1 if the cabaz is not satisfied, 0 if partially satisfied, 1 if fully satisfied
     */
    public int satisfiedCabaz(List<Float> produtos) {
        return satisfiedCabaz(this.getProdutos(), produtos);
    }

    /**
     * Gets a list of the cabaz's different produtores
     * @return the cabaz's different produtores
     */
    public List<String> getDiffProdutores() {
        HashSet<String> produtores = new HashSet<>();
        for (ClienteProdutorEmpresa produtor : produtorProdutos.keySet()) {
            produtores.add(produtor.getId());
        }
        return produtores.stream().toList();
    }
}
