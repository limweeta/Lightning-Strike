package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class IndustryDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public IndustryDataManager() {}
	
	public ArrayList<Industry> retrieveAll() {
		ArrayList<Industry> industries = new ArrayList<Industry>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from industry");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String industryName = array.get(1);
			
			Industry industry = new Industry(id, industryName);
			industries.add(industry);
		}
		
		return industries;
	}
	
	// check for conflicting objects
	
	public Industry retrieve(int id) throws Exception{
		Industry retrievedIndustry = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from industry where industry_id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String industryName = array.get(1);
			
			retrievedIndustry = new Industry(retrievedId, industryName);
		}
		return retrievedIndustry;
	}
	
	public void add(Industry industry){
		int industryId		=	industry.getIndustryId();
		String industryName = 	industry.getIndustryName();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`industry` "
				+ "VALUES (" + industryId + ", '" + industryName + ");");
	}
	
	public void modify(){
		
	}
	
	public void remove(int ID){
		MySQLConnector.executeMySQL("delete", "Delete FROM industry WHERE id = " + ID);
	}
	
	public void removeAll() {
		
	}
}
