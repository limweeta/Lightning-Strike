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
		int termId = Integer.parseInt(request.getParameter("term"));
		int teamLimit = Integer.parseInt(request.getParameter("teamLimit"));
		int pmId = Integer.parseInt(request.getParameter("pmId"));
		
		String teamName = request.getParameter("teamName");
		String[] members = request.getParameterValues("members");
		String[] roles = request.getParameterValues("roles");
		
		String[] industry = request.getParameterValues("industry");
		String[] technology = request.getParameterValues("technology");
		
		int supId = 0;
		try{
			supId = Integer.parseInt(request.getParameter("supId"));
		}catch(Exception e){
			supId = 0;
		}
			
		Team updateTeam = null;
		
		try{
			updateTeam = tdm.retrieve(teamId);
			
			//UPDATE VALUES HERE
			updateTeam.setTeamName(teamName);
			updateTeam.setTeamLimit(teamLimit);
			updateTeam.setPmId(pmId);
			updateTeam.setSupId(supId);
			updateTeam.setTermId(termId);
			
			//UPDATE SQL
			tdm.modify(updateTeam, industry, technology);
			tdm.modifyStudents(updateTeam, members, roles);
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("teamProfile.jsp?id="+teamId);
		rd.forward(request, response);
	}
}
