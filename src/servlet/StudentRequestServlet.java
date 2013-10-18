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
public class StudentRequestServlet extends HttpServlet {
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
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		TeamDataManager tdm = new TeamDataManager();
		
		Team team = null;
		
		try{
			team = tdm.retrieve(teamId);
			
			tdm.studentRequest(userId, teamId);
			
			session.setAttribute("message", "You must have requested to join " + team.getTeamName());
		
		}catch(Exception e){}
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}