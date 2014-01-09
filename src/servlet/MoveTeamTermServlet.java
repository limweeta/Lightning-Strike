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
		HttpSession session = request.getSession();
		TeamDataManager tdm = new TeamDataManager();
		TermDataManager termdm = new TermDataManager();
		
		int termId = Integer.parseInt(request.getParameter("term"));
		
		String teamName = request.getParameter("team");
		
		Team updateTeam = null;
		Term term = null;
		try{
			updateTeam = tdm.retrieveTeamByName(teamName);
			
			//UPDATE TEAM TERM
			updateTeam.setTermId(termId);
			
			//UPDATE SQL
			tdm.modify(updateTeam);
			
			term = termdm.retrieve(termId);
			
			session.setAttribute("message", updateTeam.getTeamName() + " has been moved to AY" + term.getAcadYear() + " T" + term.getSem());
		}catch(Exception e){
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("adminTeam.jsp?");
		rd.forward(request, response);
	}
}
