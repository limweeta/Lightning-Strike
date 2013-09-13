package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

@SuppressWarnings("serial")
public class ProjectDataManager implements Serializable {
	private static final int serialVersionUID = (int) 1L;
	
	public ProjectDataManager() {}
	
	public ArrayList<Project> retrieveAll() {
		ArrayList<Project> projects = new ArrayList<Project>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from projects");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	

			int id 				= 	Integer.parseInt(array.get(0));
			int coyId 			= 	Integer.parseInt(array.get(1));
			int teamId 			= 	Integer.parseInt(array.get(2));
			int sponsorId 		= 	Integer.parseInt(array.get(3));
			int supervisorId 	= 	Integer.parseInt(array.get(4));
			int reviewer1Id		=	Integer.parseInt(array.get(5));
			int reviewer2Id		=	Integer.parseInt(array.get(6));
			String projName		= 	array.get(7);
			String projDesc		= 	array.get(8);
			String status		= 	array.get(9);
			int industry		= 	Integer.parseInt(array.get(10));
			String termId 		= 	array.get(11);
			int creatorId 		= 	Integer.parseInt(array.get(12));
			
			
			Project proj = new Project(id, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry, termId, creatorId);
			projects.add(proj);
		}
		
		return projects;
	}
	
	// check for conflicting objects
	
	public Project retrieve(int id) throws Exception{
		Project proj = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from projects where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			
			int retrievedId 	= 	Integer.parseInt(array.get(0));
			int coyId 			= 	Integer.parseInt(array.get(1));
			int teamId 			= 	Integer.parseInt(array.get(2));
			int sponsorId 		= 	Integer.parseInt(array.get(3));
			int supervisorId 	= 	Integer.parseInt(array.get(4));
			int reviewer1Id		=	Integer.parseInt(array.get(5));
			int reviewer2Id		=	Integer.parseInt(array.get(6));
			String projName		= 	array.get(7);
			String projDesc		= 	array.get(8);
			String status		= 	array.get(9);
			int industry		= 	Integer.parseInt(array.get(10));
			String termId 		= 	array.get(11);
			int creatorId 		= 	Integer.parseInt(array.get(12));
			
			
			proj = new Project(retrievedId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry, termId, creatorId);
			
		}
		return proj;
	}
	
	public void add(Project proj){
		int id 				= proj.getId();
		String termId		= proj.getTermId();
		int coyId			= proj.getCoyId();
		int teamId			= proj.getTeamId();
		int sponsorId 		= proj.getSponsorId();
		int supervisorId 	= proj.getSupervisorId();
		int reviewer1Id		= proj.getReviewer1Id();
		int reviewer2Id		= proj.getReviewer2Id();
		String projName		= proj.getProjName();
		String projDesc		= proj.getProjDesc();
		String status		= proj.getStatus();
		int industry 		= proj.getIndustry();
		int creatorId		= proj.getCreatorId();
		
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`projects` "
				+ "VALUES ('" + id + "', " + coyId +", " + teamId + "," + sponsorId + ", " + supervisorId + ", " + reviewer1Id + ", " + reviewer2Id + ", '" + projName + "', '" + projDesc + "', '" + status + "', " + industry + ", '" + termId + "', " + creatorId + ");");
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
			
			int retrievedId 	= 	Integer.parseInt(array.get(0));
			int coyId 			= 	Integer.parseInt(array.get(1));
			int teamId 			= 	Integer.parseInt(array.get(2));
			int sponsorId 		= 	Integer.parseInt(array.get(3));
			int supervisorId 	= 	Integer.parseInt(array.get(4));
			int reviewer1Id		=	Integer.parseInt(array.get(5));
			int reviewer2Id		=	Integer.parseInt(array.get(6));
			String retrievedProjName		= 	array.get(7);
			String projDesc		= 	array.get(8);
			String status		= 	array.get(9);
			int industry		= 	Integer.parseInt(array.get(10));
			String termId 		= 	array.get(11);
			int creatorId 		= 	Integer.parseInt(array.get(12));
			
			project = new Project(retrievedId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry, termId, creatorId);
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

			int retrievedId 	= 	Integer.parseInt(array.get(0));
			int coyId 			= 	Integer.parseInt(array.get(1));
			int teamId 			= 	Integer.parseInt(array.get(2));
			int sponsorId 		= 	Integer.parseInt(array.get(3));
			int supervisorId 	= 	Integer.parseInt(array.get(4));
			int reviewer1Id		=	Integer.parseInt(array.get(5));
			int reviewer2Id		=	Integer.parseInt(array.get(6));
			String retrievedProjName		= 	array.get(7);
			String projDesc		= 	array.get(8);
			String status		= 	array.get(9);
			int industry		= 	Integer.parseInt(array.get(10));
			String retrievedTermId 		= 	array.get(11);
			int creatorId 		= 	Integer.parseInt(array.get(12));
			
			
			Project proj = new Project(retrievedId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, retrievedProjName, projDesc, status, industry, termId, creatorId);
			projects.add(proj);
		}
		
		return projects;
	}
	
	public ArrayList<Project> retrieveProjectsByIndustry(String industry){
		ArrayList<Project> projects = new ArrayList<Project>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project where project_industry LIKE '" + industry + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	

			int retrievedId 				= 	Integer.parseInt(array.get(0));
			int coyId 			= 	Integer.parseInt(array.get(1));
			int teamId 			= 	Integer.parseInt(array.get(2));
			int sponsorId 		= 	Integer.parseInt(array.get(3));
			int supervisorId 	= 	Integer.parseInt(array.get(4));
			int reviewer1Id		=	Integer.parseInt(array.get(5));
			int reviewer2Id		=	Integer.parseInt(array.get(6));
			String projName		= 	array.get(7);
			String projDesc		= 	array.get(8);
			String status		= 	array.get(9);
			int industry1		= 	Integer.parseInt(array.get(10));
			String termId 		= 	array.get(11);
			int creatorId 		= 	Integer.parseInt(array.get(12));
			
			Project proj = new Project(retrievedId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry1, termId, creatorId);
			projects.add(proj);
		}
		
		return projects;
	}
	
	public Project getProjFromTeam(ArrayList<Project> array, int teamid){
		
		Project proj = null;
		
		for(int i = 0; i < array.size(); i++){
			Project tmpProj = array.get(i);
			if(tmpProj.getId() == teamid){
				proj = tmpProj;
				break;
			}
		}
		
		return proj;
	}
	
	public Project getProjFromList(ArrayList<Project> array, int projId){
		
		Project proj = null;
		
		for(int i = 0; i < array.size(); i++){
			Project tmpProj = array.get(i);
			if(tmpProj.getId() == projId){
				proj = tmpProj;
				break;
			}
		}
		
		return proj;
	}
	
	public void addTech(int projid, int techid){
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project_technologies");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		int nextId = 0;
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			
			int retrievedId 	= 	Integer.parseInt(array.get(0));
			
			if(nextId <= retrievedId){
				nextId = retrievedId + 1;
			}
			
		}
		MySQLConnector.executeMySQL("insert", "INSERT INTO project_technologies VALUES (" + nextId + ", " + projid + ", " + techid + ");");
	}
	
	public void modify(Project p){
		int coyId = p.getCoyId();
		int teamId = p.getTeamId();
		int sponsorId = p.getSponsorId();
		int supervisorId = p.getSupervisorId();
		int rev1Id = p.getReviewer1Id();
		int rev2Id = p.getReviewer2Id();
		
		String projName = p.getProjName();
		String projDesc = p.getProjDesc();
		String projStatus = p.getStatus();
		
		int industryId = p.getIndustry();
		String termId = p.getTermId();
		
		MySQLConnector.executeMySQL("update", "UPDATE projects SET "
				+ "company_id = " + coyId + ", "
				+ "team_id = " + teamId + ", "
				+ "sponsor_id = " + sponsorId + ", "
				+ "supervisor_id = " + supervisorId + ", "
				+ "reviewer1Id = " + rev1Id + ", "
				+ "reviewer2Id = " + rev2Id + ", "
				+ "project_name = '" + projName + "', "
				+ "project_description = '" + projDesc + "', "
				+ "status = '" + projStatus + "', "
				+ "industry_id = " + industryId + ", "
				+ "termId = '" + termId + "' "
				+ "WHERE id = " + p.getId());
	}
	
	public void modifyTechnology(Project p, String[] techArray){
		MySQLConnector.executeMySQL("delete", "delete from project_technologies where project_id = " + p.getId() + ";");
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from project_technologies");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		int nextId = 0;
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			
			int retrievedId 	= 	Integer.parseInt(array.get(0));
			
			if(nextId <= retrievedId){
				nextId = retrievedId + 1;
			}
			
		}
		
		for(int i = 0; i < techArray.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO project_technologies VALUES(" + nextId +", " + p.getId() + ", " + Integer.parseInt(techArray[i]));
			nextId++;
		}
		
	}
	
	public void remove(int ID){
		MySQLConnector.executeMySQL("delete", "delete from projects where id = " + ID + ";");
		MySQLConnector.executeMySQL("delete", "delete from project_technologies where project_id = " + ID + ";");
	}
	
	public void removeAll() {
		
	}
}
