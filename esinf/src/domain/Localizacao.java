package domain;

import java.util.Objects;
import java.util.regex.Pattern;

public class Localizacao {

    private String locID;

    private float  latitude;

    private float  longitude;


    public Localizacao(String locID, float latitude, float longitude) {
        setLocID(locID);
        setLongitude(longitude);
        setLatitude(latitude);
    }

    public String getLocID() {
        return locID;
    }

    public void setLocID(String locID) {
        if (validateID(locID)) {
            this.locID = locID;
        } else {
            throw new IllegalArgumentException("Invalid ID: does not match pattern CT[0-9]+");
        }
    }

    public static boolean validateID(String locID) {
        return Pattern.matches("CT[0-9]+", locID);
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Localizacao that = (Localizacao) o;
        return Float.compare(this.getLatitude(), that.getLatitude()) == 0 && Float.compare(this.getLongitude(), that.getLongitude()) == 0 && this.getLocID().equals(that.getLocID());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getLocID());
    }

    @Override
    public String toString() {
        return String.format("(%f ; %f) : %s", latitude, longitude, locID);
    }
}
