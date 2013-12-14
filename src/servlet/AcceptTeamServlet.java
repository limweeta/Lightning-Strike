package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AcceptTeamServlet extends HttpServlet {
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
		
		UserDataManager udm = new UserDataManager();
		StudentDataManager stdm = new StudentDataManager();
		ProjectDataManager pdm = new ProjectDataManager();
		TeamDataManager tdm = new TeamDataManager();
		pdm.removeAllApplication(projId);
		
		Project p = null;
		Team t = null;
		Student std = null; 
		User sponsor = null;
		
		try{
			p = pdm.retrieve(projId);
			p.setTeamId(teamId);
			
			t =  tdm.retrieve(teamId);
			std = stdm.retrieve(t.getPmId());
			
			sponsor = udm.retrieve(p.getCreatorId());
			
			pdm.modify(p);
			
			
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = std.getEmail();
		    String subject = "[IS480] Your application to take on a project has been accepted";
		    String content = sponsor.getFullName() + " has accepted your application to take on their project, " + p.getProjName()
		    		+ "\n Click 202.161.45.127/is480-matching/projectProfile.jsp?id=" + projId + " to view";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			
			 //SEND EMAIL TO REJECT OTHER TEAMS

		     
			session.setAttribute("message", t.getTeamName() + " has undertaken your project");
		}catch(Exception e){}
		
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}