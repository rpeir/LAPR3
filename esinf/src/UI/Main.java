package UI;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        boolean run = true;
        Scanner sc = new Scanner(System.in);

        System.out.print("BEM-VINDO/A!");
        while (run) {
            System.out.println("\nSelecione uma opcao:\n");
            System.out.println("1 - Carregar informacao a partir de ficheiros CSV");
            System.out.println("2 - Verificar se o grafo e conexo e o nr minimo de conexoes para chegar dum vertice a qualquer outro ");
            System.out.println("3 - Definir os hubs da rede de distribuicao");
            System.out.println("4 - Determinar o hub mais proximo para cada cliente");
            System.out.println("5 - Determinar a rede que conecte todos os clientes e produtores com uma distancia total minima");
            System.out.println("6 - Controlador de rega");
            System.out.println("0 - Sair");
            String opcao = sc.nextLine();

            switch (opcao) {
                case "1":
                    ImportCSVUI importCSVUI = new ImportCSVUI();
                    importCSVUI.run();
                    break;
                case "2":
                    ConnectionsUI connectionsUI = new ConnectionsUI();
                    connectionsUI.run();
                    break;
                case "3":
                    HubsDistribuicaoUI hubsDistribuicaoUI = new HubsDistribuicaoUI();
                    hubsDistribuicaoUI.run();
                    break;
                case "4":
                    ClosestHubUI closestHubUI = new ClosestHubUI();
                    closestHubUI.run();
                    break;
                case "5":
                    MSTNetworkUI mstNetworkUI = new MSTNetworkUI();
                    mstNetworkUI.run();
                    break;
                case "6":
                    ImportWaterControllerUI importWaterControllerUI = new ImportWaterControllerUI();
                    importWaterControllerUI.run();
                    break;
                case "0":

                    run = false;
                    break;
                default:
                    System.out.println("\nOPCAO INVALIDA");
                    break;
            }
        }

    }
}
