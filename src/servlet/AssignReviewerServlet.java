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
		
		String rev1User = request.getParameter("assignRev1");
		String rev2User = request.getParameter("assignRev2");
		System.out.println(rev1User);
		System.out.println(rev2User);
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
			u = udm.retrieveByFullName(rev1User);
			rev1Id = u.getID();
			t = tdm.retrieve(teamId);
			t.setRev1Id(rev1Id);
			
			u = udm.retrieveByFullName(rev2User);
			rev2Id = u.getID();
			
			t.setRev2Id(rev2Id);
			
			tdm.modify(t);
		}catch(Exception e){
		}
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}