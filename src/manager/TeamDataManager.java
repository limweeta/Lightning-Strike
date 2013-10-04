package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class TeamDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public TeamDataManager() {}
	
	public ArrayList<Team> retrieveAll() {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			String teamDesc = array.get(2);
			int teamLimit	= Integer.parseInt(array.get(3));
			int pmId		= Integer.parseInt(array.get(4));
			int supId 		= Integer.parseInt(array.get(5));
			
			Team team = new Team(id, teamName, teamDesc,teamLimit, pmId, supId);
			teams.add(team);
		}
		
		return teams;
	}
	
	public boolean emptySlots(Team team){
		boolean result = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from students WHERE team_id = " + team.getId());
		
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		int numOfStudents = 0;
		
		while (iterator.hasNext()){
			numOfStudents++;
		}
		
		if(numOfStudents < team.getTeamLimit()){
			result = true;
		}else{
			result = false;
		}
		
		return result;
	}
	
	public ArrayList<Integer> retrieveTeamSkills(Team team){
		ArrayList<Integer> teamSkills = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select DISTINCT sk.skill_id from students std, user_skills sk WHERE sk.user_id = std.id AND std.team_id = " + team.getId() + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int skillId	= Integer.parseInt(array.get(0));
			
			teamSkills.add(skillId);
			
		}
		return teamSkills;
	}
	
	public ArrayList<Integer> retrieveTeamPreferredTechnology(Team team){
		ArrayList<Integer> teamPreferredTech = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select technology_id from team_preferred_technology where team_id = " + team.getId() + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int techId	= Integer.parseInt(array.get(0));
			
			teamPreferredTech.add(techId);
			
		}
		return teamPreferredTech;
	}
	
	public ArrayList<Integer> retrieveTeamPreferredIndustry(Team team){
		ArrayList<Integer> teamPreferredIndustry = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select industry_id from industry where team_id = " + team.getId() + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int industryId	= Integer.parseInt(array.get(0));
			
			teamPreferredIndustry.add(industryId);
			
		}
		return teamPreferredIndustry;
	}
	
	// check for conflicting objects
	
	public int retrievebyStudent(int id) throws Exception{
		int teamId = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select team_id from students where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			teamId	= Integer.parseInt(array.get(0));
			//retrievedTeam = new Team(retrievedId, teamName, teamDesc,teamLimit, pmId);
		}
		return teamId;
	}
	
	public Team retrieve(int id) throws Exception{
		Team retrievedTeam = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			String teamDesc = array.get(2);
			int teamLimit	= Integer.parseInt(array.get(3));
			int pmId		= Integer.parseInt(array.get(4));
			int supId		= Integer.parseInt(array.get(5));
			
			retrievedTeam = new Team(retrievedId, teamName, teamDesc,teamLimit, pmId, supId);
		}
		return retrievedTeam;
	}
	
	public void add(Team team, String[] prefIndustry, String[] prefTech){
		int teamId		=	team.getId();
		String teamName = 	team.getTeamName();
		String teamDesc	=	team.getTeamDesc();
		int teamLimit	=	team.getTeamLimit();
		int pmId		=	team.getPmId();
		int supId		=	team.getSupId();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`teams` "
				+ "(`id`, `team_name`, `team_description`, `team_limit`, `pm_id`, `supervisor_id`) "
				+ "VALUES (" + teamId + ", '" + teamName + "', '" + teamDesc +"', " + teamLimit + ", " + pmId + ", " + supId + ");");
		
		for(int i = 0; i < prefIndustry.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_industry` "
					+ "(`team_id`, `industry_id`) "
					+ "VALUES (" + teamId + ", " + Integer.parseInt(prefIndustry[i]) + ");");
		}
		
		for(int i = 0; i < prefTech.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_technology` "
					+ "(`team_id`, `technology_id`) "
					+ "VALUES (" + teamId + ", " + Integer.parseInt(prefTech[i]) + ");");
		}
		
	}
		
	
	public void updateTeamTechIfTeamDeleted(int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM team_preferred_technology WHERE team_id = " + teamId);
		//System.out.println("Updated Student table");
	}
	
	public void updateTeamIndustryIfTeamDeleted(int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM team_preferred_industry WHERE team_id = " + teamId);
		//System.out.println("Updated Student table");
	}
	
	public void updateStudentsIfTeamDeleted(int teamId){
		MySQLConnector.executeMySQL("update", "UPDATE STUDENTS SET team_id = " + 0 + " WHERE team_id = " + teamId);
		//System.out.println("Updated Student table");
	}
	
	public void updateProjectIfTeamDeleted(int teamId){
		MySQLConnector.executeMySQL("update", "UPDATE PROJECTS SET team_id = " + 0 + " WHERE team_id = " + teamId + " AND status NOT LIKE 'Closed'");
		//System.out.println("Updated Projects table");
	}
	
	public void modify(Team team){
		MySQLConnector.executeMySQL("update", "UPDATE teams SET "
				+ "team_name = '" + team.getTeamName() + "', "
				+ "team_description = '" + team.getTeamDesc() + "', "
				+ "team_limit = " + team.getTeamLimit() + ", "
				+ "pm_id = " + team.getPmId() + ", "
				+ "supervisor_id = " + team.getSupId() + " "
				+ "WHERE id = " + team.getId());
	}
	
	public void modifyStudents(Team team, String[] members, String[] roles){
		//CLEAR ALL CURRENT TEAM MEMBERS INFO
		for(int i = 0; i < members.length; i++){
			MySQLConnector.executeMySQL("update", "UPDATE students SET "
					+ "role = '', "
					+ "team_id = 0 "
					+ "WHERE id = " + Integer.parseInt(members[i]));
		}
		
		
		//UPDATE WITH NEW MEMBERS AND ROLES
		for(int i = 0; i < members.length; i++){
			MySQLConnector.executeMySQL("update", "UPDATE students SET "
					+ "role = " + Integer.parseInt(roles[i]) + ", "
					+ "team_id = " + team.getId() + ", "
					+ "WHERE id = " + Integer.parseInt(members[i]));
		}
		
	}
	
	public void removeMember(int userId){
		MySQLConnector.executeMySQL("UPDATE", "UPDATE students SET team_id = 0, role_id = 0 WHERE id = " + userId);
	}
	
	public void remove(int ID){
		MySQLConnector.executeMySQL("delete", "Delete FROM teams WHERE id = " + ID);
	}
	
	public void removeAll() {
		
	}
}
