package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class RejectInviteServlet extends HttpServlet {
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
		
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		int stdId = Integer.parseInt(request.getParameter("stdId"));
		
		TeamDataManager tdm = new TeamDataManager();
		
		Team t = null;
		
		try{
			tdm.removeTeamInvite(stdId, teamId);
			//SEND NOTIFICATION TO TEAM
			session.setAttribute("message", t.getTeamName() + " has been rejected");
		}catch(Exception e){}
		
		response.sendRedirect("userProfile.jsp?id="+stdId);
	}
}