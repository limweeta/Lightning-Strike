package com.is480matching.manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import com.is480matching.model.*;

public class ProjectDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public ProjectDataManager() {}
	
	public ArrayList<Project> retrieveAll() {
		ArrayList<Project> projects = new ArrayList<Project>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	

			Long termID = Long.parseLong(array.get(0));
			String projName = array.get(1);
			//String sponsor = array.get(2);
			String projDesc = array.get(2);
			//String projScope = array.get(3);
			String projDeliv = array.get(3);
			//need to get status too
			String industry = array.get(4);
			String tech = array.get(5);
			String contact = array.get(6);
			
			
			Project proj = new Project(termID, projName, projDesc, "Pending", industry, tech, contact);
			projects.add(proj);
		}
		
		return projects;
	}
	
	// check for conflicting objects
	
	public Project retrieve(String projLookup) throws Exception{
		Project proj = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from team where team_Name = '" + projLookup + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			Long termID = Long.parseLong(array.get(0));
			String projName = array.get(1);
			//String sponsor = array.get(2);
			String projDesc = array.get(2);
			//String projScope = array.get(3);
			String projDeliv = array.get(3);
			//need to get status too
			String industry = array.get(4);
			String tech = array.get(5);
			String contact = array.get(6);
			
			
			proj = new Project(termID, projName, projDesc, "Pending", industry, tech, contact);
			
		}
		return proj;
	}
	
	public void add(Project proj){
		Long termID = proj.getTermId();
		String projName = proj.getName();
		String projDesc = proj.getDescription();
		String projStatus = proj.getStatus();
		String industry = proj.getIndustry();
		String tech = ""; //add getter for technology and contact
		String contact = "";
		
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`project` "
				+ "(`team_name`, `user_username`, `team_limit`) "
				+ "VALUES ('" + termID + "', '" + projName + "', '" 
				+ projDesc +", " + projStatus + "," + industry + ", " + tech + ", " + contact + "');");
		
		System.out.println("Project added successfully");
	}
	
	public Project retrieveProjectsByName(String projName){
		Project project = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project where project_name = '" + projName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			Long Id = Long.parseLong(array.get(0));
			Long termId = Long.parseLong(array.get(1));
			String name = array.get(2);
			String description = array.get(3);
			String status = array.get(4);
			String industry = array.get(5);
			String organization = array.get(6);
			String teamName = array.get(7);
			
			project = new Project(termId,name,description,status,industry,organization,teamName);
		}
		
		return project;
	}
	
	public ArrayList<Project> retrieveProjectsByTerm(String termId){
		ArrayList<Project> projects = new ArrayList<Project>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project where term_id = '" + termId + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	

			Long projectID = Long.parseLong(array.get(0));
			Long termID = Long.parseLong(array.get(1));
			String projName = array.get(2);
			String projDesc = array.get(3);
			String projStatus = array.get(4);
			String projIndustry = array.get(5);
			String projOrg = array.get(6);
			String teamName = array.get(7);
			
			
			Project proj = new Project(projectID, termID, projName, projDesc, projStatus, projIndustry, projOrg, teamName);
			projects.add(proj);
		}
		
		return projects;
	}
	
	public ArrayList<Project> retrieveProjectsByIndustry(String industry){
		ArrayList<Project> projects = new ArrayList<Project>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project where project_industry = '" + industry + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	

			Long projectID = Long.parseLong(array.get(0));
			Long termID = Long.parseLong(array.get(1));
			String projName = array.get(2);
			String projDesc = array.get(3);
			String projStatus = array.get(4);
			String projIndustry = array.get(5);
			String projOrg = array.get(6);
			String teamName = array.get(7);
			
			
			Project proj = new Project(projectID, termID, projName, projDesc, projStatus, projIndustry, projOrg, teamName);
			projects.add(proj);
		}
		
		return projects;
	}
	
	public void modify(){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
