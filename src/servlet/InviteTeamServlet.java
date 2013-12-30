package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class InviteTeamServlet extends HttpServlet {
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
		String sponsorUsername = (String)session.getAttribute("username");
		
		SponsorDataManager spdm = new SponsorDataManager();
		TeamDataManager tdm = new TeamDataManager();

		Team team = null;
		Sponsor sponsor = null;
		
		try{
			sponsor = spdm.retrieve(sponsorUsername);
			sponsor.getCoyId();
			
			team  = tdm.retrieve(teamId);
			ArrayList<Student> members = tdm.retrieveAllStudents(team);
			
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = "";
		    String subject = "[IS480] Your team has an invitation to view a project";
		    String content = sponsor.getFullName() + " has invited you to view his/her project(s)."
		    		+ "\n Click 202.161.45.127/is480-matching/userProfile.jsp?id=" + sponsor.getID() + " to view";
		     
		    for(int i  = 0; i < members.size(); i++){
		    	Student std = members.get(i);
		    	recipient = std.getEmail();  
		    	EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
		    }
		    
		    subject = "[IS480] Invitations sent";
		    content = "You have invited " + team.getTeamName() + " to view your projects"
		    		+ "\n Click 202.161.45.127/is480-matching/userProfile.jsp?id=" + sponsor.getID() + " to view your profile";
		    recipient = sponsor.getEmail();
		    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
		    
		    tdm.inviteTeam(teamId, sponsor.getID());
		    
			session.setAttribute("message", "You have invited " + team.getTeamName() + " to view your project");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		response.sendRedirect("searchTeam.jsp");
	}
}