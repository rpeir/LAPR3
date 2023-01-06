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

    public void insertUpdatedStock(List<Pedido> updatedStock){
        for (int i = 0; i < updatedStock.size(); i++) {
            if(stockMap.containsKey(updatedStock.get(i).getDiaDeProducao()))
                stockMap.get(updatedStock.get(i).getDiaDeProducao()).add(updatedStock.get(i));
            else {
                List<Pedido> tempList = new ArrayList<>();
                tempList.add(updatedStock.get(i));
                stockMap.put(updatedStock.get(i).getDiaDeProducao(),tempList);
            }
        }
    }

    public Map<Integer, List<Pedido>> getStockMap() {
        return stockMap;
    }
}
