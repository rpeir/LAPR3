public class ClienteProdutorEmpresa {

    private String LocID;
    private float  latitude;
    private float  longitude;
    private String designacao;

    public ClienteProdutorEmpresa(String LocID, float latitude, float longitude, String designacao) {
        this.LocID = LocID;
        this.latitude = latitude;
        this.longitude = longitude;
        this.designacao = designacao;
    }

    public String getLocID() {
        return LocID;
    }

    public float getLatitude() {
        return latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public String getDesignacao() {
        return designacao;
    }

    @Override
    public String toString() {
        return "ClienteProdutorEmpresa{" + "LocID=" + LocID + ", latitude=" + latitude + ", longitude=" + longitude + ", designacao=" + designacao + '}';
    }
}
