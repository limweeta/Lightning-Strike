package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AcceptInviteServlet extends HttpServlet {
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
		Team team = null;
		
		try{
			std = stdm.retrieve(stdId);
			std.setTeamId(teamId);
			team  = tdm.retrieve(teamId);
			
			if(tdm.emptySlots(team)){
				tdm.removeAllTeamInvite(teamId);
			}else{
				tdm.removeTeamInvite(stdId, teamId);
			}
			
			stdm.modify(std);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = stdm.retrieve(team.getPmId()).getEmail();
		    String subject = "[IS480] Your invitation to " + std.getFullName() + " has been accepted";
		    String content = std.getFullName() + " has accepted your invitation."
		    		+ "\n Click <a href=\"202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + "\">here</a> to view";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			//SEND EMAIL TO REJECT OTHER TEAMS
 
		     
			session.setAttribute("message", "You have joined " + team.getTeamName());
		}catch(Exception e){}
		
		response.sendRedirect("userProfile.jsp?id="+stdId);
	}
}