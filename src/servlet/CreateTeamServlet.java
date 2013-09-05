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
		StudentDataManager sdm = new StudentDataManager();
		
		UserDataManager udm = new UserDataManager();
		ArrayList<User> users = udm.retrieveAll();
		
		TeamDataManager tdm = new TeamDataManager();
		ArrayList<Team> members = tdm.retrieveAll();
		int teamid = (members.get(members.size()-1).getId()) + 1;
		
		PrintWriter writer = response.getWriter();
		String username = request.getParameter("username");
		String teamName = request.getParameter("teamName");
		String teamDesc = request.getParameter("teamDesc");
		int teamLimit = Integer.parseInt(request.getParameter("teamLimit"));
		
		String[] teamMembers = request.getParameterValues("members");
		String[] roles = request.getParameterValues("roles");
		
		String projectManager = teamMembers[0];
		
		int pmid = 0;
		
		try{
			pmid = udm.retrieve(projectManager).getID();
		}catch(Exception e){
			System.out.println("Invalid PM");
		}
		
		Team team = new Team(teamid, teamName, teamDesc, teamLimit, pmid);
		
		for(int i = 0; i < teamMembers.length; i++){
			User u = null; 
			
			try{
				u = udm.retrieve(teamMembers[i]);
			}catch(Exception e){
				System.out.println("Invalid Login");
			}
			
			String role = roles[i];
			
			int id = u.getID();
			sdm.updateStudent(id, teamid, role);
		}
		
		response.sendRedirect("viewTeam.jsp");
		
	}
}
