package esinf_sem3_pi.domain;

public class ClienteProdutorEmpresa {

    private String LocID;
    private float  latitude;
    private float  longitude;
    private Cabaz cabaz;

    public ClienteProdutorEmpresa(String LocID, float latitude, float longitude, Cabaz designacao) {
        this.LocID = LocID;
        this.latitude = latitude;
        this.longitude = longitude;
        this.cabaz = designacao;
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

    public Cabaz getCabaz() {
        return cabaz;
    }

    public void setCabaz(Cabaz cabaz) {
        this.cabaz = cabaz;
    }

    @Override
    public String toString() {
        return "ClienteProdutorEmpresa{" + "LocID=" + LocID + ", latitude=" + latitude + ", longitude=" + longitude + ", designacao=" + cabaz + '}';
    }
}
