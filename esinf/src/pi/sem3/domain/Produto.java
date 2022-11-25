package pi.sem3.domain;

public class Produto {

    int id;

    public Produto(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Produto{" + "id=" + id + '}';
    }
}
