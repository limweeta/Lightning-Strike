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
		Project p = null;
		Team team = null;
		boolean eligibleToApply = false;
		
		
		
		try{
			team = tdm.retrieve(teamId);
			p = pdm.retrieve(projId);
			
			eligibleToApply = pdm.isEligibleForApplication(teamId);
			
			if(teamId == 0){
				session.setAttribute("message", "You must have a team before you can apply for a project");
			}else if(eligibleToApply){
				pdm.applyProj(teamId, projId);
				//SEND NOTIFICATION TO CREATOR
				session.setAttribute("message", "You have successfully applied for the project");
			}
		}catch(Exception e){}
		
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}