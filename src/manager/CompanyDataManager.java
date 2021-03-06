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
			String contactNum = array.get(3);
			int orgType = Integer.parseInt(array.get(4));
			
			Company company = new Company(id, coyName, coyAdd, contactNum, orgType);
			companies.add(company);
		}
		return companies;
	}

	public Company retrieve(int id) throws Exception {
		Company company = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select","SELECT * FROM `is480-matching`.companies where companies.id = " + id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int coyid = Integer.parseInt(array.get(0));
			String coyName = array.get(1);
			String coyAdd = array.get(2);
			String contactNum = array.get(3);
			int orgType = Integer.parseInt(array.get(4));
			
			company = new Company(coyid, coyName, coyAdd, contactNum, orgType);
		}
		return company;
	}

	public void add(Company company) {
		int id = company.getID();
		String coyName = company.getCoyName();
		String coyAdd = company.getCoyAdd();
		String contactNum = company.getCoyContactNum();
		int orgType = company.getOrgType();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`companies` VALUES ("
						+ id + ", '" + coyName + "', '" + coyAdd + "', '" + contactNum + "', " + orgType + ");");
	}

	public void modify(Company company) {
		MySQLConnector.executeMySQL("update",
				"UPDATE companies "
				+ "SET company_name = '" + company.getCoyName() + "', "
				+ "company_address = '" + company.getCoyAdd() + "', "
				+ "company_contact_num = " + company.getCoyContactNum() + ", "
				+ "organization_type = " + company.getOrgType() + " "
				+ " WHERE id = " + company.getID()); 
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}