package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class RejectInviteServlet extends HttpServlet {
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
		
		TeamDataManager tdm = new TeamDataManager();
		StudentDataManager stdm = new StudentDataManager();
		Team t = null;
		Student std = null;
		Student pm = null;
		try{
			t = tdm.retrieve(teamId);
			std = stdm.retrieve(stdId);
			pm = stdm.retrieve(t.getPmId());
			
			tdm.removeTeamInvite(stdId, teamId);
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = pm.getEmail();
		    String subject = "[IS480] Your request has been rejected";
		    String content = "Your request for " + std.getFullName() + " to join your team has been rejected."
		    		+ "\n Click 202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + " to view";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			session.setAttribute("message", t.getTeamName() + " has been rejected");
		}catch(Exception e){}
		
		response.sendRedirect("userProfile.jsp?id="+stdId);
	}
}