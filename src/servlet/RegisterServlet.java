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
public class RegisterServlet extends HttpServlet {

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
		
		SponsorDataManager sdm = new SponsorDataManager();
		UserDataManager udm = new UserDataManager();
		CompanyDataManager cdm = new CompanyDataManager();
		
		ArrayList<User> users = udm.retrieveAll();
		int id = 0;
		for(int i =0; i < users.size(); i++){
			User u = users.get(i);
			if(id < u.getID()){
				id = u.getID();
			}
		}
		
		id++;
		
		ArrayList<Sponsor> sponsors = sdm.retrieveAll();
		int sponsorid = 0;
		for(int i =0; i < sponsors.size(); i++){
			Sponsor s = sponsors.get(i);
			if(sponsorid < s.getID()){
				sponsorid = s.getID();
			}
		}
		
		sponsorid++;
		
		String username = request.getParameter("userName");
		
		String fullName = request.getParameter("fullName");
		String contactNum = request.getParameter("contactNum");
		String email	= request.getParameter("email");
		String type		= "Sponsor";
		String coyName	= request.getParameter("coyName");
		String cContact	= request.getParameter("coyContact");
		int coyContact = Integer.parseInt(cContact);
		String coyAdd	= request.getParameter("coyAdd");
		int orgType	= Integer.parseInt(request.getParameter("orgType"));
		String password	= request.getParameter("password");
		
		
		char firstNum = contactNum.charAt(0);
		char firstCoyNum = cContact.charAt(0);
		
		if(udm.isTaken(username)){
			session.setAttribute("message", "Please choose another username");
			response.sendRedirect("index.jsp");
		}/*else if((firstNum != '9' || firstNum != '8' || contactNum.length() != 8) 
				|| (firstCoyNum != '9' || firstCoyNum != '8' || cContact.length() != 8) ){
			session.setAttribute("message", "Please enter a valid phone number");
			response.sendRedirect("index.jsp");
		}*/else{
			try {
				Company company = new Company(id, coyName, coyAdd, coyContact, orgType);
				cdm.add(company);
				
				Sponsor newSponsor = new Sponsor(sponsorid, username, fullName, contactNum, email, type, id, password, id);
				sdm.add(newSponsor);
				
				/*
				ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
			    String recipient  = email;
			    String subject = "[IS480] Your account has been created successfully";
			    String content = "Your account, " + username + ", has been created."
			    		+ "\n Click <a href=\"202.161.45.127/is480-matching/userProfile.jsp?id=" + sponsorid + "\">here</a> to view";
			     
			     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
				*/
				session.setAttribute("message", "Account successfully created");
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
			response.sendRedirect("index.jsp");
		}
	}
}


