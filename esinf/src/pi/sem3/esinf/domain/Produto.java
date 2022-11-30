package pi.sem3.esinf.domain;

import java.util.Objects;

public class Produto {

    private double id;

    public Produto(double id) {
        this.id = id;
    }

    public double getId() {
        return id;
    }

    public void setId(double id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Produto{" + "id=" + id + '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Produto produto = (Produto) o;
        return Double.compare(produto.getId(), getId()) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
