package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.Project;
import model.Sponsor;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AssignReviewerServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void processAuthenticateRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		UserDataManager udm = new UserDataManager();

		ProjectDataManager pdm = new ProjectDataManager();
		
		String rev1User = request.getParameter("assignRev1");
		String rev2User = request.getParameter("assignRev2");
		System.out.println(rev1User);
		System.out.println(rev2User);
		int projId = 0;
		String projName = request.getParameter("projName");
		
		try{
			projId = Integer.parseInt(request.getParameter("projId"));
		}catch(Exception e){
			projId = pdm.retrieveProjectsByName(projName).getId();
		}
		
		Project p = null;
		int rev1Id = 0;
		int rev2Id = 0;
		User u = null;
		
		try{
			u = udm.retrieveByFullName(rev1User);
			System.out.println("*************" + u.getID() + "*************");
			rev1Id = u.getID();
			p = pdm.retrieve(projId);
			p.setReviewer1Id(rev1Id);
			
			u = udm.retrieveByFullName(rev2User);
			rev2Id = u.getID();
			
			p.setReviewer2Id(rev2Id);
		}catch(Exception e){
			rev2Id = 0;
			p.setReviewer2Id(rev2Id);
		}finally{
			
			pdm.modify(p);
		}
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}