package domain;

import java.util.List;

public class Cabaz {

    private String clienteProdutorEmpresa;

    private int diaDeProducao;

    private List<Produto> produtos;

    public Cabaz(String clienteProdutorEmpresa, int diaDeProducao, List<Produto> produtos) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = produtos;
    }

    private List<Produto> getProdutos() {
        return produtos;
    }

    public String getClienteProdutor() {
        return clienteProdutorEmpresa;
    }

    public int getDiaDeProducao() {
        return diaDeProducao;
    }
}
