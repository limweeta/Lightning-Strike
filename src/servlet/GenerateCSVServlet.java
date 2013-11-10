package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

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
		response.setHeader("Content-Disposition","attachment;filename=test.csv");
		
		int termId = Integer.parseInt(request.getParameter("term"));
		TeamDataManager tdm = new TeamDataManager();
		TermDataManager termdm = new TermDataManager();
		UserDataManager udm = new UserDataManager();
		ArrayList<Team> teamList = tdm.retrieveAllByTerm(termId);
		
		String term = "";
		String text = "";
		try{
			term = termdm.retrieve(termId).getAcadYear() + " T" + termdm.retrieve(termId).getSem();
		}catch(Exception e){}
		
		try
		{
		    text = "Term,Team,Supervisor\n";
	 	    
		    for(int i = 0; i < teamList.size(); i++){
		    	Team team = teamList.get(i);
		    	String sup = "";
		    	
		    	try{
		    		sup = udm.retrieve(team.getSupId()).getFullName();
		    	}catch(Exception e){}
		    	
		    	text += term + "," + team.getTeamName() + "," + sup + "\n";

		    }
		    
		    StringBuffer sb = new StringBuffer(text);
		    InputStream in = new ByteArrayInputStream(sb.toString().getBytes("UTF-8"));
		    ServletOutputStream out = response.getOutputStream();
		     
		    byte[] outputByte = new byte[4096];
		    
		    while(in.read(outputByte, 0, 4096) != -1)
		    {
		    	out.write(outputByte, 0, 4096);
		    }
		    
		    in.close();
		    out.flush();
		    out.close();
		    
		}
		catch(IOException e){
		     e.printStackTrace();
		}
		
		response.sendRedirect("export.jsp");
	}
}
