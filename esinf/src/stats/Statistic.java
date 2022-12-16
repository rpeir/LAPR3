package stats;

public class Statistic<E> {

    private String statName;

    private E statValue;

    public Statistic(String statName, E statValue) {
        this.statName = statName;
        this.statValue = statValue;
    }

    public String getStatName() {
        return statName;
    }

    public E getStatValue() {
        return statValue;
    }

    public void setStatName(String statName) {
        this.statName = statName;
    }

    public void setStatValue(E statValue) {
        this.statValue = statValue;
    }

    @Override
    public String toString() {
        return String.format("%s: %s", statName, statValue);
    }
}
