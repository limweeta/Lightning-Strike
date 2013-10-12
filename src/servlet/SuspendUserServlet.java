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
		
		UserDataManager udm = new UserDataManager();
		
		String username = request.getParameter("username");
		System.out.println("********************" + username);
		User u = null;
		
		try{
			u = udm.retrieve(username);
			
			udm.suspend(u);
			
		}catch(Exception e){
			//INSERT ERROR MESSAGE
			e.printStackTrace();
		}
		
		response.sendRedirect("admin.jsp");
	}
}
