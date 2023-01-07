package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;
import stats.ListStatistics;
import store.HubsStore;

import java.util.*;

public class ExpListStatsController {

    private final Map<String, ClienteProdutorEmpresa> mapCPE;
    private final Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> expedicoes;

    public ExpListStatsController() {
        this.expedicoes = App.getInstance().getListaExpedicoesStore().getExpedicoes();
        this.mapCPE = App.getInstance().getClienteProdutorEmpresaStore().getMapCPE();
    }

    public ExpListStatsController(Map<Integer, Map<ClienteProdutorEmpresa, Cabaz>> expedicoes, Map<String, ClienteProdutorEmpresa> mapCPE) {
        this.expedicoes = expedicoes;
        this.mapCPE = mapCPE;
    }

    /**
     * Create a list of statistics for each client for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each client
     */
    public List<ListStatistics> getStatsByCliente(int dia) {
        /*if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);

        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada
        ListaExpedicoes listaExpedicoes = expedicoes.get(dia);

        createListStatisticsForEachClienteProdutor(finalStats,listaExpedicoes); // cria uma lista de estatisticas para cada cpe e adiciona ao hashmap finalStats

        final String statNameCTS = "Nº de cabazes totalmente satisfeitos"; // Nome da estatística "Cabazes totalmente satisfeitos"
        final String statNameCPS = "Nº de cabazes parcialmente satisfeitos"; // Nome da estatística "Cabazes parcialmente satisfeitos"
        final String statNamePFC = "Nº de produtores distintos que forneceram cabazes"; // Nome da estatística "Produtores distintos que forneceram cabazes"

        List<Cabaz> sorted = listaExpedicoes.get_listaExpedicoes();
        // Ordena a lista de expedicoes por clienteProdutorEmpresa para manipular o mesmo em cada iteracao
        sorted.sort(Comparator.comparing(Pedido::getClienteProdutor));

        String oldCP = sorted.get(0).getClienteProdutor();
        int statValueCTS = 0;
        int statValueCPS = 0;
        HashSet<String> fornecedores = new HashSet<>();
        for (Cabaz cabaz : sorted) {
            String clienteProdutor = cabaz.getClienteProdutor();

            if (!oldCP.equals(clienteProdutor)) { // Se o cpe for diferente do anterior
                ListStatistics stats = finalStats.get(oldCP);
                stats.addStat(statNameCTS, statValueCTS); // Cria a estatistica com o valor de cabazes totalmente satisfeitos
                stats.addStat(statNameCPS, statValueCPS); // Cria a estatistica com o valor de cabazes parcialmente satisfeitos
                stats.addStat(statNamePFC, fornecedores.size()); // Cria a estatistica com o valor de produtores distintos que forneceram cabazes
                statValueCTS = 0; // Reseta o valor para o novo cpe
                statValueCPS = 0; // Reseta o valor para o novo cpe
                fornecedores.clear(); // Reseta o valor para o novo cpe
            }

            Pedido pedido = mapCPE.get(clienteProdutor).getCabaz(cabaz.getDiaDeProducao());
            if (cabaz.isSatisfied(pedido)) statValueCTS++; // Se o cabaz estiver totalmente satisfeito aumenta o valor
            else if (cabaz.isPartillySatisfied(pedido)) statValueCPS++; // Se o cabaz estiver parcialmente satisfeito aumenta o valor
            fornecedores.addAll(cabaz.getProdutores()); // Adiciona os fornecedores do cabaz ao HashSet
            oldCP = clienteProdutor;

        }

        ListStatistics stats = finalStats.get(oldCP);
        stats.addStat(statNameCTS, statValueCTS); // Cria a estatistica com o valor de cabazes totalmente satisfeitos para o ultimo cpe
        stats.addStat(statNameCPS, statValueCPS); // Cria a estatistica com o valor de cabazes parcialmente satisfeitos para o ultimo cpe
        stats.addStat(statNamePFC, fornecedores.size()); // Cria a estatistica com o valor de produtores distintos que forneceram cabazes para o ultimo cpe

        return new ArrayList<>(finalStats.values());*/
        return null;
    }

    /**
     * Create a ListStatistics for each ClienteProdutorEmpresa in ListaExpedicoes and add it to the stats HashMap
     * @param stats HashMap to add the ListStatistics
     */
    private void createListStatisticsForEachClienteProdutor(HashMap<String, ListStatistics> stats) {
        /*for (Cabaz cabaz : listaExpedicoes.get_listaExpedicoes()) {
            String clienteProdutor = cabaz.getClienteProdutor();
            if (!stats.containsKey(clienteProdutor)) {
                stats.put(clienteProdutor, new ListStatistics(clienteProdutor));
            }
        }*/
    }

    /**
     * Create a list of statistics for each cabaz for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each cabaz
     */
    public List<ListStatistics> getStatsByCabaz(int dia) {
        /*if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);

        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada
        ListaExpedicoes listaExpedicoes = expedicoes.get(dia);

        final String statNamePTS = "Nº de produtos totalmente satisfeitos"; // Nome da estatística "Produtos totalmente satisfeitos"
        final String statNamePPS = "Nº de produtos parcialmente satisfeitos"; // Nome da estatística "Produtos parcialmente satisfeitos"
        final String statNamePNS = "Nº de produtos nao satisfeitos"; // Nome da estatística "Produtos nao satisfeitos"
        final String statNamePer = "Percentagem total do cabaz satisfeito"; // Nome da estatística "Percentagem total do cabaz satisfeito"
        final String statNamePFC = "Nº de produtores distintos que forneceram o cabaz"; // Nome da estatística "Produtores distintos que forneceram o cabaz"

        for (Cabaz cabaz : listaExpedicoes.get_listaExpedicoes()) {
            ListStatistics stats = new ListStatistics(String.format("Cabaz de %s", cabaz.getClienteProdutor()));
            List<Float> produtosCabaz = cabaz.getProdutos();
            List<Float> produtosPedido = mapCPE.get(cabaz.getClienteProdutor()).getCabaz(dia).getProdutos();

            int pts = 0; // Nº de produtos totalmente satisfeitos
            int pps = 0; // Nº de produtos parcialmente satisfeitos
            int pns = 0; // Nº de produtos nao satisfeitos
            int qtPedida = 0; // Quantidade total pedida
            int qtSatisfeita = 0; // Quantidade total satisfeita
            for (int i = 0; i < produtosCabaz.size(); i++) {

                float produtoCabaz = produtosCabaz.get(i);
                float produtoPedido = produtosPedido.get(i);

                qtSatisfeita += produtoCabaz;
                qtPedida += produtoPedido;

                if (produtoPedido != 0) {
                    if (produtoCabaz == produtoPedido) pts++; // Se o produto do cabaz for igual ao do pedido, aumenta o valor de pts
                    else if (produtoCabaz == 0) pns++; // Se o produto do cabaz for maior que o do pedido, aumenta o valor de pps
                    else pps++; // Se o produto do cabaz for menor que o do pedido, aumenta o valor de pns
                }
            }

            stats.addStat(statNamePTS, pts); // Cria a estatistica com o valor de produtos totalmente satisfeitos
            stats.addStat(statNamePPS, pps); // Cria a estatistica com o valor de produtos parcialmente satisfeitos
            stats.addStat(statNamePNS, pns); // Cria a estatistica com o valor de produtos nao satisfeitos
            stats.addStat(statNamePer, String.format("%.2f %%", ((float) qtSatisfeita/qtPedida) * 100)) ; // Cria a estatistica com o valor da percentagem total do cabaz satisfeito
            stats.addStat(statNamePFC, new HashSet<>(cabaz.getProdutores()).size()); // Cria a estatistica com o valor de produtores distintos que forneceram o cabaz
            finalStats.put(cabaz.getClienteProdutor(), stats);
        }

        return new ArrayList<>(finalStats.values());*/
        return null;
    }

    /**
     * Create a list of statistics for each produtor for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each produtor
     */
    public List<ListStatistics> getStatsByProdutor(int dia) {
        if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);
        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada

        final String statNameCFT = "Nº de cabazes fornecidos totalmente"; // Nome da estatística "Cabazes fornecidos totalmente"
        final String statNameCFP = "Nº de cabazes fornecidos parcialmente"; // Nome da estatística "Cabazes fornecidos parcialmente"
        final String statNameCDF = "Nº de clientes distintos fornecidos"; // Nome da estatística "Clientes distintos fornecidos"
        final String statNamePTE = "Nº de produtos totalmente esgotados"; // Nome da estatística "Produtos totalmente esgotados"
        final String statNameHF = "Nº de hubs fornecidos"; // Nome da estatística "Hubs fornecidos"

        for (ClienteProdutorEmpresa produtor : mapCPE.values()) {
            if (produtor.isProdutor()) {
                ListStatistics stats = new ListStatistics(produtor.getId());
                int cft = numberOfCabazesTotallyDelivered(produtor, dia); // Nº de cabazes fornecidos totalmente
                int cfp = numberOfCabazesPartiallyDelivered(produtor, dia); // Nº de cabazes fornecidos parcialmente
                int cdf = numberOfDistinctClientesDelivered(produtor, dia); // Nº de clientes distintos fornecidos
                int pte = numberOfProductsOutOfStock(produtor, dia); // Nº de produtos totalmente esgotados
                int hf = numberOfHubsSatisfiedByProducer(produtor, dia); // Nº de hubs fornecidos

                stats.addStat(statNameCFT, cft); // Cria a estatistica com o valor de cabazes fornecidos totalmente
                stats.addStat(statNameCFP, cfp); // Cria a estatistica com o valor de cabazes fornecidos parcialmente
                stats.addStat(statNameCDF, cdf); // Cria a estatistica com o valor de clientes distintos fornecidos
                stats.addStat(statNamePTE, pte); // Cria a estatistica com o valor de produtos totalmente esgotados
                stats.addStat(statNameHF, hf); // Cria a estatistica com o valor de hubs fornecidos
                finalStats.put(produtor.getId(), stats);
            }
        }
        return new ArrayList<>(finalStats.values());
    }

    /**
     * Calculates the total number of complete cabazes for the producer for the given day
     * @param produtor producer to calculate the number of complete cabazes
     * @param dia day of the expeditions
     * @return total number of complete cabazes for the producer for the given day
     */
    public Integer numberOfCabazesTotallyDelivered(ClienteProdutorEmpresa produtor, int dia){
        int numberOfCabazes = 0;
        Map<Integer, List<Pedido>> pedidosStore = App.getInstance().getPedidosStore().getPedidoMap();
        List<Pedido> pedidos = pedidosStore.get(dia);
        Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = expedicoes.get(dia);
        List<AbstractMap.SimpleEntry<String, Float>> listOfProductsInCabaz = null;
        List<Float> listOfProductsInPedido = null;
        // Get the stock of the producer
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()) {
            // Look for pedido of the cliente
            for (Pedido pedido : pedidos) {
                if (pedido.getClienteProdutor().equals(entry.getKey().getId())) {
                    listOfProductsInPedido = pedido.getProdutos();
                }
            }
            // If the cabaz of the cliente only has one producer and it is the same as the producer
            if (entry.getValue().getProdutorProdutos().size() == 1 && entry.getValue().getProdutorProdutos().containsKey(produtor)) {
                listOfProductsInCabaz = entry.getValue().getProdutorProdutos().get(produtor);
                int i = 0;
                int completeProducts = 0;
                // Check if the products quantities in the cabaz are the same as the quantities in the pedido
                for (AbstractMap.SimpleEntry<String, Float> product : listOfProductsInCabaz){
                    if (listOfProductsInPedido.get(i) == product.getValue()){
                        completeProducts++;
                    }else{
                        break;
                    }
                    i++;
                }
                // If all the products quantities are the same, then the cabaz is complete
                if (completeProducts == listOfProductsInCabaz.size()){
                    numberOfCabazes++;
                }
            }
        }
        return numberOfCabazes;
    }

    /**
     * Calculates the total number of partial cabazes for the producer for the given day
     * @param produtor produtor to check
     * @param dia day to check
     * @return number of partial cabazes
     */
    public Integer numberOfCabazesPartiallyDelivered(ClienteProdutorEmpresa produtor, int dia){
        int numberOfCabazes = 0;
        Map<Integer, List<Pedido>> pedidosStore = App.getInstance().getPedidosStore().getPedidoMap();
        List<Pedido> pedidos = pedidosStore.get(dia);
        Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = expedicoes.get(dia);
        List<AbstractMap.SimpleEntry<String, Float>> listOfProductsInCabaz = null;
        List<Float> listOfProductsInPedido = null;
        // Get the stock of the producer
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()) {
            // Look for pedido of the cliente
            for (Pedido pedido : pedidos) {
                if (pedido.getClienteProdutor().equals(entry.getKey().getId())) {
                    listOfProductsInPedido = pedido.getProdutos();
                }
            }
            // If the cabaz of the cliente only has one producer and it is the same as the producer
            if (entry.getValue().getProdutorProdutos().size() > 1 && entry.getValue().getProdutorProdutos().containsKey(produtor)) {
                numberOfCabazes++;
            }else if(entry.getValue().getProdutorProdutos().size() == 1 && entry.getValue().getProdutorProdutos().containsKey(produtor)){
                listOfProductsInCabaz = entry.getValue().getProdutorProdutos().get(produtor);
                int i = 0;
                // Check if the products quantities in the cabaz are the same as the quantities in the pedido
                for (AbstractMap.SimpleEntry<String, Float> product : listOfProductsInCabaz){
                    if (listOfProductsInPedido.get(i) > product.getValue()){
                        numberOfCabazes++;
                        break;
                    }
                    i++;
                }
            }
        }
        return numberOfCabazes;
    }
    /**
     * Get the number of distinct clientes that a produtor delivered to
     * @param produtor produtor to get the number of clientes delivered to
     * @param dia day of the expeditions
     * @return number of distinct clientes delivered to
     */
    public Integer numberOfDistinctClientesDelivered(ClienteProdutorEmpresa produtor, int dia){
        int numberOfDistinctClientesDelivered = 0;
        Map<ClienteProdutorEmpresa, Cabaz> clienteCabaz = App.getInstance().getListaExpedicoesStore().getExpedicaoNumDia(dia);
        for (Cabaz cabaz : clienteCabaz.values()) {
            if (cabaz.containsKey(produtor)) {
                numberOfDistinctClientesDelivered++;
            }
        }
        return numberOfDistinctClientesDelivered;
    }
    /**
     * Get the number of products out of stock for a produtor on the given day
     * @param produtor produtor to get the number of products out of stock
     * @param dia day to get the number of products out of stock
     * @return number of products out of stock
     */
    public Integer numberOfProductsOutOfStock(ClienteProdutorEmpresa produtor, int dia){
        List<Pedido> listaStock = App.getInstance().getStock().getStockMap().get(dia);
        int outOfStock = 0;
        for (Pedido p : listaStock) {
            if (p.getClienteProdutor().equals(produtor.getId())) {
                for (Float f : p.getProdutos()) {
                    if (f == 0) outOfStock++;
                }
            }
        }
        return outOfStock;
    }

    /**
     * Get the number of Hubs that a produtor delivered to
     * @param produtor produtor to get the number of Hubs delivered to
     * @param dia day of the expeditions
     * @return number of Hubs delivered to
     */
    public Integer numberOfHubsSatisfiedByProducer(ClienteProdutorEmpresa produtor, int dia){
        Map<ClienteProdutorEmpresa, Cabaz> clienteCabaz = App.getInstance().getListaExpedicoesStore().getExpedicaoNumDia(dia);
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        List<ClienteProdutorEmpresa> hubs = new ArrayList<>();
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : clienteCabaz.entrySet()) {
            if (entry.getValue().containsKey(produtor)) {
                if(!hubs.contains(closestHubs.get(entry.getKey()))){
                    hubs.add(closestHubs.get(entry.getKey()));
                }
            }
        }
        return hubs.size();
    }

    /**
     * Create a list of statistics for each hub
     * @param dia day of the expeditions
     * @return list of statistics for each hub
     */
    public List<ListStatistics> getStatsByHub(int dia) {
        if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);
        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada

        final String statNameCDR = "Nº de clientes distintos que recolhem cabazes"; // Nome da estatística "Clientes distintos que recolhem cabazes"
        final String statNameNPD = "Nº de produtores distintos que fornecem cabazes"; // Nome da estatística "Produtores distintos que fornecem cabazes"

        for ( ClienteProdutorEmpresa hub : mapCPE.values()) {
            if (hub.isHub()){
                ListStatistics stats = new ListStatistics(hub.getId());
                int cdr = numberOfDistinctClientesByHub(hub, dia);
                int npd = numberOfProdutoresByHub(hub, dia);
                stats.addStat(statNameCDR, cdr); // Cria a estatistica com o valor de clientes distintos que recolhem cabazes
                stats.addStat(statNameNPD, npd); // Cria a estatistica com o valor de produtores distintos que fornecem cabazes
                finalStats.put(hub.getId(), stats);
            }
        }
        return new ArrayList<>(finalStats.values());
    }

    /**
     * Get the number of distinct clientes that a hub services
     * @param hub hub to get the number of clientes serviced
     * @param dia day of the expeditions
     * @return number of distinct clientes serviced
     */
    public Integer numberOfDistinctClientesByHub(ClienteProdutorEmpresa hub, int dia){
        Map<ClienteProdutorEmpresa, Cabaz> clienteCabaz = App.getInstance().getListaExpedicoesStore().getExpedicaoNumDia(dia);
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        int numberOfClients = 0;
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : clienteCabaz.entrySet()) {
            if (closestHubs.get(entry.getKey())!=null) {
                if (closestHubs.get(entry.getKey()).equals(hub)) {
                    numberOfClients++;
                }
            }
        }
        return numberOfClients;
    }

    /**
     * Get the number of produtores that service a hub
     * @param hub hub to get the number of produtores that service it
     * @param dia day of the expeditions
     * @return number of produtores that serviced the hub
     */
    public Integer numberOfProdutoresByHub(ClienteProdutorEmpresa hub, int dia){
        Map<ClienteProdutorEmpresa, Cabaz> clienteCabaz = App.getInstance().getListaExpedicoesStore().getExpedicaoNumDia(dia);
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        int numberOfProducers = 0;
        List<ClienteProdutorEmpresa> listOfProducersOnHub = new ArrayList<>();
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : clienteCabaz.entrySet()) {
            if (closestHubs.get(entry.getKey())!=null) {
                if (closestHubs.get(entry.getKey()).equals(hub)) {
                    for (ClienteProdutorEmpresa produtor : entry.getValue().getProdutorProdutos().keySet()) {
                        if (!listOfProducersOnHub.contains(produtor)) {
                            listOfProducersOnHub.add(produtor);
                        }
                    }
                }
            }
        }
        if (!listOfProducersOnHub.isEmpty()) numberOfProducers = listOfProducersOnHub.size();
        return numberOfProducers;
    }
}
