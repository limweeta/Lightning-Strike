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
		
		String termID = request.getParameter("projectterm");
		String projName = request.getParameter("projectname");
		String company = request.getParameter("organization");
		String projDesc = request.getParameter("projectdescription");
		int industry = Integer.parseInt(request.getParameter("industrytype"));
		String[] technologies = request.getParameterValues("technology");
		String status ="Open";
		
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
		int creator_id = 0; 
		
		try{
			company_id = Integer.parseInt(company);
		}catch(Exception e){
			company_id = 0;
		}
		
		try{
			creator_id = udm.retrieve((String)session.getAttribute("username")).getID();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		Project proj = new Project(id, company_id, team_id, sponsor_id, supervisor_id, reviewer1_id, reviewer2_id, projName, projDesc, status, industry, termID, creator_id);
		pdm.add(proj);
		
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
			System.out.println("No technology");
		}
		response.sendRedirect("projectProfile.jsp?id="+id);
	}
}
