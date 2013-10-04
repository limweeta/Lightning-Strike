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
		
		ProjectDataManager pdm = new ProjectDataManager();
		
		int projID = Integer.parseInt(request.getParameter("projId"));
		int companyId = 0;
		
		try{
			companyId = Integer.parseInt(request.getParameter("companyId"));
		}catch(Exception e){
			companyId = 0;
		}
		int projTeamId = 0;
		
		try{
			projTeamId = Integer.parseInt(request.getParameter("projTeamId"));
		}catch(Exception e){
			projTeamId = 0;
		}
		
		int sponsorId = 0;
		
		
		try{
			sponsorId=Integer.parseInt(request.getParameter("sponsorId"));
		}catch(Exception e){
			sponsorId = 0;
		}

		int reviewer1Id = 0;
		
		try{
			reviewer1Id =  Integer.parseInt(request.getParameter("reviewer1Id"));
		}catch(Exception e){
			reviewer1Id = 0;
		}
		
		int reviewer2Id = 0; 
		try{
			reviewer2Id = Integer.parseInt(request.getParameter("reviewer2Id"));
		}catch(Exception e){
			reviewer2Id = 0;
		}
		
		
		String projName = request.getParameter("projName");
		String projDesc = request.getParameter("projectDesc");
		String projStatus = request.getParameter("projStatus");
		
		String[] technologies = request.getParameterValues("technology");
		System.out.println("Industry ID is: " + request.getParameter("industry"));
		int industryId = Integer.parseInt(request.getParameter("industry"));
		int termId = Integer.parseInt(request.getParameter("term"));
		
		Project updateProj = null;
		
		try{
			updateProj = pdm.retrieve(projID);
			
			//UPDATE VALUES HERE
			updateProj.setCoyId(companyId);
			updateProj.setTeamId(projTeamId);
			updateProj.setSponsorId(sponsorId);
			updateProj.setReviewer1Id(reviewer1Id);
			updateProj.setReviewer2Id(reviewer2Id);
			updateProj.setProjName(projName);
			updateProj.setProjDesc(projDesc);
			updateProj.setStatus(projStatus);
			updateProj.setIndustry(industryId);
			updateProj.setTermId(termId);
			
			//UPDATE SQL
			pdm.modify(updateProj);
			pdm.modifyTechnology(updateProj, technologies);
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("projectProfile.jsp?id="+projID);
		rd.forward(request, response);
	}
}
