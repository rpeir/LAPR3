package store;

import domain.Pedido;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class Stock {

    private Map<Integer, List<Pedido>> stockMap;

    public Stock() {
        this.stockMap = new TreeMap<>();
    }

    public void insertStock(Pedido pedido){
        if(stockMap.containsKey(pedido.getDiaDeProducao()))
            stockMap.get(pedido.getDiaDeProducao()).add(pedido);
        else {
            List<Pedido> tempList = new ArrayList<>();
            tempList.add(pedido);
            stockMap.put(pedido.getDiaDeProducao(),tempList);
        }
    }

    public Map<Integer, List<Pedido>> getStockMap() {
        return stockMap;
    }
    public  Pedido  getStockByProdutor(int dia, String produtor){
        for (Pedido stock: stockMap.get(dia)) {
            if (stock.getClienteProdutor().equals(produtor))
                return stock;
        }
        return null;
    }
}
