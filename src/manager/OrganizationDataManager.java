package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class OrganizationDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public OrganizationDataManager() {
	}

	public ArrayList<Organization> retrieveAll() {
		ArrayList<Organization> orgs = new ArrayList<Organization>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select", "SELECT * FROM `is480-matching`.organization_type");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String orgType = array.get(1);
			
			Organization org = new Organization(id, orgType);
			orgs.add(org);
		}
		
		Collections.sort(orgs, new Comparator<Organization>() {
	        @Override public int compare(Organization o1, Organization o2) {
	            	return o1.getId() - o2.getId();
	        }
		});
		
		return orgs;
	}
	
	public boolean hasOrg(ArrayList<String> orgs, Organization orgCheck){
		boolean hasOrg = false;
			for(int i = 0; i < orgs.size(); i++){
				if(orgCheck.getId() == Integer.parseInt(orgs.get(i))){
					hasOrg = true;
				}
			}
		return hasOrg;
	}

	
	public Organization retrieve(int id) throws Exception {
		Organization org = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.organization_type where organization_type.id = "	+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int orgid = Integer.parseInt(array.get(0));
			String orgType = array.get(1);
			
			org = new Organization(orgid, orgType);
		}
		return org;
	}

	public Organization retrieve(String orgName) {
		Organization org = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.organization_type where organization_type.organization_type LIKE '"	+ orgName + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int orgid = Integer.parseInt(array.get(0));
			String orgType = array.get(1);
			
			org = new Organization(orgid, orgType);
		}
		return org;
	}
	
	public void add(Organization org) {
		int id = org.getId();
		String orgName = org.getOrgType();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`organization_type` VALUES ("	+ id + ", '" + orgName  + "');");
	}

	public void add(String orgName) {
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`organization_type` (organization_type)"
				+ " VALUES ('" + orgName  + "');");
	}

	public void modify(Organization org) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}