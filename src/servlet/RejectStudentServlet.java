package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class RejectStudentServlet extends HttpServlet {
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
		Student st = null;
		try{
			t = tdm.retrieve(teamId);
			st = stdm.retrieve(stdId);
			tdm.removeStudentRequest(stdId, teamId);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = st.getEmail();
		    String subject = "[IS480] Your request has been rejected";
		    String content = "Your request for " + t.getTeamName() + " to join their team has been rejected."
		    		+ "\n Click 202.161.45.127/is480-matching/teamProfile.jsp?id=" + teamId + " to view";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			
			session.setAttribute("message", st.getFullName() + " has been rejected");
		}catch(Exception e){}
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}