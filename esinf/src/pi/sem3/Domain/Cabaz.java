import java.util.ArrayList;

public class Cabaz {

    private ClienteProdutorEmpresa clienteProdutorEmpresa;

    private String diaDeProducao;

    private ArrayList<Produto> produtos;

    public Cabaz(ClienteProdutorEmpresa clienteProdutorEmpresa, String diaDeProducao, ArrayList<Produto> produtos) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = produtos;
    }

    private ArrayList<Produto> getProdutos() {
        return produtos;
    }

    public ClienteProdutorEmpresa getClienteProdutor() {
        return clienteProdutorEmpresa;
    }

    public String getDiaDeProducao() {
        return diaDeProducao;
    }
}
