package Controller;

import domain.Cabaz;
import domain.ClienteProdutorEmpresa;
import domain.Localizacao;
import graph.Graph;
import store.ClienteProdutorEmpresaStore;
import store.LocalizacaoStore;

import java.awt.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import static java.lang.Integer.valueOf;

/**
 * Read data from csv file and put it in a graph
 */
public class ReadCSVController {
    /**
     * The main regular expression that is used to split the line into words
     */
    private static final String MAIN_SPLIT_REGEX = "\",\"";
    /**
     * The alternative regular expression that is used to split the line into words
     */
    private static final String SPLIT_REGEX = ",";
    /**
     * ClienteProdutorEmpresaStore object
     */
    private final ClienteProdutorEmpresaStore cpeStore;

    /**
     * LocalizacaoStore object
     */
    private final LocalizacaoStore localizacaoStore;

    /**
     * Graph object
     */
    private final Graph<Localizacao, Integer> graph;

    /**
     * ClientProdutorEmpresa object
     */
    private ClienteProdutorEmpresa cpe;

    /**
     * Constructor for ReadCSVController
     */
    public ReadCSVController() {
        cpeStore = App.getInstance().getClienteProdutorEmpresaStore();
        localizacaoStore = App.getInstance().getLocalizacaoStore();
        graph = App.getInstance().getGraph();
    }


    /**
     * It reads a file refering to Clients and Producers and puts it in a graph
     *
     * @param filename The file to be read
     */
    public void readClientesProdutoresFile(File filename) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            br.readLine(); // skip first line
            String line = br.readLine();
            while ((line != null)) {
                String[] values = line.split(MAIN_SPLIT_REGEX);
                if (values.length == 1)
                    values = line.split(SPLIT_REGEX);
                else {
                    for (int i = 0; i < values.length; i++) {
                        values[i] = values[i].replace("\"", "");
                    }
                }
                ClienteProdutorEmpresa cpe = new ClienteProdutorEmpresa(values[0], Float.parseFloat(values[1]), Float.parseFloat(values[2]), values[3]);
                if (!cpeStore.containsCPE(cpe.getId())) {
                    cpeStore.addCPE(cpe);
                    localizacaoStore.addLocalizacao(cpe.getLocalizacao());
                    graph.addVertex(cpe.getLocalizacao());
                }
                line = br.readLine();
            }
        } catch (NumberFormatException e) {
            throw new IOException("Invalid ID format");
        } catch (IllegalArgumentException e) {
            throw new IOException(e.getMessage());
        }
    }

    /**
     * It reads a file refering to the distances between two locations and puts it in a graph
     *
     * @param filename The file to be read
     */
    public void readDistancesFile(File filename) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            br.readLine(); // skip first line
            String line = br.readLine();
            while ((line != null)) {
                String[] values = line.split(MAIN_SPLIT_REGEX);
                if (values.length == 1)
                    values = line.split(SPLIT_REGEX);
                else {
                    for (int i = 0; i < values.length; i++) {
                        values[i] = values[i].replace("\"", "");
                    }
                }

                if (!Localizacao.validateID(values[0]) || !Localizacao.validateID(values[1]))
                    throw new IllegalArgumentException("Invalid locID format");
                Localizacao lc1 = localizacaoStore.getLocalizacao(values[0]);
                Localizacao lc2 = localizacaoStore.getLocalizacao(values[1]);
                if (lc1 != null && lc2 != null) {
                    if (!graph.edgeExists(lc2, lc1)) {
                        graph.addEdge(lc2, lc1, Integer.parseInt(values[2]));
                    }
                }
                line = br.readLine();
            }
        } catch (NumberFormatException e) {
            throw new IOException("Invalid ID format");
        } catch (IllegalArgumentException e) {
            throw new IOException(e.getMessage());
        }
    }

    public void readCabazesFile(File filename) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            br.readLine(); // skip first line
            String line = br.readLine();
            while ((line != null)) {
                String[] values = line.split(MAIN_SPLIT_REGEX);
                if (values.length == 1)
                    values = line.split(SPLIT_REGEX);
                else {
                    for (int i = 0; i < values.length; i++) {
                        values[i] = values[i].replace("\"", "");
                    }
                }
                ArrayList<Float> listProdutos = new ArrayList<>();
                for (int i = 2; i <values.length; i++) {
                    listProdutos.add(Float.parseFloat(values[i]));
                }
                Cabaz cabaz=new Cabaz(values[0], Integer.parseInt(values[1]),listProdutos);
                if(cpeStore.containsCPE(cabaz.getClienteProdutor())){
                    cpeStore.getCPE(cabaz.getClienteProdutor()).setCabaz(cabaz);
                }
                line = br.readLine();
            }
        } catch (NumberFormatException e) {
            throw new IOException("Invalid ID format");
        } catch (IllegalArgumentException e) {
            throw new IOException(e.getMessage());
        }
    }
}
