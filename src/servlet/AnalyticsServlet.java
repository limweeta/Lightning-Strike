package servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class AnalyticsServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void processAuthenticateRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		String query = request.getParameter("table");
		int duration = Integer.parseInt(request.getParameter("duration"));
		
		TeamDataManager tdm = new TeamDataManager();
		
		switch (query){
			case "Teams": 
				Map<Integer, Integer> teamsByTerm = tdm.analyticsRetrieveTeamByTerm();
				break;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("analytics.jsp");
		rd.forward(request, response);
	}
}