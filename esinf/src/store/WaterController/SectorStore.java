package store.WaterController;

import domain.WaterController.Sector;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SectorStore {
    public Map<String, Sector> sectors;

    public SectorStore(){
        sectors= new HashMap<>();
    }

    public void addSector(Sector sector){
        sectors.put(sector.getName(), sector);
    }

    public Map<String,Sector> getSectors(){
        return sectors;
    }

    public Sector getSector(String name){
        return sectors.get(name);
    }
}
