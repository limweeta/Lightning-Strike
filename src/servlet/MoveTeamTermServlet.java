package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class MoveTeamTermServlet extends HttpServlet {
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
		
		TeamDataManager tdm = new TeamDataManager();
		
		int termId = Integer.parseInt(request.getParameter("termId"));
		
		String teamName = request.getParameter("teamName");
		
		Team updateTeam = null;
		
		try{
			updateTeam = tdm.retrieveTeamByName(teamName);
			
			//UPDATE VALUES HERE
			updateTeam.setTermId(termId);
			
			//UPDATE SQL
			tdm.modify(updateTeam);
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("teamProfile.jsp?id="+updateTeam.getId());
		rd.forward(request, response);
	}
}
