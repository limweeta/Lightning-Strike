package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class UserDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public UserDataManager() { }
	
	public ArrayList<User> retrieveAllFaculty() {
		ArrayList<User> Users = new ArrayList<User>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users"
				+ " WHERE type LIKE 'Supervisor' OR type LIKE 'Admin'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
			User User = new User(id, username, fullName, contactNum, email, type);
			Users.add(User);
		}
		
		Collections.sort(Users, new Comparator<User>() {
	        @Override public int compare(User u1, User u2) {
	            	return u1.getFullName().compareTo(u2.getFullName());
	        }
		});
		
		return Users;
	}
	
	public ArrayList<User> retrieveAll() {
		ArrayList<User> Users = new ArrayList<User>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
			User User = new User(id, username, fullName, contactNum, email, type);
			Users.add(User);
		}
		
		return Users;
	}
	
	public ArrayList<User> retrieveSuspendedUsers() {
		ArrayList<User> users = new ArrayList<User>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM suspended_list");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String username = array.get(1);
			
			User u = null;
			
			try{
				u = retrieve(username);
			}catch(Exception e){
				u = null;
			}
			
			users.add(u);
		}
		
		return users;
	}
	
	public boolean hasSkill(User u, int skillId) {
		boolean hasSkill = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM user_skills WHERE user_id = " + u.getID() + " AND skill_id = " + skillId +";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
	
		if(iterator.hasNext()){
			hasSkill = true;
		}
		
		return hasSkill;
	}
	
	public ArrayList<String> retrieveFacultyFullname() throws Exception{
		ArrayList<String> facultyNameList = new ArrayList<String>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users where users.type LIKE 'Faculty' OR users.type LIKE 'admin';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String fullName = array.get(2);
			
			facultyNameList.add(fullName);
		}
		return facultyNameList;
	}
	
	public User retrieve(int id) throws Exception{
		User User = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users where users.id= " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int retrievedId = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
		User = new User(retrievedId, username, fullName, contactNum, email, type);
		}
		return User;
	}
	
	public User retrieve(String username) throws Exception{
		User User = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users where users.username LIKE '" + username + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String retrievedUsername = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
		User = new User(id, retrievedUsername, fullName, contactNum, email, type);
		}
		return User;
	}
	
	public User retrieveByFullName(String fullName) throws Exception{
		User User = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users where users.full_name LIKE '" + fullName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			String retrievedUsername = array.get(1);
			String full_Name = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			
		User = new User(id, retrievedUsername, full_Name, contactNum, email, type);
		}
		return User;
	}
	
	public void add(User User){
		
		int id = User.getID();
		String username = User.getUsername();
		String fullName = User.getFullName();
		String contactNum = User.getContactNum();
		String email = User.getEmail();
		String type = User.getType();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES ('" + id + "', '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		
		
	}
	
	public boolean isSuspended(String username){
		boolean isSuspended = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.suspended_list WHERE username LIKE '" + username + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if(iterator.hasNext()){
			isSuspended = true;
		}
		return isSuspended;
	}
	
	public String getDateSuspended(String username){
		String dateSuspended = "";
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT date FROM `is480-matching`.suspended_list WHERE username LIKE '" + username + "' ORDER BY date DESC");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if(iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			
			dateSuspended = array.get(0);
		}
		return dateSuspended;
	}
	
	public String getReason(String username){
		String reason = "";
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT reason FROM `is480-matching`.suspended_list WHERE username LIKE '" + username + "' ORDER BY date DESC");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if(iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			
			reason = array.get(0);
		}
		return reason;
	}
	
	public void suspend(User User, String reason){
		
		String username = User.getUsername();
		
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`suspended_list` (`username`, `reason`, `date`) VALUES ('" + username + "', '" + reason + "', CURRENT_TIMESTAMP);");
		
		
	}
	
	public void unsuspend(User User){
		
		String username = User.getUsername();
		
		MySQLConnector.executeMySQL("delete", "DELETE FROM suspended_list WHERE username LIKE '" + username + "';");
		
		
	}
	
	
	public boolean isSponsor(String username){
		boolean isSponsor = false;
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM users WHERE type LIKE 'Sponsor' AND username LIKE '" + username + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if(iterator.hasNext()){
			isSponsor = true;
		}
		
		return isSponsor;
	}
	
	public boolean isTaken(String username){
		boolean isTaken = false;
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM users WHERE username LIKE '" + username + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		if(iterator.hasNext()){
			isTaken = true;
		}
		
		return isTaken;
	}
	
	public void addSkills(String[] skills, int userId){
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.`user_skills`");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		int max = 0;
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			int id = Integer.parseInt(array.get(0));
			if(id > max){
				max = id;
			}
		}
		for(int i=0; i < skills.length; i++){
			max++;
			MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`user_skills` VALUES (" + max + ", " + userId + ", " + Integer.parseInt(skills[i])  + ");");
		}
	}
	
	
	public void modify(User user){
		MySQLConnector.executeMySQL("update", "UPDATE users SET "
				+ "username = '" + user.getUsername() +"', "
				+ "full_name = '" + user.getFullName() + "', "
				+ "contact_num = " + user.getContactNum() + ", "
				+ "email = '" + user.getEmail() + "' "
				+ "WHERE id = " + user.getID());
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}

