package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class UpdateCurrentProfileServlet extends HttpServlet {
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
		StudentDataManager sdm =  new StudentDataManager();
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		String type = (String) session.getAttribute("type");
		
		String contact = request.getParameter("contactno");
		
		char firstNum = contact.charAt(0);
		
		User user = null;
		
		if(type.equalsIgnoreCase("Student")){
			
			String secondMajor = request.getParameter("secondmajor");
			int prefRole = 0;
			
			try{
				prefRole = Integer.parseInt(request.getParameter("preferredRole"));
			}catch(Exception e){
				prefRole = 0;
			}
			String[] skills = request.getParameterValues("skills");
			
			if(skills == null){
				skills = new String[0];
			}
			
			if(contact.length() != 8){ //check that it starts with 9, 8 or 6
				session.setAttribute("message", "Please enter a valid phone number");
			}else if(!sdm.isValidMajor(secondMajor)){
				session.setAttribute("message", "Please enter a valid second major");
			}else{
				Student student = null;
				try{
					user = udm.retrieve(userId);
					student = sdm.retrieve(userId);
					//UPDATE VALUES HERE
					user.setContactNum(contact);
					student.setSecondMajor(secondMajor);
					student.setPreferredRole(prefRole);
					
					//UPDATE SQL
					sdm.modify(user, student, skills);
					session.setAttribute("message", "Profile Updated");
				}catch(Exception e){
					
				}
			}
		}else if(type.equalsIgnoreCase("Sponsor")){
			try{
				String fullname = request.getParameter("fullname");
				user = udm.retrieve(userId);
				user.setContactNum(contact);
				user.setFullName(fullname);
				
				udm.modify(user);
				session.setAttribute("message", "Profile Updated");
			}catch(Exception e){
				
			}
		}
		RequestDispatcher rd = request.getRequestDispatcher("userProfile.jsp?id="+userId);
		rd.forward(request, response);
	}
}
