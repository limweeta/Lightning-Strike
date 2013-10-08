package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class MatchToTeamServlet extends HttpServlet {
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
		
		RequestDispatcher rd;
		//GET USER DETAILS
		String username = (String) session.getAttribute("username");
		String destPage = "showMatchTeams.jsp";
		
		UserDataManager udm = new UserDataManager();
		StudentDataManager sdm =  new StudentDataManager();
		SkillDataManager skdm = new SkillDataManager();
		
		User user = null;
		Student std = null;
		ArrayList<String> skills = new ArrayList<String>();
		
		//GET ALL TEAM DETAILS
		TeamDataManager tdm = new TeamDataManager();
		ArrayList<Team> teams = tdm.retrieveAll();
		ArrayList<Team> eligibleTeams = new ArrayList<Team>();
		
		try{
			user = udm.retrieve(username);
			std = sdm.retrieve(username);
			skills = skdm.getUserSkills(user);
			
			//BASIC CHECK - EMPTY SLOTS & Preferred Role not taken
			eligibleTeams = tdm.retrieveEligibleTeams(std);
			request.setAttribute("matchedTeams", eligibleTeams);
		}catch(Exception e){
			destPage = "error.jsp";
		}finally{
			rd = request.getRequestDispatcher(destPage);
			rd.forward(request, response);
		}
		
	}
}
