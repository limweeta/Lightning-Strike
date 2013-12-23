package servlet;

import manager.*;
import model.*;


import java.util.*;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.*;
import javax.servlet.*;


@SuppressWarnings("serial")
public class TeamFeedbackServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		processRegisterRequest(request,response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		processRegisterRequest(request,response);
		
	}
	
	public void processRegisterRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		
		StudentDataManager stdm = new StudentDataManager();
		FeedbackDataManager fdm = new FeedbackDataManager();
		
		String[] members = request.getParameterValues("username");
		String[] rating = request.getParameterValues("rating");
		String[] comments = request.getParameterValues("comments");
		
		String gradername = request.getParameter("graderUser");
		
		String teamName = request.getParameter("teamName");
		
		Student student = null;
		Student grader = null;
		try{
			
			grader = stdm.retrieve(gradername);
			
			for(int i = 0; i < members.length; i++){
				student = stdm.retrieve(members[i]);
				
				fdm.add(grader.getID(), teamName, student.getID(), Integer.parseInt(rating[i]), comments[i]);
			}
			
			session.setAttribute("message", "Feedback recorded.");
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}


