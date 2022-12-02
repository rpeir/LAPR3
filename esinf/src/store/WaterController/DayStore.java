package store.WaterController;

import domain.WaterController.Sector;

import java.time.LocalDate;
import java.util.*;

public class DayStore {
    Map<LocalDate, List<Sector>> wateringPlan;

    public DayStore() {
        wateringPlan = new TreeMap<>();
    }

    public Map<LocalDate, List<Sector>> getWateringPlan() {
        return wateringPlan;
    }

    /**
     * This function adds 30 days to the watering plan, and for each day, it checks if the sector is watered that day, and
     * if so, it adds the sector to the watering plan
     *
     * @param date the date to start adding days to the watering plan
     * @param sectorStore a SectorStore object that contains all the sectors
     */
    public void addDays(LocalDate date, SectorStore sectorStore) {
        LocalDate endDate = date.plusDays(30);
        while (date.isBefore(endDate)){ //while date is before 30 days from now
            List<Sector> sectorsInDay= new ArrayList<>();
            for (Sector sector : sectorStore.getSectors().values()){
                if (sector.getRegularity().equals("t")){ //all days
                    sectorsInDay.add(sector);
                } else if (sector.getRegularity().equals("i") && date.getDayOfMonth() % 2 != 0) { //odd days
                    sectorsInDay.add(sector);
                } else if (sector.getRegularity().equals("p") && date.getDayOfMonth() % 2 == 0) { //even days
                    sectorsInDay.add(sector);
                } //else sector is not watered that day
            }
            wateringPlan.put(date, sectorsInDay);
            date = date.plusDays(1);
        }
    }
}
