package UI;

import Controller.CreateExpeditionListController;
import domain.Cabaz;
import domain.ClienteProdutorEmpresa;

import java.util.*;

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
        boolean success = false;
            try{
                Map<ClienteProdutorEmpresa, Cabaz> result = CTRL.createExpeditionList(dia,n);
                for (ClienteProdutorEmpresa cliente: result.keySet()) {
                    Cabaz currentCabaz = result.get(cliente);
                    System.out.println("Cliente: "+ cliente.getId());
                    for (ClienteProdutorEmpresa produtor : currentCabaz.getProdutorProdutos().keySet()){
                        List<AbstractMap.SimpleEntry<String, Float>> produtoList = currentCabaz.get(produtor);
                        System.out.println("    Produtor: " + produtor.getId());
                        for (AbstractMap.SimpleEntry<String, Float> produto: produtoList) {
                            System.out.printf("        Produto: %10s | Qtd: %4f  \n",produto.getKey(),produto.getValue());
                        }
                    }
                    System.out.println("=========================================================================");
                }
                success = true;
            }catch (Exception e){
                System.out.println(e.getMessage());
                e.printStackTrace();
            }




    }
}
