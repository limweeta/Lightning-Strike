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
		int companyId = Integer.parseInt(request.getParameter("companyId"));
		int projTeamId = Integer.parseInt(request.getParameter("projTeamId"));
		int sponsorId = Integer.parseInt(request.getParameter("sponsorId"));
		int supervisorId = Integer.parseInt(request.getParameter("supervisorId"));
		int reviewer1Id = Integer.parseInt(request.getParameter("reviewer1Id"));
		int reviewer2Id = Integer.parseInt(request.getParameter("reviewer2Id"));
		
		String projName = request.getParameter("projName");
		String projDesc = request.getParameter("projDesc");
		String projStatus = request.getParameter("projStatus");
		
		String[] technologies = request.getParameterValues("technology");
		
		int industryId = Integer.parseInt(request.getParameter("industryId"));
		String termId = request.getParameter("termId");
		
		Project updateProj = null;
		
		try{
			updateProj = pdm.retrieve(projID);
			
			//UPDATE VALUES HERE
			updateProj.setCoyId(companyId);
			updateProj.setTeamId(projTeamId);
			updateProj.setSupervisorId(supervisorId);
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
		
		RequestDispatcher rd = request.getRequestDispatcher("searchProjects.jsp");
		rd.forward(request, response);
	}
}
