package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.Project;
import model.Sponsor;

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
		
		ArrayList<Project> projects = pdm.retrieveAll();
		int id = projects.size() + 1;
		
		Long termID = Long.parseLong(request.getParameter("termId"));
		String projName = request.getParameter("projectName");
		String sponsor = request.getParameter("sponsor");
		String projDesc = request.getParameter("projectDescription");
		String projStatus = request.getParameter("projectStatus");
		String industry = request.getParameter("industryType");
		
		
		int supervisor_id = 0;
		int reviewer1_id = 0;
		int reviewer2_id = 0;
		String status = "Pending";
		ProjectDataManager pdm = new ProjectDataManager();
		Project proj = new Project(id, termID, company_id, team_id, sponsor_id, supervisor_id, reviewer1_id, reviewer2_id, projName, projDesc, status, industry);
		pdm.add(proj);
	}
}
