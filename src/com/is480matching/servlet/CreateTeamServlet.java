package com.is480matching.servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.is480matching.model.*;
import com.is480matching.manager.*;
import com.is480matching.service.AuthenticateService;

@SuppressWarnings("serial")
public class CreateTeamServlet extends HttpServlet {
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
		
		String teamName = request.getParameter("teamName");
		int teamLimit = Integer.parseInt(request.getParameter("teamLimit"));
		String [] teamMembers = request.getParameterValues("teamMember");
		String [] role = request.getParameterValues("role");
		
		String projectManager = teamMembers[0];
		
		TeamDataManager tdm = new TeamDataManager();
		Team team = new Team(teamName, projectManager, teamLimit);
		tdm.add(team, teamMembers, role);
	}
}
