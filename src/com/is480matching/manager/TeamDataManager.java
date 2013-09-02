package com.is480matching.manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import com.is480matching.model.MySQLConnector;
import com.is480matching.model.*;

public class TeamDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public TeamDataManager() {}
	
	public ArrayList<Team> retrieveAll() {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from team");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String teamName = array.get(0);
			String projectManager = array.get(1);
			String teamLimit = array.get(2);
			
			Team team = new Team(teamName, projectManager, teamLimit);
			teams.add(team);
		}
		
		return teams;
	}
	
	// check for conflicting objects
	
	public Team retrieve(String teamLookup) throws Exception{
		Team team = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from team where team_Name = '" + teamLookup + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String teamName = array.get(0);
			String projectManager = array.get(1);
			String teamLimit = array.get(2);
			
			team = new Team(teamName, projectManager, teamLimit);
		}
		return team;
	}
	
	public void add(Team team, String[] teamMembers, String[] role){
		String teamName = team.getName();
		String projectManager = team.getProjectManager();
		int teamLimit = team.getTeamLimit();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team` "
				+ "(`team_name`, `user_username`, `team_limit`) "
				+ "VALUES ('" + teamName + "', '" + projectManager + "', '" 
				+ teamLimit +"');");
		
		for(int i = 0; i < role.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`teamrole` "
					+ "(`role_type`, `user_username`, `team_name`) "
					+ "VALUES ('" + teamMembers[i] + "', '" + role[i] + "', '" 
					+ teamName +"');");
		}
		
		System.out.println("Team added successfully");
	}
		
	public void modify(){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
