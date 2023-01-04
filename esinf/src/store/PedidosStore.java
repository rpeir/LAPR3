package store;

import domain.Pedido;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class PedidosStore {

    private Map<Integer, List<Pedido>> pedidoMap;

    public PedidosStore() {
        this.pedidoMap = new TreeMap<>();
    }

    public void insertPedido(Pedido pedido){
        if (pedidoMap.containsKey(pedido.getDiaDeProducao()))
            pedidoMap.get(pedido.getDiaDeProducao()).add(pedido);
        else{
            List<Pedido> tempList = new ArrayList<>();
            tempList.add(pedido);
            pedidoMap.put(pedido.getDiaDeProducao(),tempList);
        }
    }

    public Map<Integer, List<Pedido>> getPedidoMap() {
        return pedidoMap;
    }
}
