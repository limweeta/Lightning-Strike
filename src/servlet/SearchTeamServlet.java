package servlet;

import manager.*;
import model.*;

import java.util.*;


import java.io.IOException;

import javax.servlet.http.*;
import javax.servlet.*;


@SuppressWarnings("serial")
public class SearchTeamServlet extends HttpServlet {

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
		
		response.setContentType("text/plain");
		
		TeamDataManager tdm = new TeamDataManager();
		ArrayList<Team> teams = new ArrayList<Team>();
		
		String[] tech = request.getParameterValues("tech");
		String[] ind = request.getParameterValues("ind");
		String[] skills = request.getParameterValues("skills");
		
		int term = 0;
		
		String keyword = request.getParameter("keyword");
		String keywordType = request.getParameter("keywordType");
		
		
			try{
				term = Integer.parseInt(request.getParameter("term"));
			}catch(Exception e){
				term = 0;
			}
			
			
			teams = tdm.retrieveAllByFilter(term, tech, ind, skills);
		
		
		request.setAttribute("teamList", teams);
		
		RequestDispatcher rd = request.getRequestDispatcher("searchTeam.jsp");
		rd.forward(request, response);
	}
}


