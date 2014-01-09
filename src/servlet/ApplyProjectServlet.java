package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class ApplyProjectServlet extends HttpServlet {
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
		UserDataManager udm = new UserDataManager();
		
		User sessionUser = null;
		
		Project p = null;
		Team team = null;
		boolean eligibleToApply = false;
		
		try{
			sessionUser = udm.retrieve((String)session.getAttribute("username"));
			
			team = tdm.retrieve(teamId);
			p = pdm.retrieve(projId);
			
			//checks if team is eligible to apply for project
			eligibleToApply = pdm.isEligibleForApplication(teamId, sessionUser.getID(), p.getId());
			
			User u = udm.retrieve(p.getCreatorId());
			
			if(teamId == 0){
				session.setAttribute("message", "You must have a team before you can apply for a project");
			}else if(eligibleToApply){
				//add to database
				pdm.applyProj(teamId, projId);
				//SEND NOTIFICATION TO CREATOR
					
				ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
			    String recipient  = u.getEmail();
			    String subject = "[IS480] You have an application pending approval/rejection";
			    String content = team.getTeamName() + " has applied for your project."
			    		+ "\n Click <a href=\"202.161.45.127/is480-matching/projectProfile.jsp?id=" + projId + "\">here</a> to view";
			     
			    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			     
				session.setAttribute("message", "You have successfully applied for the project.");
			}
		}catch(Exception e){}
		
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}