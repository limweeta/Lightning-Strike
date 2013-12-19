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
		
		Collections.sort(industries, new Comparator<Industry>() {
	        @Override public int compare(Industry i1, Industry i2) {
	            	return i1.getIndustryName().compareTo(i2.getIndustryName());
	        }
		});
		
		return industries;
	}
	
	public ArrayList<Industry> retrieveInd(String industryName) {
		ArrayList<Industry> industries = new ArrayList<Industry>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from industry where industry_name LIKE '%" + industryName +"%'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String indName = array.get(1);
			
			Industry industry = new Industry(id, indName);
			industries.add(industry);
		}
		
		return industries;
	}
	
	public boolean hasPrefInd(int teamId, int indId) {
		boolean hasInd = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT industry_Id FROM `is480-matching`.team_preferred_industry WHERE industry_id =" + indId + " AND team_id = " + teamId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			
			hasInd = true;
		}
		return hasInd;
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
