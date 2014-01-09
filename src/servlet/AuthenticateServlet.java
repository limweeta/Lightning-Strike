package servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AuthenticateServlet extends HttpServlet {
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
		String username = request.getParameter("userName");
		String password = request.getParameter("password");
		
		//manual login; used for when external users/sponsors log in
		
		UserDataManager udm = new UserDataManager();
		
		if(!username.trim().isEmpty() && !password.trim().isEmpty()) {
			AuthenticateService authService = new AuthenticateService();
			Sponsor authSponsor;
			try {
				authSponsor = authService.authenticateSponsor(username, password);
				if(authSponsor!= null){
					
					String fullName = authSponsor.getFullName();
					String sponsorUsername	= authSponsor.getUsername();
					
					if(!udm.isSuspended(sponsorUsername)){
						
						session.setAttribute("fullname", fullName);
						session.setAttribute("username", sponsorUsername);
						session.setAttribute("type", udm.retrieve(sponsorUsername).getType());
						
						
						response.sendRedirect("mainPage.jsp");
					}else{
						session.setAttribute("message","You have  been suspended. Please contact the administrator for more details");
						response.sendRedirect("index.jsp");
					}
				} else {
					session.setAttribute("message", "Invalid Login");
					response.sendRedirect("index.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			session.setAttribute("message", "Invalid Login");
			response.sendRedirect("index.jsp");
		}
	}
}
