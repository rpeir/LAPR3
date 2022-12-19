package domain;

import java.util.List;
import java.util.Objects;

public class Cabaz {

    private String clienteProdutorEmpresa;

    private int diaDeProducao;

    private List<Float> produtos;
    // private List<ProdutorProduto> produtos;
    public Cabaz(String clienteProdutorEmpresa, int diaDeProducao, List<Float> produtos) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = produtos;
    }

    List<Float> getProdutos() {
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
        Cabaz cabaz = (Cabaz) o;
        return getDiaDeProducao() == cabaz.getDiaDeProducao() && Objects.equals(clienteProdutorEmpresa, cabaz.clienteProdutorEmpresa) && Objects.equals(getProdutos(), cabaz.getProdutos());
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
}

