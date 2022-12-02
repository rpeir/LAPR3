package domain;

import java.util.Objects;
import java.util.regex.Pattern;

public class ClienteProdutorEmpresa {

    private Localizacao localizacao;

    private String designacao;

    private String id;

    private boolean empresa;

    private boolean hub;

    public ClienteProdutorEmpresa(Localizacao localizacao, String id, String designacao) {
        this.localizacao = localizacao;
        this.designacao = designacao;
        setId(id);
        this.empresa = validateEmpresaID(id);
        this.hub = false;
    }

    public ClienteProdutorEmpresa(Localizacao localizacao,String id) {
        setId(id);
        this.localizacao = localizacao;
        this.designacao=id;
        this.empresa =validateEmpresaID(id);
        this.hub = false;
    }

    public ClienteProdutorEmpresa(String locId, float latitude, float longitude,String id, String designacao) {
        setLocalizacao(locId, longitude, latitude);
        this.designacao = designacao;
        setId(id);
        this.empresa = validateEmpresaID(id);
        this.hub = false;
    }

    public ClienteProdutorEmpresa(String locId, float latitude, float longitude, String id) {
        setLocalizacao(locId, longitude, latitude);
        this.designacao = id;
        setId(id);
        this.empresa = validateEmpresaID(id);
        this.hub = false;
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
        }
       throw new IllegalArgumentException("Apenas empresas podem ser um hub");
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
}
