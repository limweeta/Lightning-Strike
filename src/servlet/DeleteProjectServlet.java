package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class DeleteProjectServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processAuthenticateRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processAuthenticateRequest(request, response);
	}
	
	public void processAuthenticateRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		
		ProjectDataManager pdm = new ProjectDataManager();
		UserDataManager udm = new UserDataManager();
		TeamDataManager tdm = new TeamDataManager();
		
		int projID = Integer.parseInt(request.getParameter("projId"));
		
		Project p = null;
		Team team = null;
		User u = null;
		
		try{
			p = pdm.retrieve(projID);
			u = udm.retrieve(p.getCreatorId());
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = u.getEmail();
		    String subject = "[IS480] Project has been deleted";
		    String content = p.getProjName() + " has been deleted.";
		     
		    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
		    
		    if(p.getTeamId() != 0 ){
		    	team = tdm.retrieve(p.getTeamId());
		    	
		    	u = udm.retrieve(team.getPmId());
		    	
			    recipient  = u.getEmail();
			    subject = "[IS480] Project has been deleted";
			    content = "The project you are undertaking, " + p.getProjName() + ", has been deleted.";
			     
			    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
		    }
		    */
		}catch(Exception e){}finally{
			pdm.remove(projID);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("searchProject.jsp");
		rd.forward(request, response);
	}
}
