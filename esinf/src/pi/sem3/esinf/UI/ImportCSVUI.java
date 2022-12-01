package pi.sem3.esinf.UI;

import pi.sem3.esinf.Controller.ReadCSVController;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class ImportCSVUI implements Runnable {
    private final ReadCSVController controller;
    public ImportCSVUI() {
        controller = new ReadCSVController();
    }


    @Override
    public void run() {
        boolean fileNotValid;
        Scanner sc = new Scanner(System.in);

        do {
            try {
                System.out.println("\nPor favor insira o ficheiro de Clientes e produtores que quer importar, ou \"0\" para voltar");
                String path = sc.nextLine();
                if (!path.equals("0")) {
                    controller.readClientesProdutoresFile(new File(path));
                    System.out.println();
                    System.out.println("Ficheiro importado corretamente!");
                }
                System.out.println("\nPor favor insira o ficheiro de distancias que quer importar, ou \"0\" para voltar");
                path = sc.nextLine();
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
}

