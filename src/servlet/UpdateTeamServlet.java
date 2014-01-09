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
		//updates from teamProfile.jsp
		
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		
		TeamDataManager tdm = new TeamDataManager();
		
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		int termId = Integer.parseInt(request.getParameter("term"));
		
		String[] members = request.getParameterValues("members");
		String[] roles = request.getParameterValues("roles");
		
		String[] industry = request.getParameterValues("industry");
		String[] technology = request.getParameterValues("technology");
		
		if(industry == null){
			industry = new String[0];
		}
		
		if(technology == null){
			technology = new String[0];
		}
		
		String link = request.getParameter("link");
			
		Team updateTeam = null;
		
		try{
			updateTeam = tdm.retrieve(teamId);
			
			//UPDATE VALUES HERE
			updateTeam.setTermId(termId);
			updateTeam.setWikiLink(link);
			
			//TO DO: Update members and roles; do validation check for eligible members
			
			
			//UPDATE SQL
			tdm.modify(updateTeam, industry, technology);
			//tdm.modifyStudents(updateTeam, members, roles);
			
			session.setAttribute("message", "Profile Saved");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("teamProfile.jsp?id="+teamId);
		rd.forward(request, response);
	}
}
