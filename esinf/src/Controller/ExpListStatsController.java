package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.ListaExpedicoes;
import domain.Pedido;
import stats.ListStatistics;

import java.util.*;

public class ExpListStatsController {

    private final Map<String, ClienteProdutorEmpresa> mapCPE;
    private final Map<Integer, ListaExpedicoes> expedicoes;

    public ExpListStatsController() {
        this.expedicoes = App.getInstance().getListaExpedicoesStore().getExpedicoes();
        this.mapCPE = App.getInstance().getClienteProdutorEmpresaStore().getMapCPE();
    }

    public ExpListStatsController(Map<Integer, ListaExpedicoes> expedicoes, Map<String, ClienteProdutorEmpresa> mapCPE) {
        this.expedicoes = expedicoes;
        this.mapCPE = mapCPE;
    }

    /**
     * Create a list of statistics for each client for the given day
     * @param dia day of the expeditions
     * @return List of statistics for each client
     */
    public List<ListStatistics> getStatsByCliente(int dia) {
        if (!expedicoes.containsKey(dia)) throw new IllegalArgumentException("Não existe lista de expedicoes para o dia " + dia);

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

        return new ArrayList<>(finalStats.values());
    }

    /**
     * Create a ListStatistics for each ClienteProdutorEmpresa in ListaExpedicoes and add it to the stats HashMap
     * @param stats HashMap to add the ListStatistics
     * @param listaExpedicoes ListaExpedicoes to get the ClienteProdutorEmpresa
     */
    private void createListStatisticsForEachClienteProdutor(HashMap<String, ListStatistics> stats, ListaExpedicoes listaExpedicoes) {
        for (Cabaz cabaz : listaExpedicoes.get_listaExpedicoes()) {
            String clienteProdutor = cabaz.getClienteProdutor();
            if (!stats.containsKey(clienteProdutor)) {
                stats.put(clienteProdutor, new ListStatistics(clienteProdutor));
            }
        }
    }

    public List<ListStatistics> getStatsByProdutor(int dia) {
        //TODO
        return null;
    }

    public List<ListStatistics> getStatsByCabaz(int dia) {
        //TODO
        return null;
    }

    public List<ListStatistics> getStatsByHub(int dia) {
        //TODO
        return null;
    }

}
