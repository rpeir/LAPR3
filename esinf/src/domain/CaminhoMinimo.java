package domain;

import java.util.List;

public class CaminhoMinimo {
    private ClienteProdutorEmpresa produtor;
    private List<Localizacao> totalPath;
    int distanciaTotal;
    List<Integer> distancias;

    public CaminhoMinimo(ClienteProdutorEmpresa produtor, List<Localizacao> totalPath, int distanciaTotal, List<Integer> distancias) {
        this.produtor = produtor;
        this.totalPath = totalPath;
        this.distanciaTotal = distanciaTotal;
        this.distancias = distancias;
    }

    public ClienteProdutorEmpresa getProdutor() {
        return produtor;
    }

    public List<Localizacao> getTotalPath() {
        return totalPath;
    }

    public int getDistanciaTotal() {
        return distanciaTotal;
    }

    public List<Integer> getDistancias() {
        return distancias;
    }

    public void setProdutor(ClienteProdutorEmpresa produtor) {
        this.produtor = produtor;
    }

    public void setTotalPath(List<Localizacao> totalPath) {
        this.totalPath = totalPath;
    }

    public void setDistanciaTotal(int distanciaTotal) {
        this.distanciaTotal = distanciaTotal;
    }

    public void setDistancias(List<Integer> distancias) {
        this.distancias = distancias;
    }
}
