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

		UserDataManager udm = new UserDataManager();
		TeamDataManager tdm = new TeamDataManager();
		
		
		String supUser = request.getParameter("assignSup");
		String teamName = request.getParameter("teamName");
		
		int teamId = 0; 
		
		try{
			//check for valid team id
			teamId = Integer.parseInt(request.getParameter("teamId"));
		}catch(Exception e){
			try{
				teamId = (Integer) session.getAttribute("teamId");
			}catch(Exception ex){
				teamId = tdm.retrieveTeamByName(teamName).getId();
			}
		}
		
		
		if(supUser == null || supUser.isEmpty()){
			supUser = (String) session.getAttribute("assignSupName");
		}

		
		int supId = 0;
		User u = null;
		
		try{
			supId = Integer.parseInt(supUser);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			Team team = tdm.retrieve(teamId);
			u = udm.retrieve(supId);
			team.setSupId(supId);
			tdm.modify(team);
			
			session.setAttribute("message", u.getFullName() + " has been assigned to " + team.getTeamName() + " as their supervisor");
		}catch(Exception e){
			session.setAttribute("message", "Oops! An error occurred somewhere. Please try again");
		}
		response.sendRedirect("adminAssignSup.jsp");
	}
}