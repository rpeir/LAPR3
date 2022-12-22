package domain;

import java.util.List;
import java.util.Objects;

public class Pedido extends Cabaz{

    public Pedido(String clienteProdutorEmpresa, int diaDeProducao, List<Float> produtos) {
        super(clienteProdutorEmpresa, diaDeProducao, produtos);
    }

}

