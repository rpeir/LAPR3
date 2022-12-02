package Controller;

import domain.WaterController.Sector;

import java.io.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class ImportWaterControllerController {


    /**
     * It reads a file and creates a WaterController object and a list of Sector objects
     *
     * @param filename the file to be imported
     */
    public void importWaterController(File filename) throws IOException {
        DateTimeFormatter parser = DateTimeFormatter.ofPattern("H:m");
        BufferedReader br = new BufferedReader(new FileReader(filename));
        String hours = br.readLine();
        hours = hours.replaceAll("\\s","");
        String[] hoursArray = hours.split(",");
        for (String hour: hoursArray) {
            App.getInstance().getWaterController().addHour(LocalTime.parse(hour, parser));
        }
        String line = br.readLine();
        while (line != null) {
            line = line.replaceAll("\\s","");
            String[] values = line.split(",");
            String sectorName = values[0];
            String sectorDuration = values[1];
            String sectorRegularity = values[2];
            App.getInstance().getSectorStore().addSector(new Sector(sectorName, Integer.parseInt(sectorDuration), sectorRegularity));
            line = br.readLine();
        }
        br.close();
        // Create a plan for the next 30 days in the WaterController object
        LocalDate now = LocalDate.now();
        App.getInstance().getWaterController().addDaysToDayStore(now, App.getInstance().getSectorStore());

    }
}
