package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.lang.ArrayUtils;

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
		
		int intendedTermId = Integer.parseInt(request.getParameter("term"));
		int eligibleTermID = Integer.parseInt(request.getParameter("eligibleTerm"));
		String projName = request.getParameter("projectname");
		String company = request.getParameter("coyId");
		String sponsor = request.getParameter("sponsorId");
		String projDesc = request.getParameter("projectdescription");
		int industry = Integer.parseInt(request.getParameter("industrytype"));
		String[] technologies = request.getParameterValues("technology");
		String[] technologyNew = request.getParameterValues("techNew");
		
		if(technologies == null){
			technologies = new String[0];
		}
		
		String[] allTech = new String[technologies.length + technologyNew.length];
		
		if(technologyNew.length > 0){
			String[] newTech = new String[technologyNew.length]; 
			
			TechnologyDataManager techdm = new TechnologyDataManager();
			for(int i = 0; i < technologyNew.length; i++){
				String techName = technologyNew[i];
				if(techName.trim().length() > 2){
					techdm.add(techName);
				
					newTech[i] = Integer.toString(techdm.retrieveTechId(techName));
				}
			}
			
			allTech = (String[]) ArrayUtils.addAll(technologies, newTech);

		}else{
			allTech = technologies;
		}
		
		
		boolean merged = false;
		
		
		String status = "Open";
		
		boolean isNameTaken = pdm.isProjNameTaken(projName);
		
		int company_id = 0;
		int team_id = 0;
		int sponsor_id = 0;
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
		}else if(projDesc.isEmpty()){
			session.setAttribute("message", "Project description cannot be empty");
			response.sendRedirect("createProject.jsp");
		}else if(intendedTermId < eligibleTermID){
			session.setAttribute("message", "You can only have your project from the next term onward");
			response.sendRedirect("createProject.jsp");
		}else{	
			Project proj = new Project(id, company_id, team_id, sponsor_id, projName, projDesc, status, industry, creator_id, intendedTermId);
			pdm.add(proj);
			
			
			try{
				for(int j = 0; j < allTech.length; j++){
					Technology tech = tdm.retrieve(Integer.parseInt(allTech[j]));
					
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
			
			User creator = udm.retrieve(creator_id);	
			/*
				ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
			    String recipient  = creator.getEmail();
			    String subject = "[IS480] Your project has been created successfully";
			    String content = projName + " has been created."
			    		+ "\n Click <a href=\"202.161.45.127/is480-matching/projectProfile.jsp?id=" + id + "\">here</a> to view";
			     
			     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
				*/
			
				
			}catch(Exception e){
				//System.out.println("No technology");
			}
			session.setAttribute("message", "Project successfully created");
			response.sendRedirect("projectProfile.jsp?id="+id);
		}
	}
}
