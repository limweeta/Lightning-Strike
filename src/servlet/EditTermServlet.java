package servlet;
import org.apache.catalina.util.Base64;

import manager.*;
import model.*;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.*;
import javax.servlet.*;


@SuppressWarnings("serial")
public class EditTermServlet extends HttpServlet {

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
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		
		String termStr = request.getParameter("termName");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		TermDataManager termdm = new TermDataManager();
		
		String termName =  "";
		
		int termId = 0;
		Term term = null;
		try{
			termId = Integer.parseInt(termStr);
			
			term = termdm.retrieve(termId);
			term.setStartDate(startDate);
			term.setEndDate(endDate);
			
			termdm.modify(term);
			
			termName = "AY" + term.getAcadYear() + " T" + term.getSem(); 
			
			session.setAttribute("message", termName + " has been edited");
			
		}catch(Exception e){
			session.setAttribute("message", "An error occured. Please try again.");
		}
		
		response.sendRedirect("adminTerm.jsp");
	}
}


