package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class UpdateTeamServlet extends HttpServlet {
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
		int teamLimit = Integer.parseInt(request.getParameter("teamLimit"));
		int pmId = Integer.parseInt(request.getParameter("pmId"));
		
		String teamDesc = request.getParameter("teamDesc");
		String teamName = request.getParameter("teamName");
		String[] members = request.getParameterValues("members");
		String[] roles = request.getParameterValues("roles");
		
		int supId = Integer.parseInt(request.getParameter("supId"));
		
		Team updateTeam = null;
		
		try{
			updateTeam = tdm.retrieve(teamId);
			
			//UPDATE VALUES HERE
			updateTeam.setTeamName(teamName);
			updateTeam.setTeamDesc(teamDesc);
			updateTeam.setTeamLimit(teamLimit);
			updateTeam.setPmId(pmId);
			updateTeam.setSupId(supId);
			
			//UPDATE SQL
			tdm.modify(updateTeam);
			tdm.modifyStudents(updateTeam, members, roles);
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("searchTeams.jsp");
		rd.forward(request, response);
	}
}
