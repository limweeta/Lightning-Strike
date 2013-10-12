package servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class CreateTeamServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processCreateTeamRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processCreateTeamRequest(request, response);
	}
	
	public void processCreateTeamRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		
		StudentDataManager sdm = new StudentDataManager();
		
		UserDataManager udm = new UserDataManager();
		
		TeamDataManager tdm = new TeamDataManager();
		ArrayList<Team> teams = tdm.retrieveAll();
		int teamid = 0;
		
		int largestId = 0;
		for(int j = 0; j < teams.size(); j++){
			if(teams.get(j).getId() > largestId){
				largestId = teams.get(j).getId();
			}
		}
		teamid = largestId + 1;
		
		String teamName = request.getParameter("teamname");
		String teamDesc = request.getParameter("teamdesc");
		int teamLimit = Integer.parseInt(request.getParameter("teamlimit"));
		
		String[] teamMembers = request.getParameterValues("username");
		String[] roles = request.getParameterValues("memberRole");
		
		String[] prefIndustry = request.getParameterValues("industry");
		String[] prefTech = request.getParameterValues("technology");
		
		boolean isNameTaken = tdm.isTeamNameTaken(teamName);
		
		boolean[] invalidMembers =new boolean[teamMembers.length];
		
		for(int i = 0; i < teamMembers.length; i++){
			try{
				Student st = sdm.retrieve(teamMembers[i]);
				invalidMembers[i] = sdm.hasTeam(st);
				
			}catch(Exception e){}
		}
		
		String[] teamMemberClone = teamMembers.clone();
		
		int numOfInvalidMembers = 0;
		
		for(int i = 0; i < invalidMembers.length; i++){
			if(invalidMembers[i] == true){
				numOfInvalidMembers++;
			}
		}
		
		boolean sameMember = false;
		
		for(int i = 0; i < teamMembers.length; i++){
			int memCount = 0;
			for(int j = 0; j < teamMemberClone.length; j++){
				if(teamMembers[i].equals(teamMemberClone[j])){
					memCount++;
				}
			}
			
			if(memCount >1){
				sameMember = true;
				break;
			}
		}
		
		if(isNameTaken || teamName.isEmpty()){
			session.setAttribute("message", "Team name cannot be empty or is already taken. Please try another name");
			response.sendRedirect("createTeam.jsp");
		}else if(sameMember || numOfInvalidMembers > 0){
			session.setAttribute("message", "There was an error with one or more of your team member selection. Please try again");
			response.sendRedirect("createTeam.jsp");
		}else if(teamLimit < teamMembers.length){
			session.setAttribute("message", "The number of members exceed your team limit. Please try again");
			response.sendRedirect("createTeam.jsp");
		}else{
		
			String projectManager = teamMembers[0];
			
			int pmid = 0;
			int supId = 0;
			try{
				pmid = udm.retrieve(projectManager).getID();
			}catch(Exception e){}
			
			Team team = new Team(teamid, teamName, teamDesc, teamLimit, pmid, supId);
			
			for(int i = 0; i < teamMembers.length; i++){
				User u = null; 
				try{
					u = udm.retrieve(teamMembers[i]);
					
					String role = roles[i];
					int id = u.getID();
					sdm.updateStudent(id, teamid, role);
				}catch(Exception e){}
			}
			tdm.add(team, prefIndustry, prefTech);
			response.sendRedirect("teamProfile.jsp?id="+teamid);
		}	
	}
}
