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
public class AddTechServlet extends HttpServlet {

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
		
		TechnologyDataManager techdm = new TechnologyDataManager();
		UserDataManager udm = new UserDataManager();
		
		String techCat = request.getParameter("techCat");
		
		String[] categories = techCat.split(" ");
		
		int catid = Integer.parseInt(categories[0]);
		String subcatid = categories[1];
		
		if(subcatid.equalsIgnoreCase("0")){
			subcatid = "NULL";
		}
		
		String techName = request.getParameter("tech");
		
		User u = null;

		try{
			techdm.add(techName, catid, subcatid);
			
			session.setAttribute("message", techName + " has been added to the list");
		}catch(Exception e1){
			session.setAttribute("message", "Oops! Something went wrong. Please try again.");
		}
	
		
		response.sendRedirect("adminAddTech.jsp");
	}
}


