package servlet;

import java.io.*;
import java.util.ArrayList;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class GenerateAnalyticsCSVServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		processAuthenticateRequest(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			processAuthenticateRequest(request, response);
	}
	
	public void processAuthenticateRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		int viewType = Integer.parseInt(request.getParameter("viewType"));
		String title = "";
		TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> data = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
		String dataType = "";
		String factor = "";
		AnalyticsDataManager adm = new AnalyticsDataManager();
		
		switch (viewType){
			case 1:
				data = adm.projectByInd();
				title = "Projects By Industry";
				dataType = "Project";
				factor = "Industry";
				break;
			case 2: 
				data = adm.projectByTech();
				title = "Projects By Technology";
				dataType = "Project";
				factor = "Tech";
				break;
			case 3:
				data = adm.projectBySkills();
				title = "Projects By Skills";
				dataType = "Project";
				factor = "Skill";
				break;
			case 4:
				data = adm.studentBySkill();
				title = "Students By Skills";
				dataType = "Student";
				factor = "Skill";
				break;
			case 5:
				data = adm.teamByInd();
				title = "Teams By Industry";
				dataType = "Team";
				factor = "Industry";
				break;
			case 6:
				data = adm.teamByTech();
				title = "Teams By Technology";
				dataType = "Team";
				factor = "Tech";
				break;
			default:
				data = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
				break;
		}
		/*
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition","attachment;filename=test.csv");
		
		String state = "State";
		String text = "";
		ArrayList<Integer> allRawValues = new ArrayList<Integer>();
		HashMap<Integer, Integer> stateMap = new HashMap<Integer, Integer>();
		try
		{
		    
		    for (Map.Entry<String, TreeMap<Integer, ArrayList<Integer>>> entry : data.entrySet()){
		    	TreeMap<Integer, ArrayList<Integer>> mapValue = entry.getValue();
		    	if(text.length() < 1){
		    		text = entry.getKey();
		    	}else{
		    		text += "\n" + entry.getKey();
		    	}
		    	for (Map.Entry<Integer, ArrayList<Integer>> entryValue : mapValue.entrySet()){
		    		ArrayList<Integer> rawValues = entryValue.getValue();
		    		for(int i = 0; i < rawValues.size(); i++){
		    			if(!allRawValues.contains(rawValues.get(i))){
		    				allRawValues.add(rawValues.get(i));
		    				stateMap.put(rawValues.get(i), 1);
		    			}else{
		    				stateMap.put(rawValues.get(i), stateMap.get(rawValues.get(i)) + 1);
		    			}
		    		}
		    		text += "," + rawValues.size();
		    	}
		    	
		    }
		    
		    for(int i = 0; i < allRawValues.size(); i++){
		    	state += "," + Integer.toString(allRawValues.get(i));
		    }
		    
		    
		    String collatedData = state + "\n" + text;
		    
		    StringBuffer sb = new StringBuffer(collatedData);
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
		    
		    for (Map.Entry<Integer, Integer> entry : stateMap.entrySet())
		    {
		    	System.out.println(entry.getKey() + "/" + entry.getValue());
		    }
		    
		}
		catch(Exception e){
		     e.printStackTrace();
		}*/
		request.setAttribute("data", data);
		request.setAttribute("dataType", dataType);
		request.setAttribute("title", title);
		request.setAttribute("factor", factor);
		
		RequestDispatcher rd = request.getRequestDispatcher("testGroupCharts.jsp"); 
		rd.forward(request, response);
	}
}
