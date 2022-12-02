package domain.WaterController;

public class Sector {
    private String name;
    private int duration;
    private String regularity;

    public Sector(String name, int duration, String regularity) {
        this.name = name;
        this.duration = duration;
        this.regularity = regularity;
    }

    public String getName() {
        return name;
    }

    public int getDuration() {
        return duration;
    }

    public String getRegularity() {
        return regularity;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setRegularity(String regularity) {
        this.regularity = regularity;
    }


    @Override
    public String toString() {
        return "Sector{" +
                "name='" + name + '\'' +
                '}';
    }
}
