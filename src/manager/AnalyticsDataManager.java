package manager;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

import model.*;

public class AnalyticsDataManager {
private static final long serialVersionUID = 1L;
	
	public AnalyticsDataManager() {}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projectBySkills(){
		
		TreeMap<Integer, ArrayList<Integer>> skillMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(intended_term_id) FROM projects");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select ps.id, ps.project_id, p.intended_term_id, ps.skill_id "
							+ "from projects p, project_preferred_skills ps "
							+ "WHERE p.id = ps.project_id AND p.intended_term_id = " + termidval + " "
							+ "ORDER BY p.intended_term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			skillMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			//Array: project_id, intended_term_id, skill_id
			ArrayList<Integer> rawProjList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int projectId = Integer.parseInt(array.get(1));
				int termId = Integer.parseInt(array.get(2));
				int skillId = Integer.parseInt(array.get(3));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawProjList = skillMap.get(skillId);
					skillMap = termMap.get(fullTerm);
					
					if(rawProjList == null){
						rawProjList = new ArrayList<Integer>();
					}
					
					rawProjList.add(projectId);
					count++;
					if(skillMap == null){
						skillMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					skillMap.put(skillId, new ArrayList<Integer>(rawProjList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(skillMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projectByTech(){
		
		TreeMap<Integer, ArrayList<Integer>> techMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(intended_term_id) FROM projects");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select ps.id, ps.project_id, p.intended_term_id, ps.skill_id "
							+ "from projects p, project_preferred_skills ps "
							+ "WHERE p.id = ps.project_id AND p.intended_term_id = " + termidval + " "
							+ "ORDER BY p.intended_term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			techMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			//Array: project_id, intended_term_id, skill_id
			ArrayList<Integer> rawProjList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int projectId = Integer.parseInt(array.get(1));
				int termId = Integer.parseInt(array.get(2));
				int techId = Integer.parseInt(array.get(3));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawProjList = techMap.get(techId);
					techMap = termMap.get(fullTerm);
					
					if(rawProjList == null){
						rawProjList = new ArrayList<Integer>();
					}
					
					rawProjList.add(projectId);
					count++;
					if(techMap == null){
						techMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					techMap.put(techId, new ArrayList<Integer>(rawProjList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(techMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projectByInd(){
		
		TreeMap<Integer, ArrayList<Integer>> indMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(intended_term_id) FROM projects");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select id, intended_term_id, industry_id "
							+ "from projects "
							+ "WHERE intended_term_id = " + termidval + " "
							+ "ORDER BY intended_term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			ArrayList<Integer> rawProjList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			indMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int projectId = Integer.parseInt(array.get(0));
				int termId = Integer.parseInt(array.get(1));
				int indId = Integer.parseInt(array.get(2));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawProjList = indMap.get(indId);
					indMap = termMap.get(fullTerm);
					
					if(rawProjList == null){
						rawProjList = new ArrayList<Integer>();
					}
					
					rawProjList.add(projectId);
					count++;
					if(indMap == null){
						indMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					indMap.put(indId, new ArrayList<Integer>(rawProjList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(indMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamByInd(){
		
		TreeMap<Integer, ArrayList<Integer>> indMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(term_id) FROM teams");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select ti.id, t.id, t.term_id, ti.industry_id "
							+ "from teams t, team_preferred_industry ti "
							+ "WHERE t.id = ti.team_id AND t.term_id = " + termidval + " "
							+ "ORDER BY t.term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			indMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			//Array: project_id, intended_term_id, skill_id
			ArrayList<Integer> rawTeamList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int teamId = Integer.parseInt(array.get(1));
				int termId = Integer.parseInt(array.get(2));
				int indId = Integer.parseInt(array.get(3));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawTeamList = indMap.get(indId);
					indMap = termMap.get(fullTerm);
					
					if(rawTeamList == null){
						rawTeamList = new ArrayList<Integer>();
					}
					
					rawTeamList.add(teamId);
					count++;
					if(indMap == null){
						indMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					indMap.put(indId, new ArrayList<Integer>(rawTeamList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(indMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamByTech(){
		
		TreeMap<Integer, ArrayList<Integer>> techMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(term_id) FROM teams");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select tt.id, t.id, t.term_id, tt.technology_id "
							+ "from teams t, team_preferred_technology tt "
							+ "WHERE t.id = tt.team_id AND t.term_id = " + termidval + " "
							+ "ORDER BY t.term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			techMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			//Array: project_id, intended_term_id, skill_id
			ArrayList<Integer> rawTeamList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int teamId = Integer.parseInt(array.get(1));
				int termId = Integer.parseInt(array.get(2));
				int techId = Integer.parseInt(array.get(3));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawTeamList = techMap.get(techId);
					techMap = termMap.get(fullTerm);
					
					if(rawTeamList == null){
						rawTeamList = new ArrayList<Integer>();
					}
					
					rawTeamList.add(teamId);
					count++;
					if(techMap == null){
						techMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					techMap.put(techId, new ArrayList<Integer>(rawTeamList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(techMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
	
	public TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> studentBySkill(){
		
		TreeMap<Integer, ArrayList<Integer>> skillMap = new TreeMap<Integer, ArrayList<Integer>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> finalTermMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		
		HashMap<String, ArrayList<String>> termidmap = 
				MySQLConnector.executeMySQL("select", 
						"select DISTINCT(term_id) FROM teams");
		
		Set<String> termidkeySet = termidmap.keySet();
		Iterator<String> termiditerator = termidkeySet.iterator();
		
		while(termiditerator.hasNext()){
			String termidkey = termiditerator.next();
			ArrayList<String> termidarray = termidmap.get(termidkey);	
			int termidval = Integer.parseInt(termidarray.get(0));
			
			HashMap<String, ArrayList<String>> map = 
					MySQLConnector.executeMySQL("select", 
							"select u.id, s.id, t.term_id, u.skill_id "
							+ "from teams t, students s, user_skills u "
							+ "WHERE u.user_id = s.id AND s.team_id = t.id AND t.term_id = " + termidval + " "
							+ "ORDER BY t.term_id ASC");
			
			Set<String> keySet = map.keySet();
			Iterator<String> iterator = keySet.iterator();
			
			skillMap = new TreeMap<Integer, ArrayList<Integer>>();
			termMap = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
			
			//Array: project_id, intended_term_id, skill_id
			ArrayList<Integer> rawStudentList = new ArrayList<Integer>();
			
			TermDataManager termdm = new TermDataManager();
		
			int count  = 0;
			while (iterator.hasNext()){
				String key = iterator.next();
				ArrayList<String> array = map.get(key);	
				int studentId = Integer.parseInt(array.get(1));
				int termId = Integer.parseInt(array.get(2));
				int skillId = Integer.parseInt(array.get(3));
				
				Term term = null;
				
				try{
					term = termdm.retrieve(termId);
					
					String fullTerm = term.getAcadYear() + " T" + term.getSem();
					
					rawStudentList = skillMap.get(skillId);
					skillMap = termMap.get(fullTerm);
					
					if(rawStudentList == null){
						rawStudentList = new ArrayList<Integer>();
					}
					
					rawStudentList.add(studentId);
					count++;
					if(skillMap == null){
						skillMap = new TreeMap<Integer, ArrayList<Integer>>();
					}
					
					skillMap.put(skillId, new ArrayList<Integer>(rawStudentList));
					
					termMap.put(fullTerm, new TreeMap<Integer, ArrayList<Integer>>(skillMap));
				}catch(Exception e){}
				
			}

			finalTermMap.putAll(termMap);
		}
		return finalTermMap;
	}
}
