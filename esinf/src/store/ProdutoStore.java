package store;

import domain.Produto;

import java.util.ArrayList;
import java.util.List;

public class ProdutoStore {

    public List<Produto> produtos;

    public ProdutoStore() {
        produtos = new ArrayList<>();
    }

    public void addProduto(Produto produto) {
        produtos.add(produto);
    }

    public List<Produto> getProdutos() {
        return produtos;
    }

    public void setProdutos(List<Produto> produtos) {
        this.produtos = produtos;
    }
    public void setNProdutos(int n){
        produtos.clear();
        for(int i = 0; i < n; i++){
            produtos.add(new Produto("Prod " + i));
        }
    }
    public Produto getProduto(int i){
        return produtos.get(i);
    }

}