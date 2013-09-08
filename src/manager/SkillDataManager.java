package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class SkillDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public SkillDataManager() {}
	
	public ArrayList<Skill> retrieveAll() {
		ArrayList<Skill> skills = new ArrayList<Skill>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String skillName = array.get(1);
			
			Skill skill = new Skill(id, skillName);
			skills.add(skill);
		}
		
		return skills;
	}
	
	// check for conflicting objects
	
	public Skill retrieve(int id) throws Exception{
		Skill retrievedSkill = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String skillName = array.get(1);
			
			retrievedSkill = new Skill(retrievedId, skillName);
		}
		return retrievedSkill;
	}
	
	public void add(Skill skill){
		int skillId		=	skill.getId();
		String skillName = 	skill.getSkillName();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`skills` "
				+ "VALUES (" + skillId + ", '" + skillName + ");");
	}
	
	public ArrayList<Integer> getUserSkills(ArrayList<Student> members){
		ArrayList<Integer> userSkills = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from user_skills");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			int userId = Integer.parseInt(array.get(1));
			int skillId = Integer.parseInt(array.get(2));
			
			for(int i = 0; i < members.size(); i++){
				if(members.get(i).getID() == userId){
					userSkills.add(skillId);
				}
			}
			
		}
		
		return userSkills;
	}
	
	public void modify(){
		
	}
	
	public void remove(int ID){
		MySQLConnector.executeMySQL("delete", "Delete FROM skills WHERE id = " + ID);
	}
	
	public void removeAll() {
		
	}
}
