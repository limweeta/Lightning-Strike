package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class InviteStudentServlet extends HttpServlet {
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
		
		int teamId = Integer.parseInt(request.getParameter("visitorTeamId"));
		int userId = Integer.parseInt(request.getParameter("userid"));
		
		TeamDataManager tdm = new TeamDataManager();
		StudentDataManager stdm = new StudentDataManager(); 
		Team team = null;
		Student pm = null;
		Student std = null;
		
		try{
			team = tdm.retrieve(teamId);
			pm = stdm.retrieve(team.getPmId());
			std = stdm.retrieve(userId);
			
			//store invite in db
			tdm.studentRequest(userId, teamId);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = std.getEmail();
		    String subject = "[IS480] You have a new team invite";
		    String content = team.getTeamName() + " has invited you to join their team "
		    		+ "\n Click 202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + " to view";
		     
		    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			
			session.setAttribute("message", "You have invited " + std.getFullName() + " to join your team");
		
		}catch(Exception e){}
		
		response.sendRedirect("userProfile.jsp?id="+userId);
	}
}