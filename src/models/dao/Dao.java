package models.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import models.Asiakas;

public class Dao {
	private Connection con=null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep=null; 
	private String sql;
	private String db ="Myynti.sqlite";
	
	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");    	
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/"); //Eclipsessa
    	String project = "Asiakaslista/" ;
    	//path += "/webapps/"; //Tuotannossa. Laita tietokanta webapps-kansioon
    	String url = "jdbc:sqlite:"+path+project+db;
    	System.out.println(url);
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Yhteys avattu.");
	     }catch (Exception e){	
	    	 System.out.println("Yhteyden avaus epäonnistui.");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	
	public ArrayList<Asiakas> listaaKaikki(String haku){
		System.out.println("Hakusana:" + haku);
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat where etunimi like '% ? %'";
		try {
			con=yhdista();
			if(con!=null){ //jos yhteys onnistui
				stmtPrep = con.prepareStatement("SELECT * FROM asiakkaat where etunimi like ? or sukunimi like ? or sposti like ?");
				stmtPrep.setString(1, "%" + haku + "%");
				stmtPrep.setString(2, "%" + haku + "%");
				stmtPrep.setString(3, "%" + haku + "%");
				
        		rs = stmtPrep.executeQuery();   
				if(rs!=null){ //jos kysely onnistui
					//con.close();					
					while(rs.next()){
						Asiakas asiakas = new Asiakas();
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));	
						asiakas.setSposti(rs.getString(5));	
						asiakkaat.add(asiakas);
					}					
				}				
			}	
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(asiakkaat);
		return asiakkaat;
	}
	
	public boolean lisaaAsiakas(Asiakas asiakas){
		boolean paluuArvo=true;
		sql="INSERT INTO asiakkaat(etunimi,sukunimi,puhelin,sposti) VALUES(?,?,?,?)";						  
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql); 
			stmtPrep.setString(1, asiakas.getEtunimi());
			stmtPrep.setString(2, asiakas.getSukunimi());
			stmtPrep.setString(3, asiakas.getPuhelin());
			stmtPrep.setString(4, asiakas.getSposti());
			stmtPrep.executeUpdate();
	        con.close();
		} catch (Exception e) {				
			e.printStackTrace();
			paluuArvo=false;
		}				
		return paluuArvo;
	}
	
	public boolean poistaAsiakas(String sposti){ //Oikeassa el�m�ss� tiedot ensisijaisesti merkit��n poistetuksi.
		boolean paluuArvo=true;
		sql="DELETE FROM asiakkaat WHERE sposti=?";						  
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql); 
			stmtPrep.setString(1, sposti);			
			stmtPrep.executeUpdate();
	        con.close();
		} catch (Exception e) {				
			e.printStackTrace();
			paluuArvo=false;
		}				
		return paluuArvo;
	}	
	
	
}
