package stats;

import java.util.ArrayList;
import java.util.List;

public class ListStatistics {

    private String owner;

    private List<Statistic<?>> stats;

    public ListStatistics(String owner, List<Statistic<?>> stats) {
        this.owner = owner;
        this.stats = stats;
    }

    public ListStatistics(String owner) {
        this.owner = owner;
        this.stats = new ArrayList<>();
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public List<Statistic<?>> getStats() {
        return stats;
    }

    public void setStats(List<Statistic<?>> stats) {
        this.stats = stats;
    }

    public void addStat(Statistic<?> stat) {
        this.stats.add(stat);
    }

    public <E> void addStat(String statName, E statValue) {
        this.stats.add(new Statistic<>(statName, statValue));
    }

    @Override
    public String toString() {
        return String.format("%s's stats", owner);
    }

}
