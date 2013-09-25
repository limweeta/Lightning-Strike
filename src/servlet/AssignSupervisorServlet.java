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
public class AssignSupervisorServlet extends HttpServlet {
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
		
		String supUser = request.getParameter("assignSup");
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		int projId = Integer.parseInt(request.getParameter("projId"));
		
		UserDataManager udm = new UserDataManager();

		ProjectDataManager pdm = new ProjectDataManager();
		
		int supId = 0;
		User u = null;
		
		try{
			u = udm.retrieve(supUser);
			supId = u.getID();
			Project p = pdm.retrieve(projId);
			p.setSupervisorId(supId);
			pdm.modify(p);
		}catch(Exception e){
			
		}
		response.sendRedirect("projectProfile.jsp?id="+projId);
	}
}