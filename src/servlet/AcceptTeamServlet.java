package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.Project;
import model.Sponsor;

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
		
		ProjectDataManager pdm = new ProjectDataManager();
		TeamDataManager tdm = new TeamDataManager();
		pdm.removeAllApplication(projId);
		
		Project p = null;
		Team t = null;
		
		
		try{
			p = pdm.retrieve(projId);
			p.setTeamId(teamId);
			
			t =  tdm.retrieve(teamId);
			
			pdm.modify(p);
			//SEND NOTIFICATION TO TEAM
			session.setAttribute("message", t.getTeamName() + " has undertaken your project");
		}catch(Exception e){}
		
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}