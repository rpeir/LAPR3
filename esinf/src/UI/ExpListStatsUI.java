package UI;

import Controller.ExpListStatsController;
import stats.ListStatistics;

import java.util.List;
import java.util.Scanner;

public class ExpListStatsUI implements Runnable{

    private final ExpListStatsController CTRL;

    public ExpListStatsUI() {
        this.CTRL = new ExpListStatsController();
    }

    public ExpListStatsUI(ExpListStatsController ctrl) {
        this.CTRL = ctrl;
    }
    @Override
    public void run() {
        boolean exit = false;
        Scanner sc = new Scanner(System.in);

        do {
            try {
                System.out.println("\nEscolha o tipo de estatísticas que pretende obter\n");
                System.out.println("1 - Estatísticas por Cabaz");
                System.out.println("2 - Estatísticas por Cliente");
                System.out.println("3 - Estatísticas por Produtor");
                System.out.println("4 - Estatísticas por Hub");
                System.out.println("0 - Voltar");
                String inputStat = sc.nextLine();
                boolean valid = true;
                switch (inputStat) {
                    case "1","2","3","4" :
                        break;
                    default: {
                        System.out.println("Opçao inválida!\nTente novamente");
                        valid = false;
                        break;
                    }
                    case "0":
                        exit = true;
                        valid = false;
                        break;
                }
                if (valid) {
                    System.out.println("\nEscolha o dia da lista de expedição que pretende analisar, ou \"0\" para todos os dias");
                    int day = Integer.parseInt(sc.nextLine());
                    if (day == 0) {
                        switch (inputStat) {
                            case "1" -> printStats(CTRL.getStatsByCabaz());
                            case "2" -> printStats(CTRL.getStatsByCliente());
                            case "3" -> printStats(CTRL.getStatsByProdutor());
                            case "4" -> printStats(CTRL.getStatsByHub());
                        }
                    } else {
                        switch (inputStat) {
                            case "1" -> printStats(CTRL.getStatsByCabaz(day));
                            case "2" -> printStats(CTRL.getStatsByCliente(day));
                            case "3" -> printStats(CTRL.getStatsByProdutor(day));
                            case "4" -> printStats(CTRL.getStatsByHub(day));
                        }
                    }

                }
            } catch (IllegalArgumentException e) {
                System.out.println("\nErro: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("Ocorreu um erro inesperado!");
                System.out.println("Tente novamente");
                System.out.printf("Erro: %s\n",e.getMessage());
            }

        } while (!exit);

    }

    private void printStats(List<ListStatistics> stats) {
        if (stats.isEmpty()) throw new IllegalArgumentException("Não foram calculadas estatísticas");

        for (ListStatistics stat : stats) {
            System.out.println(stat.toStringDetailed());
        }
    }
}
