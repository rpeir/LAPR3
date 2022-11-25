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

    @Override
    public String toString() {
        return "Distancia{" + "LocID1=" + LocID1 + ", LocID2=" + LocID2 + ", length=" + length + '}';
    }
}
