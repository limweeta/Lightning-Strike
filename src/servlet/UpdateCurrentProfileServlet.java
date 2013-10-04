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
		
		UserDataManager udm = new UserDataManager();
		StudentDataManager sdm =  new StudentDataManager();
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		String contact = request.getParameter("contactno");
		String secondMajor = request.getParameter("secondmajor");
		
		String[] skills = request.getParameterValues("skills");
		
		User user = null;
		Student student = null;
		try{
			user = udm.retrieve(userId);
			student = sdm.retrieve(userId);
			//UPDATE VALUES HERE
			user.setContactNum(contact);
			student.setSecondMajor(secondMajor);
			
			//UPDATE SQL
			sdm.modify(user, student, skills);
		}catch(Exception e){
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("userProfile.jsp?id="+userId);
		rd.forward(request, response);
	}
}
