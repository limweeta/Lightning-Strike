package servlet;

import java.io.*;

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
		StudentDataManager 
		PrintWriter writer = response.getWriter();
		String username = request.getParameter("username");
		String teamName = request.getParameter("teamName");
		String teamDesc = request.getParameter("teamDesc");
		int teamLimit = Integer.parseInt(request.getParameter("teamLimit"));
		
		String projectManager = teamMembers[0];
		
		TeamDataManager tdm = new TeamDataManager();
		Team team = new Team(teamName, projectManager, teamLimit);
		tdm.add(team, teamMembers, role);
	}
}
