package domain;

import java.util.List;
import java.util.Objects;

public class Cabaz extends Pedido{

    private List<String> produtores;

    public Cabaz(String clienteProdutorEmpresa, int diaDeProducao, List<Float> produtos, List<String> produtores) {
        super(clienteProdutorEmpresa, diaDeProducao, produtos);
        this.produtores = produtores;
    }

    public List<String> getProdutores() {
        return produtores;
    }

    public void setProdutores(List<String> produtores) {
        this.produtores = produtores;
    }

    public String getProdutor(int i){
        return produtores.get(i);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Cabaz cabaz = (Cabaz) o;
        return Objects.equals(getProdutores(), cabaz.getProdutores());
    }

    public boolean isSatisfied(Pedido pedido){
        List<Float> thisProdutos = this.getProdutos();
        List<Float> pedidoProdutos = pedido.getProdutos();
        for (int i = 0; i < thisProdutos.size(); i++) {
            if (!thisProdutos.get(i).equals(pedidoProdutos.get(i))) return false;
        }
        return true;
    }

    public boolean isPartillySatisfied(Pedido pedido){
        List<Float> thisProdutos = this.getProdutos();
        List<Float> pedidoProdutos = pedido.getProdutos();
        int count = 0;
        for (int i = 0; i < thisProdutos.size(); i++) {
            if (!thisProdutos.get(i).equals(pedidoProdutos.get(i))) count++;
        }
        return count > 0 && count < thisProdutos.size();
    }


    public boolean isSatisfiedByProdutor(ClienteProdutorEmpresa produtor){
        List<String> thisProdutores = this.getProdutores();
        for (String thisProdutor : thisProdutores) {
            if (!thisProdutor.equals(produtor.getId())) return false;
        }
        return true;
    }

    public boolean isPartillySatisfiedByProdutor(ClienteProdutorEmpresa produtor){
        List<String> thisProdutores = this.getProdutores();
        int count = 0;
        for (String thisProdutor : thisProdutores) {
            if (thisProdutor.equals(produtor.getId())) count++;
        }
        return count > 0 && count < thisProdutores.size();
    }

    @Override
    public void toString(StringBuilder sb) {
        sb.append("Cabaz{");
        sb.append("cliente=").append(getClienteProdutor());
        sb.append('}');
    }
}
