package pi.sem3.esinf.Controller;

import pi.sem3.esinf.UI.MSTNetworkUI;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        boolean run = true;
        Scanner sc = new Scanner(System.in);

        System.out.print("BEM-VINDO/A!");
        while (run) {
            System.out.println("\nSelecione uma opcao:\n");
            System.out.println("1 - Carregar informacao a partir de ficheiros CSV");
            System.out.println("2 - ");
            System.out.println("3 - ");
            System.out.println("4 - ");
            System.out.println("5 - Determinar a rede que conecte todos os clientes e produtores com uma distancia total minima");
            System.out.println("0 - Sair");
            String opcao = sc.nextLine();

            switch (opcao) {
                case "1":

                    break;
                case "2":

                    break;
                case "3":

                    break;
                case "4":

                    break;
                case "5":
                    MSTNetworkUI mstNetworkUI = new MSTNetworkUI();
                    mstNetworkUI.run();
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
