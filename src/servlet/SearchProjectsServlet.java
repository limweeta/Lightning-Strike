package servlet;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;

import com.is480matching.model.*;
import com.is480matching.manager.*;
import com.is480matching.service.AuthenticateService;

@SuppressWarnings("serial")
public class SearchProjectsServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processSearchProjectsRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processSearchProjectsRequest(request, response);
	}
	
	public void processSearchProjectsRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		
		String projName = request.getParameter("projectName");
		String term = request.getParameter("term");
		String industry = request.getParameter("industryType");
		
		ProjectDataManager pdm = new ProjectDataManager();
		
		if(!projName.trim().isEmpty() || !term.isEmpty() || !industry.isEmpty()) {
			ArrayList<Project> projects = new ArrayList<Project>();
			Project searchProject;
			
			try {
				if(!projName.isEmpty()){
					searchProject = pdm.retrieveProjectsByName(projName);
					if(searchProject!= null){
						projects.add(searchProject);
					} else {
						writer.print("no such project name");
					}
				}
				
				if(!term.isEmpty()){
					ArrayList<Project> searchProjects = pdm.retrieveProjectsByTerm(term);
					if(searchProjects!=null){
						Iterator<Project> iterator = searchProjects.iterator();
						while (iterator.hasNext()){
							Project project = iterator.next();
							projects.add(project);
						}
					}	else {
							writer.print("no projects in this term");
					}
					
				}
				
				if(!industry.isEmpty()){
					ArrayList<Project> searchProjects = pdm.retrieveProjectsByIndustry(industry);
					if(searchProjects!=null){
						Iterator<Project> iterator = searchProjects.iterator();
						while (iterator.hasNext()){
							Project project = iterator.next();
							projects.add(project);
						}
					}	else {
							writer.print("no projects in this industry");
					}
					
				}
				
				if(projects!=null){
					HttpSession session = request.getSession();
					session.setAttribute("projects", projects);
					writer.print("true");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			writer.print("false");
		}
		
	}
}
