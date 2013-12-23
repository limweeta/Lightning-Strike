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
public class SponsorFeedbackServlet extends HttpServlet {

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
		
		TeamDataManager tdm = new TeamDataManager();
		FeedbackDataManager fdm = new FeedbackDataManager();
		
		String teamName = request.getParameter("teamname");
		int sponsorId = Integer.parseInt(request.getParameter("sponsorid"));
		String date = request.getParameter("date");
		
		int techRating = Integer.parseInt(request.getParameter("tech"));
		int domRating = Integer.parseInt(request.getParameter("domain"));
		int projRating = Integer.parseInt(request.getParameter("project"));
		int coyRating = Integer.parseInt(request.getParameter("company"));
		
		
		String often = request.getParameter("often");
		String modeOfComm = request.getParameter("comm");
		String how = request.getParameter("how");
		
		String free = request.getParameter("free");
		String another = request.getParameter("another");
		String feedback = request.getParameter("feedback");
		
		Team team = null;
		
		try{
			team = tdm.retrieveTeamByName(teamName);
			
			//System.out.println(date);
			fdm.add(team.getId(), sponsorId, techRating, domRating, projRating, coyRating, 
					often, modeOfComm, how, free, another, feedback);
			
			session.setAttribute("message", "Feedback recorded.");
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}


