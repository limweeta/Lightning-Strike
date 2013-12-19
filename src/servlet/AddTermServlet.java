package servlet;
import org.apache.catalina.util.Base64;

import manager.*;
import model.*;

import javax.crypto.spec.SecretKeySpec;

import java.util.*;

import javax.crypto.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.*;
import javax.servlet.*;


@SuppressWarnings("serial")
public class AddTermServlet extends HttpServlet {

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
		
		
		String acadYear = request.getParameter("acadYear");
		int sem = Integer.parseInt(request.getParameter("semester"));
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		TermDataManager termdm = new TermDataManager();
		
		Term term = new Term(acadYear, sem, startDate, endDate);
		
		termdm.add(term);
		session.setAttribute("message", "Term " + acadYear + " T" + sem + " added");
		response.sendRedirect("admin.jsp");
		
	}
}


