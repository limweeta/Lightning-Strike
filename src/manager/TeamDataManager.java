package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class TeamDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public TeamDataManager() {}
	
	public ArrayList<String> retrieveSuitableSupervisors(int teamId) {
		ArrayList<String> teams = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from users u WHERE u.type NOT LIKE 'Student' AND u.type NOT LIKE 'Sponsor'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		ArrayList<User> supervisors = new ArrayList<User>();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
			User u = new User(retrievedId, username, fullName, contactNum, email, type);
			supervisors.add(u);
		}
		
		ArrayList<Integer> teamSkills = retrieveTeamSkillsById(teamId);
		
		UserDataManager udm = new UserDataManager();
		
		
		Map<Integer, Integer> matchScore = new HashMap<Integer, Integer>();
		
		for(int i = 0; i < supervisors.size(); i++){
			User tmpUser = supervisors.get(i);
			int numOfMatches = 0;
			for(int j = 0; j < teamSkills.size(); j++){
				int skillId = teamSkills.get(i);
				if(udm.hasSkill(tmpUser, skillId)){
					numOfMatches++;
				}
			}
			
			matchScore.put(tmpUser.getID(), numOfMatches);
		}
		
		Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>(matchScore);
		
		
		return teams;
	}
	
	public boolean hasProj(Team team){
		boolean hasProj = false;
		
		if(team != null){
			HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM projects WHERE team_id = " + team.getId());
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			if (iterator.hasNext()){
				hasProj = true;
			}
		}
		return hasProj;
	}
	
	public boolean hasInvited(int teamId, int sponsorId){
		boolean invited = false;
		
		if(sponsorId != 0){
			HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM invite_team WHERE team_id = " + teamId + " AND sponsor_id = " + sponsorId);
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			if (iterator.hasNext()){
				invited = true;
			}
		}
		return invited;
	}
	
	public String getTeamStatus(Team team){
		String status = "";
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT s.status FROM team_status ts, status s WHERE ts.status_id = s.status_id AND team_id = " + team.getId());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			status = array.get(0);
		}
		
		return status;
	}
	
	public ArrayList<Team> retrieveSupervisingCurrentTeams(String username) {
		UserDataManager udm = new UserDataManager();
		User u = null;
		
		try{
			u = udm.retrieve(username);
		}catch(Exception e){}
		
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams t, team_status ts "
				+ "WHERE t.id = ts.team_id AND ts.status_id <= 3 AND  t.supervisor_id = " + u.getID());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team addTeam = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(addTeam);
		}
		
		Collections.sort(teams, new Comparator<Team>() {
	        @Override public int compare(Team t1, Team t2) {
	            	return t1.getTeamName().compareTo(t2.getTeamName());
	        }
		});
		
		return teams;
	}
	
	public ArrayList<Team> retrieveSupervisingPastTeams(String username) {
		UserDataManager udm = new UserDataManager();
		User u = null;
		
		try{
			u = udm.retrieve(username);
		}catch(Exception e){}
		
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams t, team_status ts "
				+ "WHERE t.id = ts.team_id AND ts.status_id > 3 AND  t.supervisor_id = " + u.getID());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team addTeam = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(addTeam);
		}
		
		Collections.sort(teams, new Comparator<Team>() {
	        @Override public int compare(Team t1, Team t2) {
	            	return t1.getTeamName().compareTo(t2.getTeamName());
	        }
		});
		
		return teams;
	}
	
	public ArrayList<Student> retrieveAllStudents(Team team) {
		ArrayList<Student> members = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id WHERE students.team_id = " + team.getId());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id 				= Integer.parseInt(array.get(0));
			String username 	= array.get(1);
			String fullName 	= array.get(2);
			String contactNum 	= array.get(3);
			String email 		= array.get(4);
			String type			= array.get(5);
			String secondMajor 	= array.get(7);
			int role 			= Integer.parseInt(array.get(8));
			int teamId 			= Integer.parseInt(array.get(9));
			int prefRole 		= Integer.parseInt(array.get(10));
			
			Student student = new Student(id, username, fullName, contactNum, email, type,  secondMajor, role, teamId, prefRole);
			members.add(student);
		}
		
		return members;
	}
	
	public ArrayList<Team> retrieveAllByTerm(int reqTermId) {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams WHERE term_id = " + reqTermId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(team);
		}
		
		return teams;
	}
	
	public Map<Integer, Integer> analyticsRetrieveTeamByTerm() {
		ArrayList<Integer> rawList = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		HashMap<Integer, Integer> numOfTeamsByTerm = new HashMap<Integer, Integer>();
		int nullCounter = 0;
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			try{
				int termId 		= Integer.parseInt(array.get(7));
				int pmId 		= Integer.parseInt(array.get(3));
				int supId 		= Integer.parseInt(array.get(4));
				int rev1Id 		= Integer.parseInt(array.get(5));
				int rev2Id 		= Integer.parseInt(array.get(6));
				rawList.add(termId);
			}catch(Exception e){
				nullCounter ++;
				numOfTeamsByTerm.put(0, nullCounter);
			}

		}
		
		Integer counter = 0;
		for(int i  = 0; i < rawList.size(); i++){
			if(numOfTeamsByTerm.containsKey(rawList.get(i))){
				counter = numOfTeamsByTerm.get(rawList.get(i));
				numOfTeamsByTerm.put(rawList.get(i), counter + 1);
			}else{
				counter  = 1;
				numOfTeamsByTerm.put(rawList.get(i), counter);
			}
		}
		Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>(numOfTeamsByTerm);
		return sortedMap;
	}
	
	public ArrayList<Team> retrieveAllCurrentTeamsWithSupervisor() {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams t, team_status ts WHERE t.id=ts.team_id AND t.supervisor_id != 0 AND ts.status_id != 6");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(team);
		}
		
		Collections.sort(teams, new Comparator<Team>() {
	        @Override public int compare(Team t1, Team t2) {
	        	return t1.getTeamName().compareToIgnoreCase(t2.getTeamName());
	        }
		});
		
		return teams;
	}
	
	public ArrayList<Team> retrieveAllCurrentTeamsWithoutSupervisor() {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams t, team_status ts WHERE t.id=ts.team_id AND t.supervisor_id = 0 AND ts.status_id != 6");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(team);
		}
		
		Collections.sort(teams, new Comparator<Team>() {
	        @Override public int compare(Team t1, Team t2) {
	        	return t1.getTeamName().compareToIgnoreCase(t2.getTeamName());
	        }
		});
		
		return teams;
	}
	
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
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(team);
		}
		
		return teams;
	}
	
	public ArrayList<Team> retrieveAllByFilter(int term, String[] tech, String[] ind, String[] skills) {
	
		String query = "select * from teams t, team_preferred_industry tpi, team_preferred_technology tpt, students s, user_skills us"
				+ " WHERE t.id = tpi.team_id AND t.id = tpt.team_id AND s.team_id = t.id AND s.id = us.user_id";
		
		if(term != 0){
			query += " AND t.term_id = " + term;
		}
		
		if(ind != null && ind.length > 0){
			query += " AND (";
			for(int i = 0; i < ind.length; i++){
				query += " tpi.industry_id = " + ind[i];
				try{
					String j = ind[i+1];
					query += " OR";
				}catch(Exception e){}
			}
			
			query += ")";
			
		}
		
		if(tech != null && tech.length > 0){
			query += " AND (";
			for(int i = 0; i < tech.length; i++){
				query += " tpt.technology_id = " + tech[i];
				try{
					String j = tech[i+1];
					query += " OR";
				}catch(Exception e){}
			}
			
			query += ")";
		}
		
		if(skills != null && skills.length > 0){
			query += " AND (";
			for(int i = 0; i < skills.length; i++){
				query += " us.skill_id = " + skills[i];
				try{
					String j = skills[i+1];
					query += " OR";
				}catch(Exception e){}
			}
			
			query += ")";
		}
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", query);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		ArrayList<Team> teams = new ArrayList<Team>();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			teams.add(team);
		}
		System.out.println(query);
		return teams;
	}
	
	public ArrayList<Integer> retrieveStudentsInTeam(Team team) {
		ArrayList<Integer> membersId = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from students WHERE team_id = " + team.getId());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			
			membersId.add(id);
		}
		
		
		return membersId;
	}
	
	public ArrayList<String> retrieveStudentsInTeam(String teamName) {
		Team team = null;
		
		try{
			team = retrieveTeamByName(teamName);
		}catch(Exception e){}
		ArrayList<String> members = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select u.username from users u, students s WHERE s.id = u.id AND s.team_id =" + team.getId());
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String fullname = array.get(0);
			
			members.add(fullname);
		}
		
		return members;
	}
	
	public ArrayList<Team> retrieveStudentRequests(int studentId) {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM student_request WHERE student_id = " + studentId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int teamId	 	= Integer.parseInt(array.get(2));
			
			Team team = null;
			
			try{
				team = retrieve(teamId);
			}catch(Exception e){}
			
			teams.add(team);
		}
		
		return teams;
	}
	
	public ArrayList<Team> retrieveAllInvites(int studentId) {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM team_request WHERE student_id = " + studentId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int teamId	 	= Integer.parseInt(array.get(1));
			
			Team team = null;
			
			try{
				team = retrieve(teamId);
			}catch(Exception e){}
			
			teams.add(team);
		}
		
		return teams;
	}
	
	public ArrayList<Team> retrieveTeamsByAppliedProj(int projId) {
		ArrayList<Team> teams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from applied_projects WHERE project_id = " + projId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			Team team = null;
			
			try{
				team = retrieve(Integer.parseInt(array.get(2)));
				teams.add(team);
			}catch(Exception e){}
		
		}
		
		return teams;
	}
	
	public ArrayList<String> retrieveTeamNames() {
		ArrayList<String> teams = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String teamName = array.get(1);
			
			teams.add(teamName);
		}
		
		return teams;
	}
	
	public boolean emptySlots(Team team){
		boolean result = false;
		
		if(team == null){
			result = false;
		}else{
		
			HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select COUNT(id) from students WHERE team_id = " + team.getId());
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			int numOfStudents = 0;
	
			if (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				numOfStudents = Integer.parseInt(array.get(0));
			}
			
			if(numOfStudents < team.getTeamLimit()){
				result = true;
			}else{
				result = false;
			}
		}
		return result;
		
	}
	
	public boolean emptyPosition(Team team, Student std){
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select role_id from students WHERE team_id = " + team.getId());
		
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		boolean teamHasRole = false;
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int roleId = Integer.parseInt(array.get(0));
			
			if(std.getPreferredRole() == roleId){
				teamHasRole = true;
			}
		}
		
		return teamHasRole;
	}
	
	public ArrayList<Team> retrieveEligibleTeams(Student std) {
		ArrayList<Team> teams = new ArrayList<Team>();
		ArrayList<Team> allTeams = retrieveAll();
		
		for(int i = 0; i < allTeams.size(); i++){
			Team t = allTeams.get(i);
			
			//Check for empty slots and none of the student's preferredrole
			if(emptySlots(t) && !emptyPosition(t, std)){
				teams.add(t);
			}
		}
		
		return teams;
	}
	
	public Team retrieveTeamByName(String teamName){
		Team team = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams WHERE teams.team_Name LIKE '" + teamName + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String teamName2 = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			team = new Team(id, teamName2,teamLimit, pmId, supId, rev1, rev2, termId);
			
		}
		return team;
	}
	
	public int retrieveTeamIdByUser(User u){
		int teamId = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select team_id from students WHERE id = " + u.getID() + "");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			
			teamId = id;
			
		}
		return teamId;
	}
	
	public ArrayList<Integer> retrieveTeamSkillsById(int teamId){
		ArrayList<Integer> teamSkills = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select DISTINCT sk.skill_id from students std, user_skills sk WHERE sk.user_id = std.id AND std.team_id = " + teamId + ";");
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
	
	public ArrayList<Integer> retrieveTeamSkillsByOthers(Team team){
		ArrayList<Integer> teamSkills = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select DISTINCT sk.skill_id from students std, user_skills sk, skills s WHERE s.id=sk.skill_id AND sk.user_id = std.id AND std.team_id = " + team.getId() + " AND s.skill_type NOT LIKE 'Language';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int skillId	= Integer.parseInt(array.get(0));
			
			teamSkills.add(skillId);
			
		}
		
		Collections.sort(teamSkills, new Comparator<Integer>() {
	        @Override public int compare(Integer i1, Integer i2) {
	        	SkillDataManager skdm = new SkillDataManager();
	        		Skill skill1 = null;
	        		Skill skill2 = null;
					try {
						skill1 = skdm.retrieve(i1);
						skill2 = skdm.retrieve(i2);
					} catch (Exception e) {}
	            	return skill1.getSkillName().compareTo(skill2.getSkillName());
	        }
		});
		
		
		return teamSkills;
	}
	
	public ArrayList<Integer> retrieveTeamSkillsByLanguage(Team team){
		ArrayList<Integer> teamSkills = new ArrayList<Integer>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select DISTINCT sk.skill_id from students std, user_skills sk, skills s WHERE s.id=sk.skill_id AND sk.user_id = std.id AND std.team_id = " + team.getId() + " AND s.skill_type LIKE 'Language';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int skillId	= Integer.parseInt(array.get(0));
			
			teamSkills.add(skillId);
			
		}
		
		Collections.sort(teamSkills, new Comparator<Integer>() {
	        @Override public int compare(Integer i1, Integer i2) {
	        	SkillDataManager skdm = new SkillDataManager();
	        		Skill skill1 = null;
	        		Skill skill2 = null;
					try {
						skill1 = skdm.retrieve(i1);
						skill2 = skdm.retrieve(i2);
					} catch (Exception e) {}
	            	return skill1.getSkillName().compareTo(skill2.getSkillName());
	        }
		});
		
		return teamSkills;
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
	
	public ArrayList<String> retrieveTeamSkillName(Team team){
		ArrayList<String> teamSkills = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select DISTINCT sk.skill_id from students std, user_skills sk WHERE sk.user_id = std.id AND std.team_id = " + team.getId() + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		SkillDataManager skdm = new SkillDataManager();
		
		Skill skill = null;
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int skillId	= Integer.parseInt(array.get(0));
			
			try{
				skill = skdm.retrieve(skillId);
			}catch(Exception e){}
			
			teamSkills.add(skill.getSkillName());
			
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
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select industry_id from team_preferred_industry where team_id = " + team.getId() + ";");
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
	
	public boolean isTeamNameTaken(String teamName){
		boolean isTaken = false;
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams WHERE team_name LIKE '" + teamName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if (iterator.hasNext()){
			isTaken = true;
		}
		
		return isTaken;
	}
	
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
	
	public ArrayList<Team> retrievebyFaculty(int id) throws Exception{
		 ArrayList<Team> retrievedTeams = new ArrayList<Team>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id2 = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			Team team = new Team(id2, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
			retrievedTeams.add(team);
		}
		return retrievedTeams;
	}
	
	public Team retrieve(int id) throws Exception{
		Team retrievedTeam = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from teams where id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id2 = Integer.parseInt(array.get(0));
			String teamName = array.get(1);
			int teamLimit	= Integer.parseInt(array.get(2));
			int pmId		= Integer.parseInt(array.get(3));
			int supId 		= Integer.parseInt(array.get(4));
			int rev1 		= Integer.parseInt(array.get(5));
			int rev2 		= Integer.parseInt(array.get(6));
			int termId 		= Integer.parseInt(array.get(7));
			
			retrievedTeam = new Team(id2, teamName,teamLimit, pmId, supId, rev1, rev2, termId);
		}
		return retrievedTeam;
	}
	
	public void add(Team team, String[] prefIndustry, String[] prefTech){
		if(prefIndustry == null){
			prefIndustry = new String[0];
		}
		
		if(prefTech == null){
			prefTech = new String[0];
		}
		
		int teamId		=	team.getId();
		String teamName = 	team.getTeamName();
		int teamLimit	=	team.getTeamLimit();
		int pmId		=	team.getPmId();
		int supId		=	team.getSupId();
		int rev1		= 	team.getRev1Id();
		int rev2		= 	team.getRev2Id();
		int termId		= 	team.getTermId();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`teams` "
				+ "(`id`, `team_name`, `team_limit`, `pm_id`, `supervisor_id`, `reviewer1_id`, `reviewer2_id`, `term_id`) "
				+ "VALUES (" + teamId + ", '" + teamName + "', " + teamLimit + ", " + pmId + ", " + supId + ", " + rev1 + ", " + rev2 + ", " + termId + ");");
		
		for(int i = 0; i < prefIndustry.length; i++){
			try{
				if(Integer.parseInt(prefIndustry[i]) != 0){
					MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_industry` "
							+ "(`team_id`, `industry_id`) "
							+ "VALUES (" + teamId + ", " + Integer.parseInt(prefIndustry[i]) + ");");
				}
			}catch(Exception e){}
		}
		
		for(int i = 0; i < prefTech.length; i++){
			try{
				if(Integer.parseInt(prefTech[i]) != 0){
				MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_technology` "
						+ "(`team_id`, `technology_id`) "
						+ "VALUES (" + teamId + ", " + Integer.parseInt(prefTech[i]) + ");");
				}
			}catch(Exception e){}
		}
		
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_status` "
				+ "(`team_id`, `status_id`) "
				+ "VALUES (" + teamId + ", 1);");
		
	}
	
	public void deleteAppliedProjsIfTeamDeleted(int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM applied_projects WHERE team_id = " + teamId);
		//System.out.println("Updated Student table");
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
				+ "team_limit = " + team.getTeamLimit() + ", "
				+ "pm_id = " + team.getPmId() + ", "
				+ "supervisor_id = " + team.getSupId() + ", "
				+ "reviewer1_id = " + team.getRev1Id() + ", "
				+ "reviewer2_id = " + team.getRev2Id() + ", "
				+ "term_id = " + team.getTermId() + " "
				+ "WHERE id = " + team.getId());
	}
	
	
	public void modify(Team team, String[] industry, String[] technology){
		MySQLConnector.executeMySQL("update", "UPDATE teams SET "
				+ "team_name = '" + team.getTeamName() + "', "
				+ "team_limit = " + team.getTeamLimit() + ", "
				+ "pm_id = " + team.getPmId() + ", "
				+ "supervisor_id = " + team.getSupId() + ", "
				+ "reviewer1_id = " + team.getRev1Id() + ", "
				+ "reviewer2_id = " + team.getRev2Id() + ", "
				+ "term_id = " + team.getTermId() + " "
				+ "WHERE id = " + team.getId());
		
		MySQLConnector.executeMySQL("delete", "DELETE FROM team_preferred_technology WHERE team_id = " + team.getId());
		MySQLConnector.executeMySQL("delete", "DELETE FROM team_preferred_industry WHERE team_id = " + team.getId());
		
		for(int i = 0; i < industry.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_industry` "
					+ "(`team_id`, `industry_id`) "
					+ "VALUES (" + team.getId() + ", " + Integer.parseInt(industry[i]) + ");");
		}
		
		for(int i = 0; i < technology.length; i++){
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`team_preferred_technology` "
					+ "(`team_id`, `technology_id`) "
					+ "VALUES (" + team.getId() + ", " + Integer.parseInt(technology[i]) + ");");
		}
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
	
	public void studentRequest(int userId, int teamId){
		MySQLConnector.executeMySQL("insert", "INSERT INTO student_request (student_id, team_id) "
				+ "VALUES(" + userId + ", " + teamId + ")");
	}
	
	public void removeAllStudentRequest(int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM student_request WHERE team_id =  " + teamId);
	}
	
	public void removeStudentRequest(int userId, int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM student_request WHERE student_id = " + userId + " AND team_id =  " + teamId);
	}
	
	public void inviteTeam(int teamId, int sponsorId){
		MySQLConnector.executeMySQL("insert", "INSERT INTO invite_team (team_id, sponsor_id) "
				+ "VALUES(" + teamId + ", " + sponsorId + ")");
	}
	
	public void studentInvite(int userId, int teamId){
		MySQLConnector.executeMySQL("insert", "INSERT INTO team_request (student_id, team_id) "
				+ "VALUES(" + userId + ", " + teamId + ")");
	}
	
	public void removeAllTeamInvite(int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM team_request WHERE team_id =  " + teamId);
	}
	
	public void removeTeamInvite(int userId, int teamId){
		MySQLConnector.executeMySQL("delete", "DELETE FROM student_request WHERE student_id = " + userId + " AND team_id =  " + teamId);
	}
	
	
	public void removeMember(int userId){
		MySQLConnector.executeMySQL("update", "UPDATE students SET team_id = 0, role_id = 0 WHERE id = " + userId);
	}
	
	public void remove(int ID){
		MySQLConnector.executeMySQL("delete", "Delete FROM teams WHERE id = " + ID);
		MySQLConnector.executeMySQL("delete", "Delete FROM team_status WHERE team_id = " + ID);
	}
	
	public void removeAll() {
		
	}
}
