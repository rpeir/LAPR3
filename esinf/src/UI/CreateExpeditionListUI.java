package UI;

import Controller.CreateExpeditionListController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

import java.util.AbstractMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class CreateExpeditionListUI implements Runnable {
    private final CreateExpeditionListController CTRL;
    private static final Scanner sc = new Scanner(System.in);

    public CreateExpeditionListUI() {
        CTRL = new CreateExpeditionListController();
    }

    @Override
    public void run() {
        System.out.println("Indroduza o dia de expedição da lista que quer criar");
        int dia = sc.nextInt();
        System.out.println("Indroduza o número de produtores que podem fornecer produtos na expedição quer criar");
        int n = sc.nextInt();
        Map<ClienteProdutorEmpresa, Cabaz> result = CTRL.createExpeditionList(dia,n);
        for (ClienteProdutorEmpresa cliente: result.keySet()) {
            Cabaz cabaz= result.get(cliente);
            Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtoresMap = cabaz.getProdutorProdutos();
            System.out.println("Cliente: "+ cliente.getId());
            for (ClienteProdutorEmpresa produtor : produtoresMap.keySet()){
                List<AbstractMap.SimpleEntry<String, Float>> produtoList = produtoresMap.get(produtor);
                System.out.println("    Produtor: " + produtor.getId());
                for (AbstractMap.SimpleEntry<String, Float> produto: produtoList) {
                    System.out.printf("        Produto:%10s | Qtd: %4f  ",produto.getKey(),produto.getValue());
                }
            }
        }

    }
}
