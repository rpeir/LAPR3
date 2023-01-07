package domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Pedido {

    private String clienteProdutorEmpresa;

    private int diaDeProducao;

    private List<Float> produtos;

    public Pedido(String clienteProdutorEmpresa, int diaDeProducao, List<Float> produtos) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = produtos;
    }

    public Pedido(Pedido pedido) {
        this.clienteProdutorEmpresa = pedido.getClienteProdutor();
        this.diaDeProducao = pedido.getDiaDeProducao();
        this.produtos = new ArrayList<>(pedido.getProdutos());
    }

    public List<Float> getProdutos() {
        return produtos;
    }

    public String getClienteProdutor() {
        return clienteProdutorEmpresa;
    }

    public int getDiaDeProducao() {
        return diaDeProducao;
    }

    public void setClienteProdutorEmpresa(String clienteProdutorEmpresa) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
    }

    public void setDiaDeProducao(int diaDeProducao) {
        this.diaDeProducao = diaDeProducao;
    }

    public void setProdutos(List<Float> produtos) {
        this.produtos = produtos;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pedido pedido = (Pedido) o;
        return getDiaDeProducao() == pedido.getDiaDeProducao() && Objects.equals(clienteProdutorEmpresa, pedido.clienteProdutorEmpresa) && Objects.equals(getProdutos(), pedido.getProdutos());
    }

    @Override
    public int hashCode() {
        return Objects.hash(clienteProdutorEmpresa, getDiaDeProducao());
    }

    @Override
    public String toString() {
        return String.format("%s, dia %d", clienteProdutorEmpresa, diaDeProducao);
    }

    public Float getProduto(int i) {
        return produtos.get(i);
    }

    public void setProdutoByIndex(int index, float qtd){
        produtos.set(index,qtd);
    }

}

