package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class RoleDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public RoleDataManager() {
	}
	
	public ArrayList<String> retrieveUserRole(String username, String type) {
		ArrayList<String> types = new ArrayList<String>();
		UserDataManager udm = new UserDataManager();
		User u = null;
		
		try{
			u = udm.retrieve(username);
		}catch(Exception e){}
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT type FROM users WHERE username LIKE '" + username + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			String roleName = array.get(0);
			
			types.add(roleName);
		}
		
		
		map = MySQLConnector.executeMySQL("select","SELECT additional_type FROM additional_role WHERE user_id = " + u.getID());
		keySet = map.keySet();
		iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			String roleName = array.get(0);
			
			types.add(roleName);
		}
		
		return types;
	}
	
	public ArrayList<Role> retrieveAll() {
		ArrayList<Role> roles = new ArrayList<Role>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.role ");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String roleName = array.get(1);
			
			Role role = new Role(id, roleName);
			roles.add(role);
		}
		
		return roles;
	}
	
	
	public Role retrieve(int id) throws Exception {
		Role role = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(	"select","SELECT * FROM `is480-matching`.role where role.role_id = "+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id2 = Integer.parseInt(array.get(0));
			String roleName = array.get(1);
			
			role = new Role(id2, roleName);
			
		}
		return role;
	}

	public void add(User u, String role) {
		int id = u.getID();
		
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`additional_role` (user_id, additional_type) "
				+ " VALUES (" + id + ", '" + role + "');");
	}

	public void modify(Role role) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}