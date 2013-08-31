package com.is480matching.servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.is480matching.model.*;
import com.is480matching.manager.*;
import com.is480matching.service.AuthenticateService;

@SuppressWarnings("serial")
public class CreateProjectServlet extends HttpServlet {
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
		
		Long termID = Long.parseLong(request.getParameter("termId"));
		String projName = request.getParameter("projectName");
		String sponsor = request.getParameter("sponsor");
		String projDesc = request.getParameter("projectDescription");
		String projScope = request.getParameter("projectScope");
		String projDeliv = request.getParameter("projectDeliverables");
		
		String industry = request.getParameter("industryType");
		String tech = request.getParameter("technologyPreferred");
		String contact = request.getParameter("contact");
		
		ProjectDataManager pdm = new ProjectDataManager();
		Project proj = new Project(termID, projName, projDesc, "Pending", industry, tech, contact);
		pdm.add(proj);
	}
}
