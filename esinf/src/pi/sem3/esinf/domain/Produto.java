package esinf_sem3_pi.domain;
public class Produto {

    double id;

    public Produto(double id) {
        this.id = id;
    }

    public double getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Produto{" + "id=" + id + '}';
    }
}
