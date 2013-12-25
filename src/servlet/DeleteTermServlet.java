package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class DeleteTermServlet extends HttpServlet {
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
		
		TermDataManager tdm = new TermDataManager();
		
		String[] termId = request.getParameterValues("termId");
		
		HttpSession session = request.getSession();
		
		try{
			if(termId != null && termId.length > 0){
				for(int i = 0; i < termId.length; i++){
					tdm.remove(Integer.parseInt(termId[i]));
				}
				session.setAttribute("message", "Term(s) deleted");
			}else{
				session.setAttribute("message", "No terms selected");
			}
			
		}catch(Exception e){
			session.setAttribute("message", "Oops! An error occurred somewhere");
		}
		response.sendRedirect("adminTerm.jsp");
	}
}
