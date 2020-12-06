package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import model.Asiakas;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Autot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("asiakkaat.doGet()");
		String pathInfo = request.getPathInfo();			
		System.out.println("polku: "+pathInfo);		
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		String strJSON="";
		if(pathInfo==null) { 
			asiakkaat = dao.listaaKaikki();
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
		}else if(pathInfo.indexOf("haeyksi")!=-1) {
			String etunimi = pathInfo.replace("/haeyksi/", "");		
			Asiakas asiakas = dao.etsiAsiakas(etunimi);
			JSONObject JSON = new JSONObject();
			JSON.put("etunimi", asiakas.getEtunimi());
			JSON.put("sukunimi", asiakas.getSukunimi());
			JSON.put("sposti", asiakas.getSposti());
			JSON.put("asiakas_id", asiakas.getAsiakas_id());
			JSON.put("puhelin", asiakas.getPuhelin());
			strJSON = JSON.toString();		
		}else{
			String hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
		}	
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);			
		Asiakas asiakas = new Asiakkaat();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setAsiakasID(jsonObj.getString("asiakas_id"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		asiakas.setPuhelin(jsonObj.getInt("puhelin"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.lisaaAsiakkaat(asiakas)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}		
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("asiakkaat.doPut()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);			
		String vanhaetunimi = jsonObj.getString("vanhaetunimi");
		Asiakas asiakas = new asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		asiakas.setAsiakas_id(jsonObj.getString("asiakas_id"));
		asiakas.setPuhelin(jsonObg.getInt("puhelin"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.muutaAsiakas(asiakas, vanhaetunimi)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}		
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");	
		String pathInfo = request.getPathInfo();		
		System.out.println("polku: "+pathInfo);
		String poistettavaEtunimi = pathInfo.replace("/", "");		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.poistaAsiakas(poistettavaEtunimi)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}	
	}

}
