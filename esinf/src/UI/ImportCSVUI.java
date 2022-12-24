package UI;

import Controller.App;
import Controller.ReadCSVController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class ImportCSVUI implements Runnable {
    private final ReadCSVController controller;

    private static final Scanner sc = new Scanner(System.in);
    App app;
    public ImportCSVUI() {
        controller = new ReadCSVController();
        app = App.getInstance();
    }


    public void readClientesProdutorasEmpresasFile() {
        boolean fileNotValid;

        do {
            try {
                System.out.println("\nPor favor insira o ficheiro de Clientes e produtores que quer importar, ou \"0\" para voltar");
                String path = sc.nextLine();
                if (!path.equals("0")) {
                    controller.readClientesProdutoresFile(new File(path));
                    System.out.println();
                    System.out.println("Ficheiro importado corretamente!");
                }

                fileNotValid = false;
            } catch (FileNotFoundException e) {
                System.out.println();
                System.out.println("Ficheiro nao encontrado!");
                fileNotValid = true;
            } catch (IOException e) {
                System.out.println();
                System.out.println("Ocorreu um erro ao ler o ficheiro, por favor, tente novamente!");
                System.out.println(e.getMessage());
                fileNotValid = true;
            } catch (Exception e) {
                System.out.println();
                System.out.println("Ocorreu um erro, por favor, tente novamente!");
                e.printStackTrace();
                fileNotValid = true;
            }
        } while (fileNotValid);

    }

    public void readDistancesFile() {
        boolean fileNotValid;

        do {
            try {
                System.out.println("\nPor favor insira o ficheiro de distancias que quer importar, ou \"0\" para voltar");
                String path = sc.nextLine();
                if (!path.equals("0")) {
                    controller.readDistancesFile(new File(path));
                    System.out.println();
                    System.out.println("Ficheiro importado corretamente!");
                }

                fileNotValid = false;
            } catch (FileNotFoundException e) {
                System.out.println();
                System.out.println("Ficheiro nao encontrado!");
                fileNotValid = true;
            } catch (IOException e) {
                System.out.println();
                System.out.println("Ocorreu um erro ao ler o ficheiro, por favor, tente novamente!");
                System.out.println(e.getMessage());
                fileNotValid = true;
            } catch (Exception e) {
                System.out.println();
                System.out.println("Ocorreu um erro, por favor, tente novamente!");
                e.printStackTrace();
                fileNotValid = true;
            }
        } while (fileNotValid);
    }

    public void readCabazesFile() {
        boolean fileNotValid;

        do {
            try {
                System.out.println("\nPor favor insira o ficheiro de cabazes que quer importar, ou \"0\" para voltar");
                String path = sc.nextLine();
                if (!path.equals("0")) {
                    controller.readCabazesFile(new File(path));
                    System.out.println();
                    System.out.println("Ficheiro importado corretamente!");
                }

                fileNotValid = false;
            } catch (FileNotFoundException e) {
                System.out.println();
                System.out.println("Ficheiro nao encontrado!");
                fileNotValid = true;
            } catch (IOException e) {
                System.out.println();
                System.out.println("Ocorreu um erro ao ler o ficheiro, por favor, tente novamente!");
                System.out.println(e.getMessage());
                fileNotValid = true;
            } catch (Exception e) {
                System.out.println();
                System.out.println("Ocorreu um erro, por favor, tente novamente!");
                e.printStackTrace();
                fileNotValid = true;
            }
        } while (fileNotValid);
    }

    @Override
    public void run() {
        boolean exit = false;
        do {
            try {
                System.out.println("\nEscolha o ficheiro que pretende importar\n");
                System.out.println("1 - Ficheiro de Clientes, Produtores e Empresas");
                System.out.println("2 - Ficheiro de Distancias");
                System.out.println("3 - Ficheiro de Cabazes");
                System.out.println("0 - Voltar");
                String input = sc.nextLine();
                switch (input) {
                    case "1" -> readClientesProdutorasEmpresasFile();
                    case "2" -> readDistancesFile();
                    case "3" -> readCabazesFile();
                    case "0" -> exit = true;
                    default -> {
                        System.out.println("\nOpçao inválida!");
                    }
                }
            } catch (Exception e) {
                System.out.println();
                System.out.println("Ocorreu um erro, por favor, tente novamente!");
                e.printStackTrace();
            }
        } while (!exit);
    }
}

