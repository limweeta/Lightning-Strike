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
public class AddRoleServlet extends HttpServlet {

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
		
		RoleDataManager roledm = new RoleDataManager();
		UserDataManager udm = new UserDataManager();
		
		String username = request.getParameter("user");
		String role = request.getParameter("role");
		User u = null;
		try{
			Integer.parseInt(role);
			
			session.setAttribute("message", "Please choose a valid role.");
		}catch(Exception e){
			
			try{
				u = udm.retrieve(username);
				roledm.add(u, role);
				
				session.setAttribute("message", u.getFullName() + " has been asssigned the role of " + role);
			}catch(Exception e1){
				session.setAttribute("message", "Invalid User");
			}
		}
		
		response.sendRedirect("adminAddRole.jsp");
	}
}


