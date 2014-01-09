package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class DeleteSponsorServlet extends HttpServlet {
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
		
		String sponsorUsername = request.getParameter("sponsorUsername");
		String reason = request.getParameter("reason");
		
		SponsorDataManager sponsordm = new SponsorDataManager();
		
		HttpSession session = request.getSession();
		Sponsor sponsor = null;
		try{
			sponsor = sponsordm.retrieve(sponsorUsername);
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
			
			for(int i = 0; i < membersId.size(); i++){
				std = stdm.retrieve(membersId.get(i));
				
				String recipient  = sponsor.getEmail();
			    String subject = "[IS480] Your team has been deleted";
			    String content = team.getTeamName() + " has been deleted.";
			     
			    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			}
			*/
			
			sponsordm.remove(sponsor);
			session.setAttribute("message", "Sponsor deleted");
		}catch(Exception e){}
		
		response.sendRedirect("adminDeleteSponsor.jsp");
	}
}
