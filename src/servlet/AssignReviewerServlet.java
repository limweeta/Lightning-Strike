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

		TeamDataManager tdm = new TeamDataManager();
		
		int rev1User = Integer.parseInt(request.getParameter("assignRev1"));
		int rev2User =  Integer.parseInt(request.getParameter("assignRev2"));
		
		int teamId = 0;
		String teamName = request.getParameter("teamName");
		
		try{
			teamId = Integer.parseInt(request.getParameter("teamId"));
		}catch(Exception e){
			try{
				teamId = tdm.retrieveTeamByName(teamName).getId();
			}catch(Exception e1){
				session.setAttribute("message", "That team does not exist");
			}
		}
		
		Team t = null;
		int rev1Id = 0;
		int rev2Id = 0;
		User u = null;
		
		try{
			String message = "";
			
			//set first reviewer
			u = udm.retrieve(rev1User);
			rev1Id = u.getID();
			t = tdm.retrieve(teamId);
			t.setRev1Id(rev1Id);
			
			message += u.getFullName();
			
			//set second reviewer
			u = udm.retrieve(rev2User);
			rev2Id = u.getID();
			
			t.setRev2Id(rev2Id);
			
			message += " and " + u.getFullName();
			
			tdm.modify(t);
			
			message += " have been assigned to " + t.getTeamName() + " as their reviewers";
			
			session.setAttribute("message", message);
		}catch(Exception e){
			session.setAttribute("message", "Oops! An error occurred somewhere. Please try again");
		}
		response.sendRedirect("adminAssignRev.jsp");
	}
}