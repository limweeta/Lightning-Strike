package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class SuspendUserServlet extends HttpServlet {
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
		UserDataManager udm = new UserDataManager();
		
		String username = request.getParameter("username");
		String reason = request.getParameter("reason");
		User u = null;
		
		try{
			u = udm.retrieve(username);
			
			//checks if user is already suspended
			if(udm.isSuspended(username)){
				 session.setAttribute("message", u.getFullName() + " is already suspended");
			}else{
				
				udm.suspend(u, reason);
				/*
				ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
			    String recipient  = u.getEmail();
			    
			    String subject = "[IS480] You have been suspended";
			    String content = " You have been suspended from the IS480 Matching System. "
			    		+ "\n Please contact benjamingan@smu.edu.sg for more details";
			     
			    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
				*/
			    session.setAttribute("message", u.getFullName() + " has been suspended");
			}
		}catch(Exception e){
			//INSERT ERROR MESSAGE
			e.printStackTrace();
		}
		
		response.sendRedirect("adminSuspend.jsp");
	}
}
