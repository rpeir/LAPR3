package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.CreateExpeditionList;
import domain.Pedido;

import java.util.AbstractMap;
import java.util.List;
import java.util.Map;

public class CreateExpeditionListController {

    private final App app;
    private CreateExpeditionList createExpeditionList;

    public CreateExpeditionListController() {
        app = App.getInstance();
        createExpeditionList = new CreateExpeditionList();
    }

    public Map<ClienteProdutorEmpresa, Cabaz> createExpeditionList(int dia, int n) {
        return this.createExpeditionList.createExpeditionList(dia, n);
    }
}