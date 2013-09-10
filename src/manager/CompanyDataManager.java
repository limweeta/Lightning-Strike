package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class CompanyDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public CompanyDataManager() {
	}

	public ArrayList<Company> retrieveAll() {
		ArrayList<Company> companies = new ArrayList<Company>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.users inner join `is480-matching`.companies on users.id=companies.id;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String coyName = array.get(1);
			String coyAdd = array.get(2);
			int contactNum = Integer.parseInt(array.get(3));
			
			Company company = new Company(id, coyName, coyAdd, contactNum);
			companies.add(company);
		}
		return companies;
	}

	public Company retrieve(int id) throws Exception {
		Company company = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.users inner join `is480-matching`.companies on users.id=companies.id where users.id = '"
								+ id + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int coyid = Integer.parseInt(array.get(0));
			String coyName = array.get(1);
			String coyAdd = array.get(2);
			int contactNum = Integer.parseInt(array.get(3));
			
			company = new Company(coyid, coyName, coyAdd, contactNum);
		}
		return company;
	}

	public void add(Company company) {
		int id = company.getID();
		String coyName = company.getCoyName();
		String coyAdd = company.getCoyAdd();
		int contactNum = company.getCoyContactNum();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`companies` VALUES ("
						+ id + ", '" + coyName + "', '" + coyAdd + "', " + contactNum + ");");
	}

	public void modify(Company company) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}