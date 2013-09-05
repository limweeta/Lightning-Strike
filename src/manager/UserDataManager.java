package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class UserDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public UserDataManager() {}
	
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
	
	public void add(User User){
		
		int id = User.getID();
		String username = User.getUsername();
		String fullName = User.getFullName();
		String contactNum = User.getContactNum();
		String email = User.getEmail();
		String type = User.getType();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES ('" + id + "', '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		
		System.out.println("User added successfully");
	}
		
	public void modify(User User){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}

