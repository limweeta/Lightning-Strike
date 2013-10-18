package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class UpdateProjectServlet extends HttpServlet {
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
		ProjectDataManager pdm = new ProjectDataManager();
		
		int projID = Integer.parseInt(request.getParameter("projId"));
		int companyId = 0;
		
		try{
			companyId = Integer.parseInt(request.getParameter("coyId"));
		}catch(Exception e){
			companyId = 0;
		}
		int projTeamId = 0;
		
		try{
			projTeamId = Integer.parseInt(request.getParameter("teamId"));
		}catch(Exception e){
			projTeamId = 0;
		}
		
		int sponsorId = 0;
		
		
		try{
			sponsorId=Integer.parseInt(request.getParameter("sponsorId"));
		}catch(Exception e){
			sponsorId = 0;
		}

		
		String projName = request.getParameter("projName");
		String projDesc = request.getParameter("projectDesc");
		String projStatus = request.getParameter("projStatus");
		
		String[] skills		= request.getParameterValues("skill");
		String[] technologies = request.getParameterValues("technology");
		
		if(skills == null){
			skills = new String[0];
		}
		
		if(technologies == null){
			technologies = new String[0];
		}
		
		int industryId = Integer.parseInt(request.getParameter("industry"));
		int termId = Integer.parseInt(request.getParameter("term"));
		
		Project updateProj = null;
		
		try{
			updateProj = pdm.retrieve(projID);
			
			//UPDATE VALUES HERE
			updateProj.setCoyId(companyId);
			updateProj.setTeamId(projTeamId);
			updateProj.setSponsorId(sponsorId);
			updateProj.setProjName(projName);
			updateProj.setProjDesc(projDesc);
			updateProj.setStatus(projStatus);
			updateProj.setIndustry(industryId);
			updateProj.setTermId(termId);
			
			//UPDATE SQL
			pdm.modify(updateProj);
			pdm.modifyTechnology(updateProj, technologies);
			pdm.modifyPrefSkill(updateProj, skills);
			
			session.setAttribute("message", "Profile Updated");
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("projectProfile.jsp?id="+projID);
		rd.forward(request, response);
	}
}
