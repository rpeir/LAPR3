package esinf.domain.WaterController.WaterController;

import Controller.App;
import Controller.ImportWaterControllerController;
import domain.WaterController.Sector;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import static org.junit.Assert.*;

public class WaterControllerTest {

    public void setUP() throws IOException {
        ImportWaterControllerController ctrl = new ImportWaterControllerController();
        ctrl.importWaterController(new File("esinf/WaterControllerFile/rega_exemplo.txt"));
    }

    @Test
    public void currentSector() throws IOException {
        setUP();
        Sector realSector = App.getInstance().getWaterController().currentSector(LocalDateTime.parse("2023-01-30T17:05:10.63"));
        Sector expectedSector = new Sector("a", 10, "t");
        assertEquals(expectedSector, realSector);
    }
}