package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class StudentRequestServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void processAuthenticateRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		TeamDataManager tdm = new TeamDataManager();
		StudentDataManager stdm = new StudentDataManager(); 
		Team team = null;
		Student pm = null;
		Student std = null;
		try{
			team = tdm.retrieve(teamId);
			pm = stdm.retrieve(team.getPmId());
			std = stdm.retrieve(userId);
			
			tdm.studentRequest(userId, teamId);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = pm.getEmail();
		    
		    String subject = "[IS480] You have a new team request";
		    String content = std.getFullName() + " has requested to join your team, " + team.getTeamName()
		    		+ "\n Click 202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + " to view";
		     
		    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			session.setAttribute("message", "You have requested to join " + team.getTeamName());
		
		}catch(Exception e){}
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}