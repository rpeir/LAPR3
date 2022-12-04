package UI;

import Controller.App;
import Controller.HubsDistributionController;

import java.util.Scanner;

public class HubsDistributionUI {

    App app;
    HubsDistributionController ctrl = new HubsDistributionController();

    public HubsDistributionUI() {
        app = App.getInstance();
    }

    public void run() {

        int n;
        Scanner sc = new Scanner(System.in);
        System.out.println("\nIntroduza o numero de hubs que pretende definir: ");
        n = sc.nextInt();
        System.out.println("\nHubs mais proximos: ");
        ctrl.getMediaDistancia(app.getGraph(), n);

    }
}
