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
		System.out.println(username);
		String fullName = request.getParameter("fullName");
		String contactNum = request.getParameter("contactNum");
		String email	= request.getParameter("email");
		String type		= "Sponsor";
		String coyName	= request.getParameter("coyName");
		String cContact	= request.getParameter("coyContact");
		int coyContact = Integer.parseInt(cContact);
		String coyAdd	= request.getParameter("coyAdd");
		String password	= request.getParameter("password");
		
		try {
			
			Company company = new Company(id, coyName, coyAdd, coyContact);
			cdm.add(company);
			
			Sponsor newSponsor = new Sponsor(sponsorid, username, fullName, contactNum, email, type, id, password, id);
			sdm.add(newSponsor);
			
			//System.out.println("Thank you for registering.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
		response.sendRedirect("index.jsp");
	}
}


