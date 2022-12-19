package domain;

public class ProdutorProduto {

    private ClienteProdutorEmpresa produtor;
    private Produto produto;

    private float quantidadePedida;
    private float quantidadeEntregue;

    public ProdutorProduto(ClienteProdutorEmpresa produtor, Produto produto, float quantidadePedida, float quantidadeEntregue) {
        this.produtor = produtor;
        this.produto = produto;
        this.quantidadePedida = quantidadePedida;
        this.quantidadeEntregue = quantidadeEntregue;
    }

    public ClienteProdutorEmpresa getProdutor() {
        return produtor;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProdutor(ClienteProdutorEmpresa produtor) {
        this.produtor = produtor;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }
}
