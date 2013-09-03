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
			
			Team team = new Team(id, teamName, teamDesc,teamLimit, pmId);
			teams.add(team);
		}
		
		return teams;
	}
	
	// check for conflicting objects
	
	public Team retrieve(int id) throws Exception{
		Team retrievedTeam = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams where id = '" + id + "';");
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
			
			retrievedTeam = new Team(retrievedId, teamName, teamDesc,teamLimit, pmId);
		}
		return retrievedTeam;
	}
	
	public void add(Team team){
		int teamId		=	team.getId();
		String teamName = 	team.getTeamName();
		String teamDesc	=	team.getTeamDesc();
		int teamLimit	=	team.getTeamLimit();
		int pmId		=	team.getPmId();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`teams` "
				+ "(`id`, `team_name`, `team_description`, `team_limit`, `pm_id`) "
				+ "VALUES ('" + teamId + "', '" + teamName + "', '" + teamDesc +"', '" + teamLimit + "', '" + pmId + "');");
		System.out.println("Team added successfully");
	}
		
	public void modify(){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
