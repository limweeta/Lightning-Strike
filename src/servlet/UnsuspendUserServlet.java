package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class UnsuspendUserServlet extends HttpServlet {
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
		
		String[] userid = request.getParameterValues("userId");
		
		User u = null;
		
		try{
			//checks if any has been selected
			if(userid == null || userid.length < 1){
				 session.setAttribute("message", "No users selected to unsuspend");
			}else{
				String message = "The following users have been unsuspended: <br />";
				//unsuspends users
				for(int i = 0; i < userid.length; i++){
					u = udm.retrieve(Integer.parseInt(userid[i]));
					udm.unsuspend(u);
					message += u.getFullName() + "<br />";
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
				}
			    session.setAttribute("message", message);
			}
		}catch(Exception e){
			//INSERT ERROR MESSAGE
			e.printStackTrace();
		}
		
		response.sendRedirect("adminSuspended.jsp");
	}
}
