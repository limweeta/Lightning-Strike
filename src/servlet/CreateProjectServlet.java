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
		
		HttpSession session = request.getSession();
		UserDataManager udm = new UserDataManager();
		
		ProjectDataManager pdm = new ProjectDataManager();
		TechnologyDataManager tdm = new TechnologyDataManager();
		
		ArrayList<Project> projects = pdm.retrieveAll();
		int id = 0;
		
		for(int i=0; i < projects.size(); i++){
			Project p = projects.get(i);
			if(id <= p.getId()){
				id = p.getId();
			}
		}
		
		id++;
		
		String username = (String) session.getAttribute("username");
		
		int termID = Integer.parseInt(request.getParameter("term"));
		int eligibleTermID = Integer.parseInt(request.getParameter("eligibleTerm"));
		String projName = request.getParameter("projectname");
		String company = request.getParameter("coyId");
		String sponsor = request.getParameter("sponsorId");
		String projDesc = request.getParameter("projectdescription");
		int industry = Integer.parseInt(request.getParameter("industrytype"));
		String[] technologies = request.getParameterValues("technology");
		String[] skills = request.getParameterValues("skill");
		
		if(technologies == null){
			technologies = new String[0];
		}
		
		if(skills == null){
			skills = new String[0];
		}
		
		String status = "Open";
		
		boolean isNameTaken = pdm.isProjNameTaken(projName);
		
		int company_id = 0;
		int team_id = 0;
		int sponsor_id = 0;
		int reviewer1_id = 0;
		int reviewer2_id = 0;
		int creator_id = 0; 
		
		try{
			company_id = Integer.parseInt(company);
		}catch(Exception e){
			company_id = 0;
		}
		
		try{
			sponsor_id = Integer.parseInt(sponsor);
		}catch(Exception e){
			sponsor_id = 0;
		}
		
		try{
			creator_id = udm.retrieve(username).getID();
		}catch(Exception e){
			creator_id = 0;
		}
		
		if(isNameTaken || projName.isEmpty()){
			session.setAttribute("message", "Project name cannot be empty or is already taken. Please try another name");
			response.sendRedirect("createProject.jsp");
		}else if(eligibleTermID < termID){
			session.setAttribute("message", "You can only have your project from the next term onward");
			response.sendRedirect("createProject.jsp");
		}else{	
			Project proj = new Project(id, company_id, team_id, sponsor_id, reviewer1_id, reviewer2_id, projName, projDesc, status, industry, termID, creator_id);
			pdm.add(proj);
			
			pdm.addPreferredSkills(id, skills);
			
			try{
				for(int j = 0; j < technologies.length; j++){
					Technology tech = tdm.retrieve(Integer.parseInt(technologies[j]));
					
					ArrayList<Technology> techs = tdm.retrieveAll();
					int nextId = 0;
					for(int i = 0; i < techs.size(); i++){
						Technology tmpTech = techs.get(i);
						if(nextId <= tmpTech.getId()){
							nextId = tmpTech.getId() + 1;
							
						}
						
					}
					pdm.addTech(id, tech.getId());
				}
			}catch(Exception e){
				//System.out.println("No technology");
			}
			response.sendRedirect("projectProfile.jsp?id="+id);
		}
	}
}
