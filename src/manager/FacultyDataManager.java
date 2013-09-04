package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class FacultyDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public FacultyDataManager() {
	}

	public ArrayList<Faculty> retrieveAll() {
		ArrayList<Faculty> faculties = new ArrayList<Faculty>();
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.users inner join `is480-matching`.faculties on users.id=faculties.id;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			String facultyType = array.get(7);
			Faculty faculty = new Faculty(id, username, fullName, contactNum,
					email, type, facultyType);
			faculties.add(faculty);
		}
		return faculties;
	}

	public Faculty retrieve(int id) throws Exception {
		Faculty faculty = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.users inner join `is480-matching`.faculties on users.id=faculties.id where users.id = '"
								+ id + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int retrievedId = Integer.parseInt(array.get(0));
			String username = array.get(1);
			String fullName = array.get(2);
			String contactNum = array.get(3);
			String email = array.get(4);
			String type = array.get(5);
			String facultyType = array.get(7);
			faculty = new Faculty(id, username, fullName, contactNum, email,
					type, facultyType);
		}
		return faculty;
	}

	public void add(Faculty faculty) {
		int id = faculty.getID();
		String username = faculty.getUsername();
		String fullName = faculty.getFullName();
		String contactNum = faculty.getContactNum();
		String email = faculty.getEmail();
		String type = faculty.getType();
		String facultyType = faculty.getFacultyType();
		MySQLConnector
				.executeMySQL(
						"insert",
						"INSERT INTO `is480-matching`.`users` (`id`, `username`, `full_name`, `contact_number`, `email`, `type`) VALUES ("
								+ id + ", '" + username + "', '" + fullName + "', '" + contactNum + "', '" + email + "', '" + type + "');");
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`faculties` (`id`, `faculty_Type`) VALUES ("
						+ id + ", '" + facultyType + "');");
		System.out.println("Faculty added successfully");
	}

	public void modify(Faculty faculty) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}