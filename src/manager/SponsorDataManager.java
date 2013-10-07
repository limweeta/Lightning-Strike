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
			int coyId = Integer.parseInt(array.get(7));
			String password = array.get(8);
			int userid = Integer.parseInt(array.get(9));
			
			Sponsor sponsor = new Sponsor(id, username, fullName, contactNum, email, type, coyId, password, userid);
			sponsors.add(sponsor);
		}
		
		return sponsors;
	}
	
	public Sponsor retrieve(int id) throws Exception{
		Sponsor sponsor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.sponsors on users.id=sponsors.user_id where sponsors.user_id= " + id + ";");
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
			int coyId = Integer.parseInt(array.get(7));
			String password = array.get(8);
			int userid = Integer.parseInt(array.get(9));
			
		sponsor = new Sponsor(retrievedId, username, fullName, contactNum, email, type, coyId, password, userid);
		}
		return sponsor;
	}
	
	public Sponsor retrieve(String username) throws Exception{
		Sponsor sponsor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "SELECT * FROM `is480-matching`.users inner join `is480-matching`.sponsors on users.id=sponsors.user_id where users.username= '" + username + "';");
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
			int coyId = Integer.parseInt(array.get(7));
			String password = array.get(8);
			int userid = Integer.parseInt(array.get(9));

			
		sponsor = new Sponsor(id, retrievedUsername, fullName, contactNum, email, type, coyId, password, userid);
		}
		return sponsor;
	}
	
	public void add(Sponsor sponsor){
		
		int userid = sponsor.getUserid();
		int id = sponsor.getID();
		
		String username = sponsor.getUsername();
		String fullName = sponsor.getFullName();
		String contactNum = sponsor.getContactNum();
		String email = sponsor.getEmail();
		String type = sponsor.getType();
		int coyId = sponsor.getCoyId();
		String password = sponsor.getPassword();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_num`, `email`, `type`) VALUES (" + userid + ", '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`sponsors` (`id`, `company_id`, `password`, `user_id`) VALUES (" + id + ", " + coyId + ", '" + password + "', " + userid + ");");
		
		System.out.println("sponsor added successfully");
	}
		
	
	public Sponsor getSponsorFromList(ArrayList<Sponsor> array, int sponsorId){
		
		Sponsor sponsor = null;
		
		for(int i = 0; i < array.size(); i++){
			Sponsor tmpSponsor = array.get(i);
			if(tmpSponsor.getID() == sponsorId){
				sponsor = tmpSponsor;
				break;
			}
		}
		
		return sponsor;
		
	}
	
	public void modify(Sponsor sponsor){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
