package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import models.Asiakas;
import models.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Asiakkaat() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Get()");
		String pathInfo = request.getPathInfo() == null ? "/" : request.getPathInfo();			
		System.out.println("polku: "+ pathInfo);
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		String strJSON;
		//hae yksi
		if(pathInfo.indexOf("haeyksi")!=-1) {
			String asiakasIdString = pathInfo.replace("/haeyksi/", ""); //poistetaan polusta "/haeyksi/", j�ljelle j�� rekno	
			int asiakasId = Integer.parseInt(asiakasIdString);
			Asiakas asiakas = dao.etsiAsiakas(asiakasId);
			JSONObject JSON = new JSONObject();
			JSON.put("asiakas_id", asiakas.getAsiakas_id());
			JSON.put("etunimi", asiakas.getEtunimi());
			JSON.put("sukunimi", asiakas.getSukunimi());
			JSON.put("puhelin", asiakas.getPuhelin());
			JSON.put("sposti", asiakas.getSposti());	
			strJSON = JSON.toString();
			PrintWriter out = response.getWriter();
			out.println(strJSON);
		//hae kaikki	
		} else {
			String haku = pathInfo.replace("/", "");
			System.out.println("model hakusana:" + haku);
			asiakkaat = dao.listaaKaikki(haku);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(strJSON);			
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Post()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		System.out.println(jsonObj);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.lisaaAsiakas(asiakas)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  
		}else{
			out.println("{\"response\":0}");  
		}		
	}
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Put()");
		JSONObject jsonObj = new JsonStrToObj().convert(request); //Muutetaan kutsun mukana tuleva json-string json-objektiksi			
		response.setContentType("application/json");
		Asiakas asiakas = new Asiakas();
		Dao dao = new Dao();			
		PrintWriter out = response.getWriter();

		try {
			asiakas.setAsiakas_id(jsonObj.getInt("asiakas_id"));
			asiakas.setEtunimi(jsonObj.getString("etunimi"));
			asiakas.setSukunimi(jsonObj.getString("sukunimi"));
			asiakas.setPuhelin(jsonObj.getString("puhelin"));
			asiakas.setSposti(jsonObj.getString("sposti"));
			if(dao.muutaAsiakas(asiakas, asiakas.getAsiakas_id())){ //metodi palauttaa true/false
				out.println("{\"response\":1}");  //Auton muuttaminen onnistui {"response":1}
			}else{
				out.println("{\"response\":0}");  //Auton muuttaminen ep�onnistui {"response":0}
			}		
		} catch (Exception e) {
			out.println("{\"response\":0}");
		}
		
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Delete()");	
		String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, esim. /28		
		System.out.println("polku: "+pathInfo);
		int id = Integer.parseInt(pathInfo.replace("/", ""));		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.poistaAsiakas(id)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  
		}else{
			out.println("{\"response\":0}"); 
		}	
	}

}
