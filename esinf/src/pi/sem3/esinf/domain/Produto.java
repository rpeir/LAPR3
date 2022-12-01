package pi.sem3.esinf.domain;

import java.util.Objects;

public class Produto {

    private String id;

    public Produto(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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
        return (produto.getId().equals(getId()));
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
