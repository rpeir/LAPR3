import java.util.ArrayList;

public class Cabaz {

    private ClienteProdutorEmpresa clienteProdutorEmpresa;

    private String diaDeProducao;

    private ArrayList<Produto> produtos;

    public Cabaz(ClienteProdutorEmpresa clienteProdutorEmpresa, String diaDeProducao, Produto p1, Produto p2, Produto p3, Produto p4, Produto p5, Produto p6, Produto p7, Produto p8, Produto p9, Produto p10, Produto p11, Produto p12, Produto p13, Produto p14, Produto p15, Produto p16, Produto p17, Produto p18, Produto p19, Produto p20) {
        this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        this.diaDeProducao = diaDeProducao;
        this.produtos = new ArrayList<>();
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
