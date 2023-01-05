package UI;

import Controller.CreateExpeditionListController;
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
        System.out.println("Indroduza o número de produtores que podem fornecer produtos na expedição que quer criar: ");
        int n = sc.nextInt();
        boolean success = false;
        do{
            try{
                Map<ClienteProdutorEmpresa, Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>>> result = CTRL.createExpeditionList(dia,n);
                success = true;
                for (ClienteProdutorEmpresa cliente: result.keySet()) {
                    Map<ClienteProdutorEmpresa, List<AbstractMap.SimpleEntry<String, Float>>> produtoresMap = result.get(cliente);
                    System.out.println("Cliente: "+ cliente.getId());
                    for (ClienteProdutorEmpresa produtor : produtoresMap.keySet()){
                        List<AbstractMap.SimpleEntry<String, Float>> produtoList = produtoresMap.get(produtor);
                        System.out.println("    Produtor: " + produtor.getId());
                        for (AbstractMap.SimpleEntry<String, Float> produto: produtoList) {
                            System.out.printf("        Produto:%10s | Qtd: %4f  \n",produto.getKey(),produto.getValue());
                        }
                    }
                    System.out.println("=========================================================================");
                }
            }catch (Exception e){
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }while (success);



    }
}
