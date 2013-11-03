package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class SecondMajorDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public SecondMajorDataManager() {
	}

	public ArrayList<SecondMajor> retrieveAll() {
		ArrayList<SecondMajor> secondMajors = new ArrayList<SecondMajor>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.second_major ORDER BY id ASC");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String secMaj = array.get(1);
			
			SecondMajor secondMajor = new SecondMajor(id, secMaj);
			secondMajors.add(secondMajor);
		}
		Collections.sort(secondMajors, new Comparator<SecondMajor>() {
	        @Override public int compare(SecondMajor s1, SecondMajor s2) {
	            	return s1.getSecondMajor().compareTo(s2.getSecondMajor());
	        }
		});
		
		return secondMajors;
	}
	
	
	public SecondMajor retrieve(int id) throws Exception {
		SecondMajor secondMajor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(	"select","SELECT * FROM `is480-matching`.second_major where second_major.id = "+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id2 = Integer.parseInt(array.get(0));
			String secMaj = array.get(1);
			
			secondMajor = new SecondMajor(id2, secMaj);
		}
		return secondMajor;
	}

	public void add(SecondMajor secondMajor) {
		int id = secondMajor.getId();
		String secMaj = secondMajor.getSecondMajor();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`second_major` (second_major)"
				+ " VALUES ('" + secMaj + ");");
	}

	public void remove(int ID) {
	}


}