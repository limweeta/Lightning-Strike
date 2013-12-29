package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class TechnologyDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public TechnologyDataManager() {
	}
	
	public ArrayList<Technology> retrieveTechCatIdByProject(int catid, int subcatid, int projId){
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		
		switch (catid){
			case 1:
				technologies = retrievePlatformTechByProj(subcatid, projId);
				break;
			case 2:
				technologies = retrieveDevToolsTechByProj(subcatid, projId);
				break;
			case 3:
				technologies = retrieveLanguageTechByProj(subcatid, projId);
				break;
			case 4:
				technologies = retrieveFrameworkTechByProj(subcatid, projId);
				break;
			case 5:
				technologies = retrieveOtherTechByProj(subcatid, projId);
				break;
			default:
				technologies = new ArrayList<Technology>();
				break;
		}
		
		Collections.sort(technologies, new Comparator<Technology>() {
	        @Override public int compare(Technology t1, Technology t2) {
	            	return t1.getTechName().compareTo(t2.getTechName());
	        }
		});
		
		return technologies;
	}
	
	public ArrayList<Technology> retrieveTechSubCatId(int catid, int subCatId){
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		
		switch (catid){
			case 1:
				technologies = retrievePlatformTech(subCatId);
				break;
			case 2:
				technologies = retrieveDevToolsTech(subCatId);
				break;
			case 3:
				technologies = retrieveLanguageTech(subCatId);
				break;
			case 4:
				technologies = retrieveFrameworkTech(subCatId);
				break;
			case 5:
				technologies = retrieveOtherTech(subCatId);
				break;
			default:
				technologies = new ArrayList<Technology>();
				break;
		}
		
		Collections.sort(technologies, new Comparator<Technology>() {
	        @Override public int compare(Technology t1, Technology t2) {
	            	return t1.getTechName().compareTo(t2.getTechName());
	        }
		});
		
		return technologies;
	}
	
	public String retrieveTechCatName(int catid) {
		String catName = "";
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT category_name FROM `is480-matching`.tech_category WHERE id = " + catid);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			catName = array.get(0);
		}
		return catName;
	}
	
	public String retrieveTechSubCatName(int subcatid) {
		String catName = "";
		if(subcatid == 0){
			catName =  "No Category";
		}else{
			HashMap<String, ArrayList<String>> map = MySQLConnector
					.executeMySQL("select", "SELECT sub_cat_name FROM `is480-matching`.tech_sub_cat WHERE id = " + subcatid);
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			if (iterator.hasNext()) {
				String key = iterator.next();
				ArrayList<String> array = map.get(key);
				catName = array.get(0);
			}
		}
		return catName;
	}
	
	public ArrayList<Integer> retrieveTechSubCatIdList(int catid) {
		ArrayList<Integer> subcatIdList = new ArrayList<Integer>();
		
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT Distinct(id) FROM `is480-matching`.tech_sub_cat WHERE tech_cat_id = " + catid);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int subcatid = Integer.parseInt(array.get(0));
			
			subcatIdList.add(subcatid);
		}
		return subcatIdList;
	}
	
	public int retrieveNumOfSubCat(int catid) {
		int numOfSubCat = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT COUNT(id) FROM `is480-matching`.tech_sub_cat WHERE tech_cat_id = " + catid);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			numOfSubCat = Integer.parseInt(array.get(0));
		}
		return numOfSubCat;
	}
	
	public int retrieveNoOfTechCat() {
		int numOfTechCat = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT COUNT(id) FROM `is480-matching`.tech_category");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			numOfTechCat = Integer.parseInt(array.get(0));
		}
		return numOfTechCat;
	}
	
	public ArrayList<Technology> retrieveTechByTeam(int teamid) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT technology_id FROM `is480-matching`.team_preferred_technology WHERE team_id = " + teamid);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		TechnologyDataManager tdm = new TechnologyDataManager();
		
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			
			try{
				Technology retrievedTech = tdm.retrieve(id);
				
				String techName = retrievedTech.getTechName();
				
				Technology technology = new Technology(id, techName);
				technologies.add(technology);
			}catch(Exception e){}
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveAll() {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT * FROM `is480-matching`.technologies");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		
		Collections.sort(technologies, new Comparator<Technology>() {
	        @Override public int compare(Technology t1, Technology t2) {
	            	return t1.getTechName().compareTo(t2.getTechName());
	        }
		});
		
		return technologies;
	}
	
	public ArrayList<Technology> retrievePlatformTech(int subCatId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subCatId == 0){
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 1 AND tech_sub_cat_id IS NULL";
		}else{
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 1 AND tech_sub_cat_id = " + subCatId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveDevToolsTech(int subCatId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subCatId == 0){
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 2 AND tech_sub_cat_id IS NULL";
		}else{
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 2 AND tech_sub_cat_id = " + subCatId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveLanguageTech(int subCatId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subCatId == 0){
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 3 AND tech_sub_cat_id IS NULL";
		}else{
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 3 AND tech_sub_cat_id = " + subCatId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveFrameworkTech(int subCatId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subCatId == 0){
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 4 AND tech_sub_cat_id IS NULL";
		}else{
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 4 AND tech_sub_cat_id = " + subCatId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveOtherTech(int subCatId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subCatId == 0){
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 5 AND tech_sub_cat_id IS NULL";
		}else{
			query = "SELECT * FROM `is480-matching`.technologies WHERE tech_cat_id = 5 AND tech_sub_cat_id = " + subCatId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrievePlatformTechByProj(int subcatid, int projId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subcatid == 0){
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NULL "
					+ "AND t.tech_cat_id = 1 and pt.project_id = " + projId;
		}else{
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NOT NULL "
					+ "AND t.tech_cat_id = 1 and pt.project_id = " + projId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveDevToolsTechByProj(int subcatid, int projId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subcatid == 0){
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NULL "
					+ "AND t.tech_cat_id = 2 and pt.project_id = " + projId;
		}else{
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NOT NULL "
					+ "AND t.tech_cat_id = 2 and pt.project_id = " + projId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveLanguageTechByProj(int subcatid, int projId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subcatid == 0){
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NULL "
					+ "AND t.tech_cat_id = 3 and pt.project_id = " + projId;
		}else{
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NOT NULL "
					+ "AND t.tech_cat_id = 3 and pt.project_id = " + projId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveFrameworkTechByProj(int subcatid, int projId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subcatid == 0){
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NULL "
					+ "AND t.tech_cat_id = 4 and pt.project_id = " + projId;
		}else{
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NOT NULL "
					+ "AND t.tech_cat_id = 4 and pt.project_id = " + projId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public ArrayList<Technology> retrieveOtherTechByProj(int subcatid, int projId) {
		ArrayList<Technology> technologies = new ArrayList<Technology>();
		String query = "";
		if(subcatid == 0){
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NULL "
					+ "AND t.tech_cat_id = 5 and pt.project_id = " + projId;
		}else{
			query = "SELECT * FROM technologies t, project_technologies pt, technologies tech "
					+ "WHERE tech.tech_cat_id = pt.technology_id AND t.id = pt.technology_id AND tech.tech_sub_cat_id IS NOT NULL "
					+ "AND t.tech_cat_id = 5 and pt.project_id = " + projId;
		}
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			Technology technology = new Technology(id, techName);
			technologies.add(technology);
		}
		return technologies;
	}
	
	public boolean hasTech(ArrayList<String> tech, Technology techCheck){
		boolean hasTech = false;
			for(int i = 0; i < tech.size(); i++){
				if(techCheck.getId() == Integer.parseInt(tech.get(i))){
					hasTech = true;
				}
			}
		return hasTech;
	}
	
	public boolean hasPrefTech(int teamId, int techId) {
		boolean hasTech = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT technology_Id FROM `is480-matching`.team_preferred_technology WHERE technology_id =" + techId + " AND team_id = " + teamId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			
			hasTech = true;
		}
		return hasTech;
	} 
	
	public ArrayList<String> retrieveByProjId(int projId) {
		ArrayList<String> proj_tech = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT technology_Id FROM `is480-matching`.project_technologies WHERE project_Id = " + projId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			String techId = array.get(0);
			
			proj_tech.add(techId);
		}
		return proj_tech;
	}
	
	public Technology retrieve(int id) throws Exception {
		Technology technology = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.technologies where technologies.id = "	+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int techid = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			technology = new Technology(techid, techName);
		}
		return technology;
	}
	
	public int retrieveTechId(String tech) {
		int techId = 0;
		ArrayList<Technology> techList = new ArrayList<Technology>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.technologies where technology LIKE '%"	+ tech + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			techId = Integer.parseInt(array.get(0));
		}
		
		return techId;
	}
	
	public ArrayList<Technology> retrieveByName(String tech) {
		Technology technology = null;
		ArrayList<Technology> techList = new ArrayList<Technology>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.technologies where technology LIKE '%"	+ tech + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int techid = Integer.parseInt(array.get(0));
			String techName = array.get(1);
			
			technology = new Technology(techid, techName);
			techList.add(technology);
		}
		return techList;
	}

	public void add(Technology technology) {
		int id = technology.getId();
		String tech = technology.getTechName();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`technologies` VALUES ("	+ id + ", '" + tech  + "');");
	}

	public void add(String newTech) {
		if(newTech.length() > 2){
			MySQLConnector.executeMySQL("insert",
					"INSERT INTO `is480-matching`.`technologies` (technology, tech_sub_cat_id, tech_cat_id)"
					+ " VALUES ('"	+ newTech + "', NULL, 5);");
		}
	}
	
	public void modify(Technology technology) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}