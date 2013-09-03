package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class SponsorDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public SponsorDataManager() {}
	
	public ArrayList<Sponsor> retrieveAll() {
		ArrayList<Sponsor> sponsors = new ArrayList<Sponsor>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.sponsors on users.id=sponsors.id;");
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
			String coyName = array.get(7);
			String password = array.get(8);
			
			Sponsor sponsor = new Sponsor(id, username, fullName, contactNum, email, type, coyName, password);
			sponsors.add(sponsor);
		}
		
		return sponsors;
	}
	
	public Sponsor retrieve(int id) throws Exception{
		Sponsor sponsor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.sponsors on users.id=sponsors.id where users.id= '" + id + "';");
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
			String coyName = array.get(7);
			String password = array.get(8);
			
		sponsor = new Sponsor(retrievedId, username, fullName, contactNum, email, type, coyName, password);
		}
		return sponsor;
	}
	
	public Sponsor retrieve(String username) throws Exception{
		Sponsor sponsor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.sponsors on users.id=sponsors.id where users.username= '" + username + "';");
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
			String coyName = array.get(7);
			String password = array.get(8);
			
		sponsor = new Sponsor(id, retrievedUsername, fullName, contactNum, email, type, coyName, password);
		}
		return sponsor;
	}
	
	public void add(Sponsor sponsor){
		
		int id = sponsor.getID();
		String username = sponsor.getUsername();
		String fullName = sponsor.getFullName();
		String contactNum = sponsor.getContactNum();
		String email = sponsor.getEmail();
		String type = sponsor.getType();
		String coyName = sponsor.getCoyName();
		String password = sponsor.getPassword();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES ('" + id + "', '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`sponsors` (`id`, `company_name`, `password`) VALUES ('" + id + "', '" + coyName + "', '" + password + "');");
		
		System.out.println("sponsor added successfully");
	}
		
	public void modify(Sponsor sponsor){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
