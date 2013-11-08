package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AcceptStudentServlet extends HttpServlet {
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
		int stdId = Integer.parseInt(request.getParameter("stdId"));
		
		StudentDataManager stdm = new StudentDataManager();
		TeamDataManager tdm = new TeamDataManager();
		
		tdm.removeAllStudentRequest(teamId);
		
		Student std = null;
		
		try{
			std = stdm.retrieve(stdId);
			std.setTeamId(teamId);
			
			Team team = tdm.retrieve(teamId);
			
			stdm.modify(std);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = std.getEmail();
		    String subject = "[IS480] Your request to join a team has been accepted";
		    String content = team.getTeamName() + " has accepted your request to join their team."
		    		+ "\n Click 202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + " to view";
		     
		    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
		    //SEND EMAIL TO REJECT OTHER STUDENTS
		     
		     
			session.setAttribute("message", std.getFullName() + " has joined your team");
		}catch(Exception e){}
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}