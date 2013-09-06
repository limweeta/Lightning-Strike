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
		String type		= request.getParameter("type");
		String coyName	= request.getParameter("coyName");
		String password	= request.getParameter("password");
		
		if(!username.trim().isEmpty() && !fullName.trim().isEmpty() && !contactNum.trim().isEmpty() && !email.trim().isEmpty() && !coyName.trim().isEmpty()&& !password.trim().isEmpty()) {
			Sponsor newSponsor = new Sponsor(sponsorid, username, fullName, contactNum, email, type, coyName, password, id);
			try {
				sdm.add(newSponsor);
				writer.print("Thank you for registering.");
				response.sendRedirect("index.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
	}
}


