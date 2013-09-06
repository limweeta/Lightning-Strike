package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

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
		
		
		ProjectDataManager pdm = new ProjectDataManager();
		
		ArrayList<Project> projects = pdm.retrieveAll();
		int id = 0;
		
		for(int i=0; i < projects.size(); i++){
			Project p = projects.get(i);
			if(id < p.getId()){
				id = p.getId();
			}
		}
		
		id++;
		
		String termID = request.getParameter("projectTerm");
		String projName = request.getParameter("projectName");
		String sponsor = request.getParameter("projectOrganization");
		String projDesc = request.getParameter("projectDescription");
		String projStatus = request.getParameter("projectStatus");
		String industry = request.getParameter("industryType");
		String status = request.getParameter("projectStatus");
		
		//if new sponsor, add to db
		
		//extract teamid or sponsorid from session
		// ifelse statement to identify team_id and sponsor_id 
		// if faculty, default below.
		
		int company_id = 0;
		int team_id = 0;
		int sponsor_id = 0;
		int supervisor_id = 0;
		int reviewer1_id = 0;
		int reviewer2_id = 0;
		
		
		Project proj = new Project(id, company_id, team_id, sponsor_id, supervisor_id, reviewer1_id, reviewer2_id, projName, projDesc, status, industry, termID);
		pdm.add(proj);
		
		response.sendRedirect("projectProfile.jsp?id="+id);
	}
}
