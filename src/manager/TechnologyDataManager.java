package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class TechnologyDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public TechnologyDataManager() {
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
	
	public ArrayList<Technology> retrieveByName(String tech) {
		Technology technology = null;
		ArrayList<Technology> techList = new ArrayList<Technology>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.technologies where technologies_name LIKE '%"	+ tech + "';");
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

	public void modify(Technology technology) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}