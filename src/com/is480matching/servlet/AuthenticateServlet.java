package com.is480matching.servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.is480matching.model.*;
import com.is480matching.service.AuthenticateService;

@SuppressWarnings("serial")
public class AuthenticateServlet extends HttpServlet {
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
		
		String username = request.getParameter("userName");
		String password = request.getParameter("password");
		
		if(!username.trim().isEmpty() && !password.trim().isEmpty()) {
			AuthenticateService authService = new AuthenticateService();
			Sponsor authSponsor;
			try {
				authSponsor = authService.authenticateSponsor(username, password);
				if(authSponsor!= null){
					HttpSession session = request.getSession();
					session.setAttribute("sponsor", authSponsor);
					writer.print("true");
				} else {
					writer.print("false1");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			writer.print("false");
		}
	}
}
