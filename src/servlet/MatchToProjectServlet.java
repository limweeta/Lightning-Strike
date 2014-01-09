package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class MatchToProjectServlet extends HttpServlet {
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
		String destPage = "";
		
		UserDataManager udm = new UserDataManager();
		StudentDataManager sdm =  new StudentDataManager();
		SkillDataManager skdm = new SkillDataManager();
		ProjectDataManager pdm = new ProjectDataManager();
		
		User user = null;
		Student std = null;
		ArrayList<String> skills = new ArrayList<String>();
		
		//GET ALL TEAM DETAILS
		TeamDataManager tdm = new TeamDataManager();
		
		Team stdTeam = null;
		ArrayList<Integer> preferredIndustry = new ArrayList<Integer>();
		ArrayList<Integer> preferredTechnologies = new ArrayList<Integer>();
		
		double score = 0.0;
		
		try{
			user = udm.retrieve(username);
			std = sdm.retrieve(username);
			skills = skdm.getUserSkills(user);
			
			stdTeam = tdm.retrieve(tdm.retrievebyStudent(user.getID()));
			
			//gets team's preferred industry and technologies
			preferredIndustry = tdm.retrieveTeamPreferredIndustry(stdTeam);
			preferredTechnologies = tdm.retrieveTeamPreferredTechnology(stdTeam);
			
			//Cross Ref with projects.industry_id
			ArrayList<ProjectScore> matchedIndustry = pdm.matchByIndustry(preferredIndustry);
			
			//Cross Ref with proj_technologies
			ArrayList<ProjectScore> matchedTechnology= pdm.matchByTechnology(preferredTechnologies);
		
			//Cross Ref with project_preferred_skills
			
			ArrayList<ProjectScore> combinedMatches = pdm.mergedMatchedProjects(matchedIndustry, matchedTechnology);
			
			//store list to be forwarded to results page
			request.setAttribute("combinedProjMatches", combinedMatches);
			
			destPage = "showMatched.jsp";
			
		}catch(Exception e){
			session.setAttribute("message", "You need a team before we can match you with a project");
			destPage = "searchProject.jsp";
		}finally{

			rd = request.getRequestDispatcher(destPage);
			rd.forward(request, response);
		}
		
	}
}
