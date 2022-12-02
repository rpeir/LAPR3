package UI;

import Controller.App;
import Controller.ImportWaterControllerController;
import domain.WaterController.Sector;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class ImportWaterControllerUI implements Runnable{

    private LocalDateTime date = null;

    private final ImportWaterControllerController controller;
    App app;
    public ImportWaterControllerUI() {
        controller = new ImportWaterControllerController();
        app = App.getInstance();
    }

    @Override
    public void run() {
        boolean fileNotValid;
        Scanner sc = new Scanner(System.in);

        boolean run = true;

        while (run) {
            System.out.println("\nSelecione uma opcao:\n");
            System.out.println("1 - Importar ficheiro");
            System.out.println("2 - Definir data e hora");
            System.out.println("3 - Determinar se existe uma rega a decorrer nesse momento");
            System.out.println("4 - Determinar qual o setor que se encontra a ser regado nesse momento");
            System.out.println("5 - Determinar quantos minutos faltam para terminar a rega no setor que está a ser regado nesse momento");
            System.out.println("6 - Determinar quantos minutos faltam para terminar o ciclo de rega");
            System.out.println("0 - Sair");
            String opcao = sc.nextLine();
            DateTimeFormatter parser = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
            switch (opcao) {
                case "1" -> {
                    do {
                        try {
                            System.out.println("\nPor favor insira o ficheiro do Controlador de Rega que quer importar, ou \"0\" para voltar");
                            String path = sc.nextLine();
                            if (!path.equals("0")) {
                                controller.importWaterController(new File(path));
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
                case "2" -> {
                    boolean dateNotValid = true;
                    do {
                        System.out.println("\nPor favor insira a Data e Hora que quer verificar, no formato \"dd-MM-yyyy HH:mm\"");
                        String dateHour = sc.nextLine();
                        if (dateHour.matches("\\d{2}-\\d{2}-\\d{4} \\d{2}:\\d{2}")) {
                            date = LocalDateTime.parse(dateHour, parser);
                            System.out.println("Data e Hora definidas com sucesso!");
                            dateNotValid = false;
                        } else {
                            System.out.println();
                            System.out.println("Formato de data e hora invalido!");
                        }
                    } while (dateNotValid);
                }
                case "3" -> {
                    System.out.println();
                    if (date != null) {
                        System.out.println();
                        if (app.getWaterController().currentSector(date) != null) {
                            System.out.println("Existe uma rega a decorrer nesse momento!");
                        } else {
                            System.out.println("Nao existe uma rega a decorrer nesse momento!");
                        }
                    } else {
                        System.out.println();
                        System.out.println("Nao foi definida uma data e hora!");
                    }
                }
                case "4" -> {
                    System.out.println();
                    if (date != null) {
                        if (app.getWaterController().currentSector(date) != null) {
                            System.out.println("O setor que se encontra a ser regado nesse momento e o setor " + app.getWaterController().currentSector(date).getName() + ".");
                        } else {
                            System.out.println("Nao existe uma rega a decorrer nesse momento!");
                        }
                    } else {
                        System.out.println();
                        System.out.println("Nao foi definida uma data e hora!");
                    }
                }
                case "5" -> {
                    System.out.println();
                    if (date != null) {
                        Sector currentSector = app.getWaterController().currentSector(date);
                        if (currentSector != null) {
                            System.out.println("Faltam " + app.getWaterController().timeToFinishWateringSector(date) + " minutos para terminar a rega nesse setor.");
                        } else {
                            System.out.println("Nao existe uma rega a decorrer nesse momento!");
                        }
                    } else {
                        System.out.println();
                        System.out.println("Nao foi definida uma data e hora!");
                    }
                }
                case "6" -> {
                    System.out.println();
                    if (date != null) {
                        Sector currentSector = app.getWaterController().currentSector(date);
                        if (currentSector != null) {
                            System.out.println("Faltam " + app.getWaterController().timeToFinishWateringCycle(date) + " minutos para terminar o ciclo de rega!");
                        } else {
                            System.out.println("Nao existe uma rega a decorrer nesse momento!");
                        }
                    } else {
                        System.out.println();
                        System.out.println("Nao foi definida uma data e hora!");
                    }
                }
                case "0" -> run = false;
                default -> System.out.println("\nOPCAO INVALIDA");
            }
        }

    }
}
