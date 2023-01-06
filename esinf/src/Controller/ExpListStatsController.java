package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Pedido;
import stats.ListStatistics;
import store.ListaExpedicoesStore;

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

    public List<ListStatistics> getStatsByProdutor(int dia) {
        // TODO
        return null;
    }

    public Integer numberOfHubsSatisfiedByProducer(ClienteProdutorEmpresa produtor, int dia){
        // TODO
        return null;
    }
    public Integer numberOfClientsSatisfiedByProducer(ClienteProdutorEmpresa produtor, int dia){
        // TODO
        return null;
    }

    public Integer numberOfProductsOutOfStock(ClienteProdutorEmpresa produtor){
        // TODO
        return null;
    }

    public List<ListStatistics> getStatsByHub(int dia) {
        // TODO
        return null;
    }

}
