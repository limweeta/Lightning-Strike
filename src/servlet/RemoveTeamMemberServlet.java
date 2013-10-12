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
public class RemoveTeamMemberServlet extends HttpServlet {

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
		
		StudentDataManager stdm = new StudentDataManager();
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		String teamId = request.getParameter("teamId");
		System.out.println(userId);
		
		try{
			Student std = stdm.retrieve(userId);
			std.setRole(0);
			std.setTeamId(0);
			
			stdm.modify(std);
		}catch(Exception e){
			
		} 
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}


