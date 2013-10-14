package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class DeleteTeamServlet extends HttpServlet {
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
		
		TeamDataManager tdm = new TeamDataManager();
		
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		
		tdm.updateStudentsIfTeamDeleted(teamId); //Update Students Table
		tdm.updateProjectIfTeamDeleted(teamId);	//Update Project Table
		tdm.updateTeamIndustryIfTeamDeleted(teamId);
		tdm.updateTeamTechIfTeamDeleted(teamId);
		tdm.deleteAppliedProjsIfTeamDeleted(teamId);
		
		tdm.remove(teamId);
		
		response.sendRedirect("searchTeam.jsp");
	}
}
