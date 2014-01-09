package servlet;

import manager.*;
import model.*;


import java.util.*;


import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;


@SuppressWarnings("serial")
public class SearchProjectServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		processRegisterRequest(request,response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		processRegisterRequest(request,response);
		
	}
	
	public void processRegisterRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//advanced search for project goes here
		response.setContentType("text/plain");
		
		ProjectDataManager pdm = new ProjectDataManager();
		ArrayList<Project> projects = new ArrayList<Project>();
		
		int term = 0;
		int ind = 0;
		int tech = 0;
		int skills = 0;
		
		String keyword = request.getParameter("keyword");
		String keywordType = request.getParameter("keywordType");
		
		//checks if there's any keyword entered
		if(keyword.length() > 0){
			
			projects = pdm.retrieveAllByKeyword(keyword, keywordType);
			//System.out.println("Here: /" + keyword.length() + "/");
		}else{
			//searches for relevant categories to filter from
			try{
				term = Integer.parseInt(request.getParameter("term"));
			}catch(Exception e){
				term = 0;
			}
			
			try{
				ind = Integer.parseInt(request.getParameter("ind"));
			}catch(Exception e){
				ind = 0;
			}
			
			try{
				tech = Integer.parseInt(request.getParameter("tech"));
			}catch(Exception e){
				tech = 0;
			}
			
			try{
				skills = Integer.parseInt(request.getParameter("skills"));
			}catch(Exception e){
				skills = 0;
			}
			projects = pdm.retrieveAllByFilter(term, ind, tech, skills);
			
		}
		
		request.setAttribute("projectList", projects);
		
		RequestDispatcher rd = request.getRequestDispatcher("searchProject.jsp");
		rd.forward(request, response);
	}
}


