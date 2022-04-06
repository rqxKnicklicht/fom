import java.util.GregorianCalendar;

public class Messwert {
    private static int anzahlMesswerte;
    private double wert;
    private GregorianCalendar messDatum;
    private int messwertID;

    public Messwert(double messwert, GregorianCalendar messDatum){
        this.wert = messwert;
        this.messDatum = messDatum;
    }

    public double getWert(){
        return this.wert;
    }

    public GregorianCalendar getMessDatum(){
        return this.messDatum;
    }

    public int getMesswertID(){
        return this.messwertID;
    }

}
