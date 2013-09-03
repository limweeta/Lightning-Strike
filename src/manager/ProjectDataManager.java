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
			int termId 			= 	Integer.parseInt(array.get(1));
			int coyId 			= 	Integer.parseInt(array.get(2));
			int teamId 			= 	Integer.parseInt(array.get(3));
			int sponsorId 		= 	Integer.parseInt(array.get(4));
			int supervisorId 	= 	Integer.parseInt(array.get(5));
			int reviewer1Id		=	Integer.parseInt(array.get(6));
			int reviewer2Id		=	Integer.parseInt(array.get(7));
			String projName		= 	array.get(8);
			String projDesc		= 	array.get(9);
			String status		= 	array.get(10);
			String industry		= 	array.get(11);
			
			
			Project proj = new Project(id, termId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry);
			projects.add(proj);
		}
		
		return projects;
	}
	
	// check for conflicting objects
	
	public Project retrieve(int id) throws Exception{
		Project proj = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from team where id = '" + id + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId 	= 	Integer.parseInt(array.get(0));
			int termId 			= 	Integer.parseInt(array.get(1));
			int coyId 			= 	Integer.parseInt(array.get(2));
			int teamId 			= 	Integer.parseInt(array.get(3));
			int sponsorId 		= 	Integer.parseInt(array.get(4));
			int supervisorId 	= 	Integer.parseInt(array.get(5));
			int reviewer1Id		=	Integer.parseInt(array.get(6));
			int reviewer2Id		=	Integer.parseInt(array.get(7));
			String projName		= 	array.get(8);
			String projDesc		= 	array.get(9);
			String status		= 	array.get(10);
			String industry		= 	array.get(11);
			
			
			proj = new Project(retrievedId, termId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, industry);
			
		}
		return proj;
	}
	
	public void add(Project proj){
		int id 			= proj.getId();
		int termId			= proj.getTermId();
		int coyId			= proj.getCoyId();
		int teamId			= proj.getTeamId();
		int sponsorId 		= proj.getSponsorId();
		int supervisorId 	= proj.getSupervisorId();
		int reviewer1Id		= proj.getReviewer1Id();
		int reviewer2Id		= proj.getReviewer2Id();
		String projName		= proj.getProjName();
		String projDesc		= proj.getProjDesc();
		String status		= proj.getStatus();
		String industry 	= proj.getIndustry();
		
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`projects` "
				+ "(`id`, `term_id`, `company_id`, `team_id`, `sponsor_id`, `supervisor_id`, `reviewer1_id`, `reviewer2_id`, `project_name`, `project_description`, `status`, `industry`) "
				+ "VALUES ('" + id + "', '" + termId + "', '" + coyId +", " + teamId + "," + sponsorId + ", " + supervisorId + ", " + reviewer1Id + ", " + reviewer2Id + ", " + projName + ", " + projDesc + ", " + status + ", " + industry + "');");
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
			int termId 			= 	Integer.parseInt(array.get(1));
			int coyId 			= 	Integer.parseInt(array.get(2));
			int teamId 			= 	Integer.parseInt(array.get(3));
			int sponsorId 		= 	Integer.parseInt(array.get(4));
			int supervisorId 	= 	Integer.parseInt(array.get(5));
			int reviewer1Id		=	Integer.parseInt(array.get(6));
			int reviewer2Id		=	Integer.parseInt(array.get(7));
			String retrievedProjName		= 	array.get(8);
			String projDesc		= 	array.get(9);
			String status		= 	array.get(10);
			String industry		= 	array.get(11);
			
			project = new Project(retrievedId, termId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, retrievedProjName, projDesc, status, industry);
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
			int retrievedTermId 			= 	Integer.parseInt(array.get(1));
			int coyId 			= 	Integer.parseInt(array.get(2));
			int teamId 			= 	Integer.parseInt(array.get(3));
			int sponsorId 		= 	Integer.parseInt(array.get(4));
			int supervisorId 	= 	Integer.parseInt(array.get(5));
			int reviewer1Id		=	Integer.parseInt(array.get(6));
			int reviewer2Id		=	Integer.parseInt(array.get(7));
			String retrievedProjName		= 	array.get(8);
			String projDesc		= 	array.get(9);
			String status		= 	array.get(10);
			String industry		= 	array.get(11);
			
			
			Project proj = new Project(retrievedId, retrievedTermId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, retrievedProjName, projDesc, status, industry);
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

			int retrievedId 	= 	Integer.parseInt(array.get(0));
			int termId 			= 	Integer.parseInt(array.get(1));
			int coyId 			= 	Integer.parseInt(array.get(2));
			int teamId 			= 	Integer.parseInt(array.get(3));
			int sponsorId 		= 	Integer.parseInt(array.get(4));
			int supervisorId 	= 	Integer.parseInt(array.get(5));
			int reviewer1Id		=	Integer.parseInt(array.get(6));
			int reviewer2Id		=	Integer.parseInt(array.get(7));
			String projName		= 	array.get(8);
			String projDesc		= 	array.get(9);
			String status		= 	array.get(10);
			String retrievedIndustry		= 	array.get(11);
			
			
			Project proj = new Project(retrievedId, termId, coyId, teamId, sponsorId, supervisorId, reviewer1Id, reviewer2Id, projName, projDesc, status, retrievedIndustry);
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
