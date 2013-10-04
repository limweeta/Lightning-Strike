package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class TermDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public TermDataManager() {
	}

	public ArrayList<Term> retrieveAll() {
		ArrayList<Term> terms = new ArrayList<Term>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.term ORDER BY id ASC");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String acadYear = array.get(1);
			int sem = Integer.parseInt(array.get(2));
			
			Term term = new Term(id, acadYear, sem);
			terms.add(term);
		}
		Collections.sort(terms, new Comparator<Term>() {
	        @Override public int compare(Term t1, Term t2) {
	            	return t1.getId() - t2.getId();
	        }
		});
		
		return terms;
	}
	
	
	public Term retrieve(int id) throws Exception {
		Term term = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(	"select","SELECT * FROM `is480-matching`.term where term.id = "+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id2 = Integer.parseInt(array.get(0));
			String acadYear = array.get(1);
			int sem = Integer.parseInt(array.get(2));
			
			term = new Term(id2, acadYear, sem);
		}
		return term;
	}

	public void add(Term term) {
		int id = term.getId();
		String acadYear = term.getAcadYear();
		int sem = term.getSem();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`announcement` (academic_year, semester)"
				+ " VALUES ('" + acadYear + "', " + sem + ");");
	}

	public void modify(Company company) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}