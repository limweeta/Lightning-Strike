package servlet;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.jasper.tagplugins.jstl.core.Out;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class GenerateCSVServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processAuthenticateRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processAuthenticateRequest(request, response);
			

	}
	
	public void processAuthenticateRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition","attachment;filename=schedulingdata.csv");
		
		int termId = Integer.parseInt(request.getParameter("term"));
		TeamDataManager tdm = new TeamDataManager();

		UserDataManager udm = new UserDataManager();
		ArrayList<Team> teamList = tdm.retrieveAllByTerm(termId);
		User u = null;
		
		String text = "";
		
		int supId = 0;
		int rev1Id = 0;
		int rev2Id = 0;
		
		try
		{
		    text = "teamName,fullName,username,role,presentation\n";
		    
		    for(int i = 0; i < teamList.size(); i++){
		    	Team team = teamList.get(i);
		    	
		    	ArrayList<String> members = tdm.retrieveStudentsInTeam(team.getTeamName());
		    	
		    	for(int j = 0; j < members.size(); j++){
		    		try{
		    			u = udm.retrieve(members.get(j));
			    		text += team.getTeamName() + "," + u.getFullName() + "," + u.getUsername() + ",Student,Private\n"; 
		    		}catch(Exception e){}
		    	}
		    	
		    	supId = team.getSupId();
		    	
		    	if(supId == 0){
		    		text += team.getTeamName() + ",-,-,Supervisor,Private\n";
		    	}else{
		    		try{
		    			u = udm.retrieve(supId);
		    			
		    			text += team.getTeamName() + "," + u.getFullName() + "," + u.getUsername() + ",Supervisor,Private\n";
		    		}catch(Exception e){}
		    	}

		    	rev1Id = team.getRev1Id();
		    	
		    	if(rev1Id == 0){
		    		text += team.getTeamName() + ",-,-,Reviewer 1,Private\n";
		    	}else{
		    		try{
		    			u = udm.retrieve(rev1Id);
		    			
		    			text += team.getTeamName() + "," + u.getFullName() + "," + u.getUsername() + ",Reviewer 1,Private\n";
		    		}catch(Exception e){}
		    	}
		    	
		    	rev2Id = team.getRev2Id();
		    	
		    	if(rev2Id == 0){
		    		text += team.getTeamName() + ",-,-,Reviewer 2,Private\n";
		    	}else{
		    		try{
		    			u = udm.retrieve(rev2Id);
		    			
		    			text += team.getTeamName() + "," + u.getFullName() + "," + u.getUsername() + ",Reviewer 2,Private\n";
		    		}catch(Exception e){}
		    	}
		    	
		    }
		    
		    StringBuffer sb = new StringBuffer(text);
		    InputStream in = new ByteArrayInputStream(sb.toString().getBytes("UTF-8"));
		    ServletOutputStream out = response.getOutputStream();
		     
		    byte[] outputByte = new byte[text.length()];
		    
		    while(in.read(outputByte, 0, outputByte.length) != -1)
		    {
		    	out.write(outputByte, 0, outputByte.length);
		    }
		    
		    in.close();
		    out.flush();
		    out.close();
		    
		}
		catch(IOException e){
		     e.printStackTrace();
		}

	}
}
