package domain;

import java.util.*;
import java.util.regex.Pattern;

public class ClienteProdutorEmpresa {

    private Localizacao localizacao;

    private String designacao;

    private String id;

    private boolean empresa;

    private boolean hub;
    private boolean flag;

    private Map<Integer, Pedido> cabazes;
    public ClienteProdutorEmpresa(Localizacao localizacao, String id, String designacao) {
        this.empresa=false;
        this.localizacao = localizacao;
        this.designacao = designacao;
        setId(id);
        this.hub = false;
        this.flag = false;
        this.cabazes = new HashMap<>();
    }

    public ClienteProdutorEmpresa(Localizacao localizacao,String id) {
        this.empresa=false;
        setId(id);
        this.localizacao = localizacao;
        this.designacao=id;
        this.hub = false;
        this.cabazes = new HashMap<>();
    }

    public ClienteProdutorEmpresa(String locId, float latitude, float longitude,String id, String designacao) {
        this.empresa=false;
        setLocalizacao(locId, longitude, latitude);
        this.designacao = designacao;
        setId(id);
        this.hub = false;
        this.flag = false;
        this.cabazes = new HashMap<>();
    }

    public ClienteProdutorEmpresa(String locId, float latitude, float longitude, String id) {
        this.empresa=false;
        setLocalizacao(locId, longitude, latitude);
        this.designacao = id;
        setId(id);
        this.hub = false;
        this.flag = false;
        this.cabazes = new HashMap<>();
    }

    public Localizacao getLocalizacao() {
        return localizacao;
    }

    public String getDesignacao() {
        return designacao;
    }

    public String getId() {
        return id;
    }

    public void setLocalizacao(Localizacao localizacao) {
        this.localizacao = localizacao;
    }

    public void setLocalizacao(String locId, float longitude, float latitude) {
        this.localizacao = new Localizacao(locId, longitude, latitude);
    }

    public void setDesignacao(String designacao) {
        this.designacao = designacao;
    }

    public void setId(String id) {
        if (validateEmpresaID(id)) {
            this.empresa=true;
        } else if (!validateClienteID(id) && !validateProdutorID(id)) {
            throw new IllegalArgumentException("Invalid ID: does not match pattern [CPE][0-9]+]");
        }
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClienteProdutorEmpresa that = (ClienteProdutorEmpresa) o;
        return Objects.equals(getLocalizacao(), that.getLocalizacao()) && Objects.equals(getDesignacao(), that.getDesignacao()) && getId().equals(that.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

    @Override
    public String toString() {
        return designacao.equals(id)?id:String.format("%s (%s)", id, designacao);
    }

    public boolean isEmpresa() {
        return empresa;
    }

    public boolean isSatisfied() {
        return flag;
    }

    public void setEmpresa(boolean bool) {
        this.empresa = bool;
    }

    public void setNotHub() {
        this.hub = false;
    }

    public boolean isHub() {
        return hub;
    }

    public void setHub() {
        if (this.empresa) {
            this.hub = true;
        }else{
            throw new IllegalArgumentException("Only companies can be hubs.");
        }
    }

    public boolean isCliente() {
        return validateClienteID(this.id);
    }

    public boolean isProdutor() {
        return validateProdutorID(this.id);
    }

    public static boolean validateEmpresaID(String id) {
        return Pattern.matches("E[0-9]+", id);
    }

    public static boolean validateProdutorID(String id) {
        return Pattern.matches("P[0-9]+", id);
    }

    public static boolean validateClienteID(String id) {
        return Pattern.matches("C[0-9]+", id);
    }

    public void setCabaz(Pedido pedido){
        this.cabazes.put(pedido.getDiaDeProducao()-1, pedido);
    }
    public List<Pedido> getCabazes(){
        return this.cabazes.values().stream().toList();
    }
    public void setCabazes(List<Pedido> cabazes){
        for (Pedido cabaz : cabazes) {
            this.cabazes.put(cabaz.getDiaDeProducao()-1, cabaz);
        }
    }
    public Pedido getCabaz(int dia){
        return this.cabazes.get(dia-1);
    }


}
