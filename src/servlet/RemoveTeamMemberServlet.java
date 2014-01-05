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
		TeamDataManager tdm = new TeamDataManager();
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		int teamId = Integer.parseInt(request.getParameter("teamId"));
		
		try{
			Student std = stdm.retrieve(userId);
			
			
			Team team = tdm.retrieve(teamId);
			
			ArrayList<String> members = tdm.retrieveStudentsInTeam(team.getTeamName());
			
			if(members.size() == 1){
				tdm.remove(team.getId());
			}else{
				int nextRole = std.getRole();
				
				std.setRole(0);
				std.setTeamId(0);
				stdm.modify(std);
				
				members = tdm.retrieveStudentsInTeam(team.getTeamName());
				
				if(nextRole != 1){
					nextRole = 0;
					int stdRole = 0;
					for(int i = 0; i < members.size(); i++){
						Student student = stdm.retrieve(members.get(i));
						stdRole = student.getRole();
						
						if(nextRole == 0 || stdRole < nextRole){
							nextRole = stdRole;
						}
					}
					
					std = stdm.retrieveAllStudentByTeamRole(team.getId(), nextRole);
					std.setRole(1);
					
					stdm.modify(std);
					
				}
				
			}
			
			
			/*
			ServletContext context = getServletContext();
			String host = context.getInitParameter("host");
			String port = context.getInitParameter("port");
			String user = context.getInitParameter("user");
			String pass = context.getInitParameter("pass");
		    String recipient  = std.getEmail();
		    String subject = "[IS480] You have been removed from your team";
		    String content = team.getTeamName() + " has removed you from their team"
		    		+ "\n Click 202.161.45.127/is480-matching/searchTeam.jsp to browse other teams";
		     
		     EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
			*/
			
		}catch(Exception e){
			
		} 
		
		response.sendRedirect("teamProfile.jsp?id="+teamId);
	}
}


