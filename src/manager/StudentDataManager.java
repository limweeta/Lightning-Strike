package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class StudentDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public StudentDataManager() {}
	
	public ArrayList<Student> retrieveAll() {
		ArrayList<Student> students = new ArrayList<Student>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.students on users.id=students.id;");
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
			String role 		= array.get(8);
			int teamId 			= Integer.parseInt(array.get(9));
			
			Student student = new Student(id, username, fullName, contactNum, email, type,  secondMajor, role, teamId);
			students.add(student);
		}
		
		return students;
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
			String role 		= array.get(8);
			int teamId 			= Integer.parseInt(array.get(9));
			
			student = new Student(retrievedId, username, fullName, contactNum, email, type, secondMajor, role, teamId);
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
			String role 		= array.get(8);
			int teamId 			= Integer.parseInt(array.get(9));
			
			student = new Student(id, retrievedUsername, fullName, contactNum, email, type, secondMajor, role, teamId);
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
		String role = student.getRole();
		int teamId	= student.getTeamId();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES (" + id + ", '" + username + "', '" + fullName + "', " + contactNum + ", '" + email + "', '" + type + "');");
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`students` (`id`, `second_major`, `role`, `team_id`) VALUES ('" + id + "', '" + secondMajor + "', '" + role + "', '" + teamId + "');");
		System.out.println("student added successfully");
	}
		
	public void updateStudent(int id,int teamId, String role){
		
		MySQLConnector.executeMySQL("update", "UPDATE `is480-matching`.`students` SET `team_id`=" + teamId + " WHERE `id`=" + id );
		MySQLConnector.executeMySQL("update", "UPDATE `is480-matching`.`students` SET `role`='" + role + "' WHERE `id`=" + id);
		//fix this statement.
	}
	
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
			String role 		= array.get(8);
			int teamid 			= Integer.parseInt(array.get(9));
			
			Student student = new Student(id, username, fullName, contactNum, email, type,  secondMajor, role, teamid);
			students.add(student);
		}
		
		return students;
	}
	
	public void modify(Student student){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}

