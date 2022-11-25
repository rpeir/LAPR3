package pi.sem3.esinf.domain;

import java.util.List;

public class Cabaz {

    private ClienteProdutorEmpresa clienteProdutorEmpresa;

    private String diaDeProducao;

    private List<Produto> produtos;

    public Cabaz(ClienteProdutorEmpresa clienteProdutorEmpresa, String diaDeProducao, List<Produto> produtos) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = produtos;
    }

    private List<Produto> getProdutos() {
        return produtos;
    }

    public ClienteProdutorEmpresa getClienteProdutor() {
        return clienteProdutorEmpresa;
    }

    public String getDiaDeProducao() {
        return diaDeProducao;
    }
}
