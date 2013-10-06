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
		
		System.out.println("This is the top of the page");
		
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
		ArrayList<Integer> teamSkills = new ArrayList<Integer>();
		
		int score = 0;
		
		try{
			user = udm.retrieve(username);
			std = sdm.retrieve(username);
			skills = skdm.getUserSkills(user);
			
			stdTeam = tdm.retrieve(tdm.retrievebyStudent(user.getID()));
			
			preferredIndustry = tdm.retrieveTeamPreferredIndustry(stdTeam);
			preferredTechnologies = tdm.retrieveTeamPreferredTechnology(stdTeam);
			teamSkills = tdm.retrieveTeamSkills(stdTeam);
			
			//Cross Ref with projects.industry_id
			ArrayList<Project> matchedIndustry = pdm.matchByIndustry(preferredIndustry);
			System.out.println("Industry Matched");
			//Cross Ref with proj_technologies
			ArrayList<Project> matchedTechnology= pdm.matchByTechnology(preferredTechnologies);
			System.out.println("Technology Matched");
			//Cross Ref with project_preferred_skills
			ArrayList<Project> matchedSkills = pdm.matchBySkill(teamSkills);
			System.out.println("Skills Matched");
			
			ArrayList<Project> combinedMatches = pdm.mergedMatchedProjects(matchedIndustry, matchedSkills, matchedTechnology);
			System.out.println("Merge Matched");
			request.setAttribute("combinedProjMatches", combinedMatches);
			
			destPage = "showMatched.jsp";
			System.out.println(destPage);
			
		}catch(Exception e){
			destPage = "error.jsp";
		}finally{
			System.out.println("Redirecting...");
			rd = request.getRequestDispatcher(destPage);
			rd.forward(request, response);
		}
		
	}
}
