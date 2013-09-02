package com.is480matching.servlet;
import org.apache.catalina.util.Base64;

import com.is480matching.manager.SponsorDataManager;
import com.is480matching.model.Sponsor;
import com.is480matching.service.AuthenticateService;

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
		
		String username = request.getParameter("userName");
		String password = request.getParameter("password");
		String roleName = request.getParameter("roleName");
		String company	= request.getParameter("company");
		String address	= request.getParameter("address");
		
		if(!username.trim().isEmpty() && !password.trim().isEmpty() && !roleName.trim().isEmpty() && !company.trim().isEmpty() && !address.trim().isEmpty()) {
			Sponsor newSponsor = new Sponsor(username,password,roleName,company,address);
			try {
				sdm.add(newSponsor);
				writer.print("Thank you for registering.");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
	}
}


