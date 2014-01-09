package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class SkillDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public SkillDataManager() {}
	
	//retrieve skills that are not language
	public ArrayList<Skill> retrieveAllOthers() {
		ArrayList<Skill> skills = new ArrayList<Skill>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills WHERE skill_type NOT LIKE 'Language'");
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
		
		Collections.sort(skills, new Comparator<Skill>() {
	        @Override public int compare(Skill s1, Skill s2) {
	            	return s1.getSkillName().compareTo(s2.getSkillName());
	        }
		});
		
		return skills;
	}
	
	//retrieve language skills
	public ArrayList<Skill> retrieveAllLang() {
		ArrayList<Skill> skills = new ArrayList<Skill>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills WHERE skill_type LIKE 'Language'");
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
		
		Collections.sort(skills, new Comparator<Skill>() {
	        @Override public int compare(Skill s1, Skill s2) {
	            	return s1.getSkillName().compareTo(s2.getSkillName());
	        }
		});
		
		return skills;
	}
	
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
		
		Collections.sort(skills, new Comparator<Skill>() {
	        @Override public int compare(Skill s1, Skill s2) {
	            	return s1.getSkillName().compareTo(s2.getSkillName());
	        }
		});
		
		return skills;
	}
	
	//retrieve list of skill based on a particular user input
	public ArrayList<Skill> retrieveAllSkillsByKeyword(String keyword) {
		ArrayList<Skill> skills = new ArrayList<Skill>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills WHERE skill_name LIKE '%" + keyword + "%'");
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
		
		Collections.sort(skills, new Comparator<Skill>() {
	        @Override public int compare(Skill s1, Skill s2) {
	            	return s1.getSkillName().compareTo(s2.getSkillName());
	        }
		});
		
		return skills;
	}
	
	
	
	public int retrieveSkillId(String skillName){
		int skillId = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills where skill_name LIKE '" + skillName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			skillId = Integer.parseInt(array.get(0));
			
		}
		return skillId;
	}
	
	public Skill retrieveSkill(String skillName) throws Exception{
		Skill retrievedSkill = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from skills where skill_name LIKE '" + skillName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String skName = array.get(1);
			
			retrievedSkill = new Skill(retrievedId, skName);
		}
		return retrievedSkill;
	}
	
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
	
	public void add(String skillName, String skillType){
		if(skillName.trim().length() > 2){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`skills`(skill_name, skill_type) "
					+ "VALUES ('" + skillName + "', '" + skillType + ");");
		}
	}
	
	
	//checks if a user has a particular skill
	public boolean hasSkill(ArrayList<String> skills, Skill skillCheck) throws Exception{
		boolean hasTech = false;
			for(int i = 0; i < skills.size(); i++){
				Skill skill = retrieveSkill(skills.get(i));
				if(skillCheck.getId() == skill.getId()){
					hasTech = true;
				}
			}
		return hasTech;
	}
	
	//retrieves all the skills in a team
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
					if(userSkills.size() == 0){
						userSkills.add(skillId);
					}else{
						for(int j = 0; j < userSkills.size(); j++){
							if(userSkills.get(i) != skillId){
								userSkills.add(skillId);
							}
						}
					}
				}
			}
			
		}
		
		
		
		return userSkills;
	}
	
	//retrieves all the language skills for a particular user
	public ArrayList<String> getUserLangSkills(User u){
		ArrayList<String> userSkills = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from user_skills us, skills s WHERE s.id = us.skill_id AND s.skill_type LIKE 'Language' AND us.user_id = " + u.getID());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			int userId = Integer.parseInt(array.get(1));
			int skillId = Integer.parseInt(array.get(2));
			
			Skill skill = null;
			String skillName = "";
			try{
				skill = retrieve(skillId);
				skillName = skill.getSkillName();
				userSkills.add(skillName);
			}catch(Exception e){}
		}
		return userSkills;
	}
	
	//retrieves all the other skills for a particular user
	public ArrayList<String> getUserOtherSkills(User u){
		ArrayList<String> userSkills = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from user_skills us, skills s WHERE s.id = us.skill_id AND s.skill_type NOT LIKE 'Language' AND us.user_id = " + u.getID());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			int userId = Integer.parseInt(array.get(1));
			int skillId = Integer.parseInt(array.get(2));
			
			Skill skill = null;
			String skillName = "";
			try{
				skill = retrieve(skillId);
				skillName = skill.getSkillName();
				userSkills.add(skillName);
			}catch(Exception e){}
		}
		return userSkills;
	}
	
	//retrieves all skills for a particular user
	public ArrayList<String> getUserSkills(User u){
		ArrayList<String> userSkills = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from user_skills where user_id = " + u.getID());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			int userId = Integer.parseInt(array.get(1));
			int skillId = Integer.parseInt(array.get(2));
			
			Skill skill = null;
			String skillName = "";
			try{
				skill = retrieve(skillId);
				skillName = skill.getSkillName();
				userSkills.add(skillName);
			}catch(Exception e){}
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
