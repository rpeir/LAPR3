package esinf_sem3_pi.domain;

public class Distancia {

    private ClienteProdutorEmpresa LocID1;
    private ClienteProdutorEmpresa LocID2;
    private int length;

    public Distancia(ClienteProdutorEmpresa LocID1, ClienteProdutorEmpresa LocID2, int length) {
        this.LocID1 = LocID1;
        this.LocID2 = LocID2;
        this.length = length;
    }

    public ClienteProdutorEmpresa getLocID1() {
        return LocID1;
    }

    public ClienteProdutorEmpresa getLocID2() {
        return LocID2;
    }

    public int getLength() {
        return length;
    }

    public void setLocID1(ClienteProdutorEmpresa LocID1) {
        this.LocID1 = LocID1;
    }

    public void setLocID2(ClienteProdutorEmpresa LocID2) {
        this.LocID2 = LocID2;
    }

    @Override
    public String toString() {
        return "Distancia{" + "LocID1=" + LocID1 + ", LocID2=" + LocID2 + ", length=" + length + '}';
    }
}
