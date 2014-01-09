package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class StudentDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public StudentDataManager() {}
	
	//retrieve all second majors listed in database
	public ArrayList<String> retrieveAllMajors() {
		ArrayList<String> majors = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM second_major");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String major 	= array.get(1);
			
			majors.add(major);
		}
		
		return majors;
	}
	
	//retrieves student based on their role in the team
	public Student retrieveAllStudentByTeamRole(int teamId, int role) {

		Student student = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM students "
				+ "WHERE team_id = " + teamId + " AND role_id = " + role);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int stdId	 	= Integer.parseInt(array.get(2));
			
			try{
				student = retrieve(stdId);
			}catch(Exception e){}
		}
		
		return student;
	}
	
	//retrieves list of students that has been invited by a team to join them
	public ArrayList<Student> retrieveStudentsInvitedByTeam(int teamId) {
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM team_request WHERE team_id = " + teamId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int stdId	 	= Integer.parseInt(array.get(2));
			
			Student student = null;
			
			try{
				student = retrieve(stdId);
			}catch(Exception e){}
			
			students.add(student);
		}
		
		return students;
	}

	//retrieves list of students who have requested to join a particular team
	public ArrayList<Student> retrieveStudentRequests(int teamId) {
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM student_request WHERE team_id = " + teamId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int stdId	 	= Integer.parseInt(array.get(1));
			
			Student student = null;
			
			try{
				student = retrieve(stdId);
			}catch(Exception e){}
			
			students.add(student);
		}
		
		return students;
	}
	
	//checks if a second major entered is a valid one
	public boolean isValidMajor(String major){
		boolean isValid = false;
		ArrayList<String> allMajors = retrieveAllMajors();
		
		if((allMajors.contains(major))){
			isValid = true;
		}
		return isValid;
	}
	
	//retrieve students who ar eligible for FYP (year 3,4) TO REVIEW: SQL query is wrong
	public ArrayList<Student> retrieveAllCurrent() {
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id WHERE users.type LIKE 'Student';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		int currYear = cal.get(cal.YEAR);
		int currMth = cal.get(cal.MONTH);
		
		int year = 0;
		
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
			
			try{
				int matricYear = Integer.parseInt(username.substring(username.length() - 4, username.length()));
				
				year = currYear - matricYear;
				
				Student student = new Student(id, username, fullName, contactNum, email, type,  secondMajor, role, teamId, prefRole);
				
				if(currMth > 8){
					year++;
					
				}
				
				if(year == 3 || year == 4){
					students.add(student);
				}
				
			}catch(Exception e){}
		}
		
		return students;
	}
	
	public ArrayList<Student> retrieveAll() {
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id WHERE users.type LIKE 'Student';");
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
			students.add(student);
		}
		
		return students;
	}
	
	//checks if a particular user already has a team
	public boolean hasTeam(User std) {
		boolean hasTeam = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.students WHERE id = " + std.getID() + " ;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int teamId 	= Integer.parseInt(array.get(3));
			
			if(teamId != 0){
				hasTeam = true;
			}
		}
		
		return hasTeam;
	}
	
	//retrieves list of all students full names
	public ArrayList<String> retrieveFullNameList() throws Exception{
		ArrayList<String> nameList = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String username 	= array.get(2);
			
			nameList.add(username);
		}
		
		Collections.sort(nameList, new Comparator<String>() {
	        @Override public int compare(String s1, String s2) {
	            	return s1.compareTo(s2);
	        }
		});
		
		return nameList;
	}
	
	//retrieves list of all students user names
	public ArrayList<String> retrieveUsernameList() throws Exception{
		ArrayList<String> nameList = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String username 	= array.get(1);
			
			nameList.add(username);
		}
		
		Collections.sort(nameList, new Comparator<String>() {
	        @Override public int compare(String s1, String s2) {
	            	return s1.compareTo(s2);
	        }
		});
		
		return nameList;
	}
	
	public Student retrieve(int id) throws Exception{
		Student student = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id where users.id = '" + id + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId 	= Integer.parseInt(array.get(0));
			String username 	= array.get(1);
			String fullName 	= array.get(2);
			String contactNum 	= array.get(3);
			String email 		= array.get(4);
			String type			= array.get(5);
			String secondMajor 	= array.get(7);
			int role 			= Integer.parseInt(array.get(8));
			int teamId 			= Integer.parseInt(array.get(9));
			int prefRole 		= Integer.parseInt(array.get(10));
			
			student = new Student(retrievedId, username, fullName, contactNum, email, type, secondMajor, role, teamId, prefRole);
		}
		return student;
	}
	
	public Student retrieve(String username) throws Exception{
		Student student = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id where users.username = '" + username + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id 				= Integer.parseInt(array.get(0));
			String retrievedUsername 	= array.get(1);
			String fullName 	= array.get(2);
			String contactNum 	= array.get(3);
			String email 		= array.get(4);
			String type			= array.get(5);
			String secondMajor 	= array.get(7);
			int role 			= Integer.parseInt(array.get(8));
			int teamId 			= Integer.parseInt(array.get(9));
			int prefRole 		= Integer.parseInt(array.get(10));		
			
			student = new Student(id, retrievedUsername, fullName, contactNum, email, type, secondMajor, role, teamId, prefRole);
		}
		return student;
	}
	
	public void add(Student student){
		
		int id = student.getID();
		String username = student.getUsername();
		String fullName = student.getFullName();
		String contactNum = student.getContactNum();
		String email = student.getEmail();
		String type = student.getType();
		String secondMajor = student.getSecondMajor();
		int role = student.getRole();
		int teamId	= student.getTeamId();
		int preferredRole = student.getPreferredRole();
		
		MySQLConnector
		.executeMySQL(
				"insert",
				"INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES ("
						+ id + ", '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`students` (`id`, `second_major`, `role_id`, `team_id`, `preferred_role_id`) VALUES ('" + id + "', '" + secondMajor + "', " + role + ", " + teamId + ", " + preferredRole + ");");
		System.out.println("student added successfully");
	}
	
	//updates student table in case of reshuffle of team members
	public void updateStudent(int id,int teamId, String role){
		
		MySQLConnector.executeMySQL("update", "UPDATE `is480-matching`.`students` SET `team_id`=" + teamId + " WHERE `id`=" + id );
		MySQLConnector.executeMySQL("update", "UPDATE `is480-matching`.`students` SET `role_id`=" + Integer.parseInt(role) + " WHERE `id`=" + id);
		//fix this statement.
	}
	
	//retrieves all students in a particular team
	public ArrayList<Student> getTeamListFromTeamId(int teamId){
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id WHERE students.team_id = " + teamId);
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
			int teamid 			= Integer.parseInt(array.get(9));
			int prefRole 		= Integer.parseInt(array.get(10));
			
			Student student = new Student(id, username, fullName, contactNum, email, type,  secondMajor, role, teamid, prefRole);
			students.add(student);
		}
		
		Collections.sort(students, new Comparator<Student>() {
	        @Override public int compare(Student s1, Student s2) {
	            	return s1.getRole() - s2.getRole();
	        }
		});
		
		
		return students;
	}
	
	//modifies a user based on changes made to their student profile
	public void modify(User user, Student student, String[] skills){
		MySQLConnector.executeMySQL("update", "UPDATE users SET "
				+ "contact_num = '" + user.getContactNum() + "',"
				+ "email = '" + user.getEmail() + "'"
				+ "WHERE id = " + user.getID());
		
		MySQLConnector.executeMySQL("update", "UPDATE students SET "
				+ "second_major = '" + student.getSecondMajor() + "' "
				+ "WHERE id = " + user.getID());
		
		//CLEAR ALL USER_SKILL DATA IN DB
		MySQLConnector.executeMySQL("delete", "DELETE FROM user_skills WHERE user_id = " + user.getID());
		
		UserDataManager udm = new UserDataManager();
		udm.addSkills(skills, user.getID());
		
	}
	
	public void modify(Student student){
		MySQLConnector.executeMySQL("update", "UPDATE students SET "
				+ "second_major = '" + student.getSecondMajor() + "', "
				+ "team_id = " + student.getTeamId() + ", "
				+ "role_id = " + student.getRole() + " "
				+ "WHERE id = " + student.getID());
	
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}

