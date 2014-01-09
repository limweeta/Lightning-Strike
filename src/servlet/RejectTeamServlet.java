package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class RejectTeamServlet extends HttpServlet {
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
		int projId = Integer.parseInt(request.getParameter("projId"));
		
		ProjectDataManager pdm = new ProjectDataManager();
		TeamDataManager tdm = new TeamDataManager();
		StudentDataManager stdm = new StudentDataManager();
		UserDataManager udm = new UserDataManager();
		
		pdm.removeTeamApplication(teamId);
		
		Project p = null;
		Team t = null;
		Student pm = null;
		User sponsor = null;
		try{
			//CODE INCORRECT; TO DO: remove team from applied_projects in db
			p = pdm.retrieve(projId);
			p.setTeamId(teamId);
			
			t =  tdm.retrieve(teamId);
			pm = stdm.retrieve(t.getPmId());
			sponsor = udm.retrieve(p.getSponsorId());
			pdm.modify(p);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = pm.getEmail();
		    
		    String subject = "[IS480] Your application to take on a project has been rejected";
		    String content = sponsor.getFullName() + " has rejected your application to take on their project, " + p.getProjName()
		    		+ "\n Click 202.161.45.127/is480-matching/searchProject.jsp to browse other projects";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			
			session.setAttribute("message", t.getTeamName() + " has been rejected for this project");
		}catch(Exception e){}
		
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}