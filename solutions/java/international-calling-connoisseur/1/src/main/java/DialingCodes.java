import java.util.Map;
import java.util.HashMap;

public class DialingCodes {
    private Map<Integer, String> codes;

    public DialingCodes() {
        codes = new HashMap<Integer, String>();
    }

    public Map<Integer, String> getCodes() {
        return codes;
    }

    public void setDialingCode(Integer code, String country) {
        codes.put(code, country);
    }

    public String getCountry(Integer code) {
        return codes.get(code);
    }

    public void addNewDialingCode(Integer code, String country) {
        if (!codes.containsKey(code) && !codes.values().contains(country)) {
            codes.put(code, country);
        }
    }

    public Integer findDialingCode(String country) {
        if (codes.values().contains(country)) {
            for (Integer k : codes.keySet()) {
                if (codes.get(k).equals(country)) {
                    return k;
                }
            }
        }
        return null;
    }

    public void updateCountryDialingCode(Integer code, String country) {
        Integer oldCode = this.findDialingCode(country);
        if (oldCode != null) {
            codes.remove(oldCode);
            codes.put(code, country);
        }
    }
}
