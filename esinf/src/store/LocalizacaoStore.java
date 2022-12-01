package store;

import domain.Localizacao;

import java.util.HashMap;
import java.util.Map;

public class LocalizacaoStore {
    private Map<String, Localizacao> localizacoes;

    public LocalizacaoStore() {
        localizacoes = new HashMap<>();
    }

    public void addLocalizacao(Localizacao localizacao) {
        localizacoes.put(localizacao.getLocID(), localizacao);
    }

    public Localizacao getLocalizacao(String id) {
        return localizacoes.get(id);
    }

    public void removeLocalizacao(String id) {
        localizacoes.remove(id);
    }

    public void removeLocalizacao(Localizacao localizacao) {
        localizacoes.remove(localizacao.getLocID());
    }

    public void clear() {
        localizacoes.clear();
    }

    public int size() {
        return localizacoes.size();
    }
}
