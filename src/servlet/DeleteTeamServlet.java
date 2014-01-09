package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class DeleteTeamServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processAuthenticateRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processAuthenticateRequest(request, response);
	}
	
	public void processAuthenticateRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		
		TeamDataManager tdm = new TeamDataManager();
		StudentDataManager stdm = new StudentDataManager();
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		
		Student std = null;
		Team team = null;
		ArrayList<Integer> membersId = new ArrayList<Integer>();
		HttpSession session = request.getSession();
		
		try{
			team = tdm.retrieve(teamId);
			
			membersId = tdm.retrieveStudentsInTeam(team);
			//TO DO: update all members to set team and role to 0
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
			
			for(int i = 0; i < membersId.size(); i++){
				std = stdm.retrieve(membersId.get(i));
				
				String recipient  = std.getEmail();
			    String subject = "[IS480] Your team has been deleted";
			    String content = team.getTeamName() + " has been deleted.";
			     
			    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			}
			*/
		}catch(Exception e){
			
		}
		
		
		tdm.updateStudentsIfTeamDeleted(teamId); //Update Students Table
		tdm.updateProjectIfTeamDeleted(teamId);	//Update Project Table
		tdm.updateTeamIndustryIfTeamDeleted(teamId);
		tdm.updateTeamTechIfTeamDeleted(teamId);
		tdm.deleteAppliedProjsIfTeamDeleted(teamId);
		
		tdm.remove(teamId);
		session.setAttribute("message", "Team deleted");
		response.sendRedirect("searchTeam.jsp");
	}
}
