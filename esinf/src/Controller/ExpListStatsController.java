package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;
import stats.ListStatistics;
import store.HubsStore;
import store.ListaExpedicoesStore;

import java.util.*;

public class ExpListStatsController {

    static final String statNameCTS = "Nº de cabazes totalmente satisfeitos"; // Nome da estatística "Cabazes totalmente satisfeitos"
    static final String statNameCPS = "Nº de cabazes parcialmente satisfeitos"; // Nome da estatística "Cabazes parcialmente satisfeitos"
    static final String statNamePFC = "Nº de produtores distintos que forneceram cabazes"; // Nome da estatística "Produtores distintos que forneceram cabazes"
    static final String statNamePTS = "Nº de produtos totalmente satisfeitos"; // Nome da estatística "Produtos totalmente satisfeitos"
    static final String statNamePPS = "Nº de produtos parcialmente satisfeitos"; // Nome da estatística "Produtos parcialmente satisfeitos"
    static final String statNamePNS = "Nº de produtos nao satisfeitos"; // Nome da estatística "Produtos nao satisfeitos"
    static final String statNamePer = "Percentagem total do cabaz satisfeito"; // Nome da estatística "Percentagem total do cabaz satisfeito"
    static final String statNamePFOC = "Nº de produtores distintos que forneceram o cabaz"; // Nome da estatística "Produtores distintos que forneceram o cabaz"

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
     * Create a list of statistics for each client in all expeditions
     * @return List of statistics for each client
     */
    public List<ListStatistics> getStatsByCliente() {
        if (expedicoes.isEmpty()) throw new IllegalArgumentException("Não existem listas de expedição");

        Map<String, List<Integer>> clientesStatsValues = new HashMap<>(); // posicao : 0 - PTS, 1 - PPS
        Map<String, Set<String>> clientesDiffProdutores = new HashMap<>(); // produtores distintos que forneceram cabazes

        for (Map.Entry<Integer, Map<ClienteProdutorEmpresa, Cabaz>> diaEntry: expedicoes.entrySet()) { // para cada dia
            int dia = diaEntry.getKey();
            Map<ClienteProdutorEmpresa, Cabaz> expedicao = diaEntry.getValue();

            fillClientesStatsForExpedicao(clientesStatsValues, clientesDiffProdutores, expedicao, dia);
        }

        return createListStatisticsForEachCliente(clientesStatsValues, clientesDiffProdutores);
    }

    /**
     * Create a list of statistics for each client for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each client
     */
    public List<ListStatistics> getStatsByCliente(int dia) {
        if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);

        Map<String, List<Integer>> clientesStatsValues = new HashMap<>(); // posicao : 0 - PTS, 1 - PPS
        Map<String, Set<String>> clientesDiffProdutores = new HashMap<>(); // produtores distintos que forneceram cabazes

        fillClientesStatsForExpedicao(clientesStatsValues, clientesDiffProdutores, expedicoes.get(dia), dia);

        return createListStatisticsForEachCliente(clientesStatsValues, clientesDiffProdutores);
    }

    public void fillClientesStatsForExpedicao(Map<String, List<Integer>> clientesStatsValues, Map<String, Set<String>> clientesDiffProdutores, Map<ClienteProdutorEmpresa, Cabaz> expedicao, int dia) {
        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> cliente : expedicao.entrySet()) { // para cada cliente
            ClienteProdutorEmpresa cpe = cliente.getKey();
            Cabaz cabaz = cliente.getValue();
            String clienteID = cpe.getId();
            if (!clientesStatsValues.containsKey(clienteID)) { // se ainda não existe o cliente na lista de clientes
                clientesStatsValues.put(clienteID, new ArrayList<>(Arrays.asList(0, 0)));
                clientesDiffProdutores.put(clienteID, new HashSet<>());
            }
            List<Integer> statsValues = clientesStatsValues.get(clienteID);
            clientesDiffProdutores.get(clienteID).addAll(cabaz.getDiffProdutores());

            Pedido pedido = cpe.getCabaz(dia); // obter o pedido do cliente
            int satisfacao = cabaz.satisfiedCabaz(pedido.getProdutos()); // obter a satisfacao do cabaz
            if (satisfacao == 1) { // cabaz totalmente satisfeito
                statsValues.set(0, statsValues.get(0) + 1);
            } else if (satisfacao == 0) { // cabaz parcialmente satisfeito
                statsValues.set(1, statsValues.get(1) + 1);
            }
        }
    }

    /**
     * Creates a List of ListStatistics for each client
     * @param clientesStatsValues Map with the values of the statistics for each client
     * @param clientesDiffProdutores Map with the different producers that provided a cabaz for each client
     * @return List of statistics for each client
     */
    private List<ListStatistics> createListStatisticsForEachCliente(Map<String, List<Integer>> clientesStatsValues, Map<String, Set<String>> clientesDiffProdutores) {
        List<ListStatistics> finalStats = new ArrayList<>(); // Lista de estatísticas a retornar

        for (Map.Entry<String, List<Integer>> entry : clientesStatsValues.entrySet()) { // Para cada cliente
            String clienteID = entry.getKey();
            List<Integer> statsValues = entry.getValue();
            ListStatistics listStatistics = new ListStatistics(clienteID); // Cria nova lista de estatísticas
            listStatistics.addStat(statNameCTS, statsValues.get(0)); // Adiciona a estatística "Cabazes totalmente satisfeitos"
            listStatistics.addStat(statNameCPS, statsValues.get(1)); // Adiciona a estatística "Cabazes parcialmente satisfeitos"
            listStatistics.addStat(statNamePFC, clientesDiffProdutores.get(clienteID).size()); // Adiciona a estatística "Produtores distintos que forneceram cabazes"
            finalStats.add(listStatistics);
        }

        return finalStats;
    }

    /**
     * Create a list of statistics for each cabaz in all expeditions
     * @return List of statistics for each cabaz
     */
    public List<ListStatistics> getStatsByCabaz() {
        if (expedicoes.isEmpty()) throw new IllegalArgumentException("Não existem listas de expedição");
        List<ListStatistics> finalStats = new ArrayList<>(); // Lista de estatísticas a retornar
        for (Map.Entry<Integer, Map<ClienteProdutorEmpresa, Cabaz>> diaEntry: expedicoes.entrySet()) { // para cada dia
            int dia = diaEntry.getKey();
            Map<ClienteProdutorEmpresa, Cabaz> expedicao = diaEntry.getValue();

            finalStats.addAll(createListStatisticsForEachCabaz(expedicao, dia));
        }
        return finalStats;
    }

    /**
     * Create a list of statistics for each cabaz for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each cabaz
     */
    public List<ListStatistics> getStatsByCabaz(int dia) {
        if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);

        Map<ClienteProdutorEmpresa, Cabaz> expedicao = expedicoes.get(dia);

        return createListStatisticsForEachCabaz(expedicao, dia);
    }

    /**
     * Create a list of statistics for each cabaz in all expeditions
     * @param dia day of the expeditions
     * @param expedicao Map with the cabazes for the given day
     * @return List of statistics for each cabaz
     */
    public List<ListStatistics> createListStatisticsForEachCabaz(Map<ClienteProdutorEmpresa, Cabaz> expedicao, int dia) {
        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada

        for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expedicao.entrySet()) { // para cada cabaz
            ClienteProdutorEmpresa cliente = entry.getKey();
            Cabaz cabaz = entry.getValue();
            ListStatistics stats = new ListStatistics(String.format("Cabaz de %s", cliente.getId())); // cria nova lista de estatísticas
            List<Float> produtosCabaz = cabaz.getProdutos();
            List<Float> produtosPedido = mapCPE.get(cliente.getId()).getCabaz(dia).getProdutos();

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
            stats.addStat(statNamePFOC, cabaz.getDiffProdutores().size()); // Cria a estatistica com o valor de produtores distintos que forneceram o cabaz
            finalStats.put(cliente.getId(), stats);
        }

        return new ArrayList<>(finalStats.values());
    }

    /**
     * Create a list of statistics for each produtor for the given day
     * @return List of statistics for each produtor
     */
    public List<ListStatistics> getStatsByProdutor() {
        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada

        final String statNameCFT = "Nº de cabazes fornecidos totalmente"; // Nome da estatística "Cabazes fornecidos totalmente"
        final String statNameCFP = "Nº de cabazes fornecidos parcialmente"; // Nome da estatística "Cabazes fornecidos parcialmente"
        final String statNameCDF = "Nº de clientes distintos fornecidos"; // Nome da estatística "Clientes distintos fornecidos"
        final String statNamePTE = "Nº de produtos totalmente esgotados"; // Nome da estatística "Produtos totalmente esgotados"
        final String statNameHF = "Nº de hubs fornecidos"; // Nome da estatística "Hubs fornecidos"

        for (ClienteProdutorEmpresa produtor : mapCPE.values()) {
            if (produtor.isProdutor()) {
                ListStatistics stats = new ListStatistics(produtor.getId());
                int cft = numberOfCabazesTotallyDelivered(produtor); // Nº de cabazes fornecidos totalmente
                int cfp = numberOfCabazesPartiallyDelivered(produtor); // Nº de cabazes fornecidos parcialmente
                int cdf = numberOfDistinctClientesDelivered(produtor); // Nº de clientes distintos fornecidos
                int pte = numberOfProductsOutOfStock(produtor); // Nº de produtos totalmente esgotados
                int hf = numberOfHubsSatisfiedByProducer(produtor); // Nº de hubs fornecidos

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
     * Calculates the total number of complete cabazes for the producer
     * @param produtor producer to calculate the number of complete cabazes
     * @return total number of complete cabazes for the producer
     */
    public Integer numberOfCabazesTotallyDelivered(ClienteProdutorEmpresa produtor){
        int numberOfCabazes = 0;
        Map<Integer, List<Pedido>> pedidosStore = App.getInstance().getPedidosStore().getPedidoMap();
        for (Integer dia : pedidosStore.keySet()){
            List<Pedido> pedidos = pedidosStore.get(dia);
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = expedicoes.get(dia);
            List<AbstractMap.SimpleEntry<String, Float>> listOfProductsInCabaz = null;
            List<Float> listOfProductsInPedido = null;
            if (expeditionListInDay != null) {
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
            }
        }
        return numberOfCabazes;
    }

    /**
     * Calculates the total number of partial cabazes for the producer
     * @param produtor produtor to check the number of partial cabazes
     * @return number of partial cabazes
     */
    public Integer numberOfCabazesPartiallyDelivered(ClienteProdutorEmpresa produtor){
        int numberOfCabazes = 0;
        Map<Integer, List<Pedido>> pedidosStore = App.getInstance().getPedidosStore().getPedidoMap();
        for (Integer dia : pedidosStore.keySet()) {
            List<Pedido> pedidos = pedidosStore.get(dia);
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = expedicoes.get(dia);
            List<AbstractMap.SimpleEntry<String, Float>> listOfProductsInCabaz = null;
            List<Float> listOfProductsInPedido = null;
            if (expeditionListInDay != null) {
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
                    } else if (entry.getValue().getProdutorProdutos().size() == 1 && entry.getValue().getProdutorProdutos().containsKey(produtor)) {
                        listOfProductsInCabaz = entry.getValue().getProdutorProdutos().get(produtor);
                        int i = 0;
                        // Check if the products quantities in the cabaz are the same as the quantities in the pedido
                        for (AbstractMap.SimpleEntry<String, Float> product : listOfProductsInCabaz) {
                            if (listOfProductsInPedido.get(i) > product.getValue()) {
                                numberOfCabazes++;
                                break;
                            }
                            i++;
                        }
                    }
                }
            }
        }
        return numberOfCabazes;
    }
    /**
     * Get the number of distinct clientes that a produtor delivered to
     * @param produtor produtor to get the number of clientes delivered to
     * @return number of distinct clientes delivered to
     */
    public Integer numberOfDistinctClientesDelivered(ClienteProdutorEmpresa produtor){
        List<ClienteProdutorEmpresa> distinctClientesDelivered = new ArrayList<>();
        ListaExpedicoesStore clienteCabaz = App.getInstance().getListaExpedicoesStore();
        for (Integer dia : clienteCabaz.getExpedicoes().keySet()){
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = clienteCabaz.getExpedicoes().get(dia);
            if (expeditionListInDay != null) {
                for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()){
                    if (entry.getValue().containsKey(produtor) && !distinctClientesDelivered.contains(entry.getKey())){
                        distinctClientesDelivered.add(entry.getKey());
                    }
                }
            }

        }
        return distinctClientesDelivered.size();
    }
    /**
     * Get the number of products out of stock for a produtor on the last expedition day on the list
     * @param produtor produtor to get the number of products out of stock
     * @return number of products out of stock
     */
    public Integer numberOfProductsOutOfStock(ClienteProdutorEmpresa produtor){
        List<Pedido> listaStock = App.getInstance().getStock().getStockMap().get(App.getInstance().getStock().getStockMap().keySet().stream().max(Integer::compareTo).orElse(0));
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
     * @return number of Hubs delivered to
     */
    public Integer numberOfHubsSatisfiedByProducer(ClienteProdutorEmpresa produtor){
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        List<ClienteProdutorEmpresa> hubs = new ArrayList<>();
        ListaExpedicoesStore clienteCabaz = App.getInstance().getListaExpedicoesStore();
        for (Integer dia : clienteCabaz.getExpedicoes().keySet()) {
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = clienteCabaz.getExpedicoes().get(dia);
            if (expeditionListInDay != null) {
                for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()) {
                    if (entry.getValue().containsKey(produtor)) {
                        if (!hubs.contains(closestHubs.get(entry.getKey()))) {
                            hubs.add(closestHubs.get(entry.getKey()));
                        }
                    }
                }
            }
        }
        return hubs.size();
    }

    /**
     * Create a list of statistics for each hub
     * @return list of statistics for each hub
     */
    public List<ListStatistics> getStatsByHub() {
        HashMap<String, ListStatistics> finalStats = new HashMap<>(); // lista final para ser retornada

        final String statNameCDR = "Nº de clientes distintos que recolhem cabazes"; // Nome da estatística "Clientes distintos que recolhem cabazes"
        final String statNameNPD = "Nº de produtores distintos que fornecem cabazes"; // Nome da estatística "Produtores distintos que fornecem cabazes"

        for ( ClienteProdutorEmpresa hub : mapCPE.values()) {
            if (hub.isHub()){
                ListStatistics stats = new ListStatistics(hub.getId());
                int cdr = numberOfDistinctClientesByHub(hub);
                int npd = numberOfProdutoresByHub(hub);
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
     * @return number of distinct clientes serviced
     */
    public Integer numberOfDistinctClientesByHub(ClienteProdutorEmpresa hub){
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        List<ClienteProdutorEmpresa> distinctClients = new ArrayList<>();
        ListaExpedicoesStore clienteCabaz = App.getInstance().getListaExpedicoesStore();
        for (Integer dia : clienteCabaz.getExpedicoes().keySet()) {
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = clienteCabaz.getExpedicoes().get(dia);
            if (expeditionListInDay != null) {
                for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()) {
                    if (closestHubs.get(entry.getKey())!=null) {
                        if (closestHubs.get(entry.getKey()).equals(hub)) {
                            if (!distinctClients.contains(entry.getKey())) {
                                distinctClients.add(entry.getKey());
                            }
                        }
                    }

                }
            }
        }
        return distinctClients.size();
    }

    /**
     * Get the number of produtores that service a hub
     * @param hub hub to get the number of produtores that service it
     * @return number of produtores that serviced the hub
     */
    public Integer numberOfProdutoresByHub(ClienteProdutorEmpresa hub){
        ListaExpedicoesStore clienteCabaz = App.getInstance().getListaExpedicoesStore();
        HubsStore hubsStore = App.getInstance().getHubsStore();
        HashMap<ClienteProdutorEmpresa,ClienteProdutorEmpresa> closestHubs = hubsStore.getClosestHubToEachClient();
        List<ClienteProdutorEmpresa> listOfProducersOnHub = new ArrayList<>();
        for (Integer dia : clienteCabaz.getExpedicoes().keySet()) {
            Map<ClienteProdutorEmpresa, Cabaz> expeditionListInDay = clienteCabaz.getExpedicoes().get(dia);
            if (expeditionListInDay != null) {
                for (Map.Entry<ClienteProdutorEmpresa, Cabaz> entry : expeditionListInDay.entrySet()) {
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
            }
        }
        return listOfProducersOnHub.size();
    }


    // For each day
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
