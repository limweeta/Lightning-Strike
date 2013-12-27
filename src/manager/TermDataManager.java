package manager;

import java.io.Serializable;
import java.util.*;
import java.text.*;
import model.*;

public class TermDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public TermDataManager() {
	}
	
	public int retrieveCurrTerm(String date) throws Exception {
		int termid = 0;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(	"select","SELECT * FROM term where start_date >= '"+ date + "' AND end_date <= '" + date + "'");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			termid = Integer.parseInt(array.get(0));
		}
		return termid;
	}
	
	public boolean isTermNameTaken(String acadYear, String sem) throws Exception {
		boolean nameTaken = false;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(	"select","SELECT * FROM term where academic_year LIKE '"+ acadYear + "' AND semester = " + sem);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		if (iterator.hasNext()) {
			nameTaken = true;
		}
		return nameTaken;
	}
	
	public ArrayList<Term> retrieveAllFutureTerms() {
		ArrayList<Term> terms = new ArrayList<Term>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		
		String currDate = sdf.format(new Date());
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.term where start_date > '" + currDate + "' ORDER BY id ASC");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String acadYear = array.get(1);
			String sem = array.get(2);
			String startDate = array.get(3);
			String endDate = array.get(4);
			
			Term term = new Term(id, acadYear, sem, startDate, endDate);
			terms.add(term);
		}
		Collections.sort(terms, new Comparator<Term>() {
	        @Override public int compare(Term t1, Term t2) {
	            	return t1.getId() - t2.getId();
	        }
		});
		
		return terms;
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
			String sem = array.get(2);
			String startDate = array.get(3);
			String endDate = array.get(4);
			
			Term term = new Term(id, acadYear, sem, startDate, endDate);
			terms.add(term);
		}
		Collections.sort(terms, new Comparator<Term>() {
	        @Override public int compare(Term t1, Term t2) {
	            	return t1.getId() - t2.getId();
	        }
		});
		
		return terms;
	}
	
	public ArrayList<Term> retrieveFromNextSem() {
		ArrayList<Term> terms = new ArrayList<Term>();
		
		Calendar now = Calendar.getInstance();
		int currYear = now.get(Calendar.YEAR);
		int currMth = now.get(Calendar.MONTH);
		int currTermId = 0;
		
		try{
			currTermId = retrieveTermId(currYear, currMth);
		}catch(Exception e){
			currTermId = 0;
		}
		
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.term WHERE id > " + currTermId);
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String acadYear = array.get(1);
			String sem = array.get(2);
			
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
	
	public int retrieveTermId(int year, int month) throws Exception {
		int termId = 0;
		String acadYear = "";
		String sem = "";
		
		if((month+1) <= 5){
			acadYear = Integer.toString(year - 1) + "/" + Integer.toString(year);
			sem = "2";
		}else if((month+1) >= 8){
			acadYear = Integer.toString(year) + "/" + Integer.toString(year + 1);
			sem = "1";
		}else{
			acadYear = Integer.toString(year) + "/" + Integer.toString(year + 1);
			sem = "1";
		}
		
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL("select","SELECT * FROM term WHERE academic_year LIKE '"+ acadYear + "' AND semester = " + sem + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int retrievedTermId = Integer.parseInt(array.get(0));
			
			termId = retrievedTermId;
		}
		return termId;
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
			String sem = array.get(2);
			
			term = new Term(id2, acadYear, sem);
		}
		return term;
	}

	public void add(Term term) {
		String acadYear = term.getAcadYear();
		String sem = term.getSem();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`term` (academic_year, semester, start_date, end_date)"
				+ " VALUES ('" + acadYear + "', " + sem + ", '" + term.getStartDate() + " 00:00:00', '" + term.getEndDate() + " 23:59:59');");
	}

	public void modify(Company company) {
	}

	public void remove(int termid) {
		MySQLConnector.executeMySQL("delete",
				"DELETE FROM term WHERE id = " + termid);
	}

	public void removeAll() {
	}
}