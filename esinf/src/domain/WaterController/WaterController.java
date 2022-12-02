package domain.WaterController;

import Controller.ImportWaterControllerController;
import store.WaterController.DayStore;
import store.WaterController.SectorStore;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class WaterController {
    private List<LocalTime> wateringTimes;
    private DayStore dayStore;


    public WaterController() {

        this.wateringTimes = new ArrayList<>();
        this.dayStore = new DayStore();
    }
    
    public void addHour(LocalTime time) {
        wateringTimes.add(time);
    }
    

    /**
     * "If the current date is in the watering plan, return the sector that is currently being watered."
     *
     * The function starts by getting the current time from the date. Then it loops through the watering times and sectors
     * in the watering plan. If the current time is between the watering time and the watering time plus the duration of
     * the sector, then the sector is returned
     *
     * @param date the current date and time
     * @return The sector that is currently being watered.
     */
    public Sector currentSector(LocalDateTime date) {
        LocalTime time = date.toLocalTime();
        if (dayStore.getWateringPlan().containsKey(date.toLocalDate())){
            int minutes = 0;
            for (Sector sector : dayStore.getWateringPlan().get(date.toLocalDate())){ //calculate how many minutes each watering cycle takes for that day
                minutes += sector.getDuration();
            }
            for (LocalTime wateringTime : wateringTimes){
                if (time.isAfter(wateringTime) && time.isBefore(wateringTime.plusMinutes(minutes))){
                    for (Sector sector : dayStore.getWateringPlan().get(date.toLocalDate())){
                        if (time.isBefore(wateringTime.plusMinutes(sector.getDuration()))){
                            return sector;
                        }
                        wateringTime = wateringTime.plusMinutes(sector.getDuration());
                    }
                }
            }
        }
        return null;
    }



    /**
     * Return the number of minutes until the sector finishes being watered.
     *
     * @param date the current date and time
     * @return The method returns the number of minutes until the current watering cycle is finished.
     */
    public Integer timeToFinishWateringSector(LocalDateTime date) {
        LocalTime time = date.toLocalTime();
        int minutes = 0;
        for (Sector sector1 : dayStore.getWateringPlan().get(date.toLocalDate())){ //calculate how many minutes each watering cycle takes for that day
            minutes += sector1.getDuration();
        }
        for (LocalTime wateringTime : wateringTimes){
            if (time.isAfter(wateringTime) && time.isBefore(wateringTime.plusMinutes(minutes))){
                for (Sector sector2 : dayStore.getWateringPlan().get(date.toLocalDate())){
                    if (time.isBefore(wateringTime.plusMinutes(sector2.getDuration()))){
                        return Math.toIntExact(time.until(wateringTime.plusMinutes(sector2.getDuration()), ChronoUnit.MINUTES));
                    }
                    wateringTime = wateringTime.plusMinutes(sector2.getDuration());
                }
            }
        }
        return null;
    }

    /**
     * It returns the number of minutes until the next watering cycle is finished, or null if the current time is not
     * within a watering cycle
     *
     * @param date the current date and time
     * @return The time left to finish the watering cycle.
     */
    public Integer timeToFinishWateringCycle(LocalDateTime date) {
        LocalTime time = date.toLocalTime();
        int minutes = 0;
        for (Sector sector1 : dayStore.getWateringPlan().get(date.toLocalDate())){ //calculate how many minutes each watering cycle takes for that day
            minutes += sector1.getDuration();
        }
        for (LocalTime wateringTime : wateringTimes){
            LocalTime tempTime = wateringTime;
            if (time.isAfter(tempTime) && time.isBefore(tempTime.plusMinutes(minutes))){
                for (Sector sector2 : dayStore.getWateringPlan().get(date.toLocalDate())){
                    if (time.isBefore(tempTime.plusMinutes(sector2.getDuration()))){
                        return Math.toIntExact(time.until(wateringTime.plusMinutes(minutes), ChronoUnit.MINUTES));
                    }
                    tempTime = tempTime.plusMinutes(sector2.getDuration());
                }
            }
        }
        return null;
    }

    /**
     * Add days to the day store.
     *
     * @param date The date of the day you want to add.
     * @param sectorStore This is the SectorStore object that contains the data for the day.
     */
    public void addDaysToDayStore(LocalDate date, SectorStore sectorStore) {
        dayStore.addDays(date, sectorStore);
    }


}
