package model;

public class Asiakas {
	
	private String etunimi, sukunimi, sposti;
	private int asiakas_id, puhelin;
	public Asiakas() {
		super();
	}
	public Asiakas(String etunimi, String sukunimi, String sposti, int asiakas_id, int puhelin) {
		super();
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.sposti = sposti;
		this.asiakas_id = asiakas_id;
		this.puhelin = puhelin;
	}
	public String getEtunimi() {
		return etunimi;
	}
	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}
	public String getSukunimi() {
		return sukunimi;
	}
	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}
	public String getSposti() {
		return sposti;
	}
	public void setSposti(String sposti) {
		this.sposti = sposti;
	}
	public int getAsiakas_id() {
		return asiakas_id;
	}
	public void setAsiakas_id(int asiakas_id) {
		this.asiakas_id = asiakas_id;
	}
	public int getPuhelin() {
		return puhelin;
	}
	public void setPuhelin(int puhelin) {
		this.puhelin = puhelin;
	}
	@Override
	public String toString() {
		return "Asiakas [etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", sposti=" + sposti + ", asiakas_id="
				+ asiakas_id + ", puhelin=" + puhelin + "]";
	}
	
	

}
