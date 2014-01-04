package servlet;

import java.io.*;
import java.text.SimpleDateFormat;
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
				data = adm.studentBySkill();
				title = "Students By Skills";
				dataType = "Student";
				factor = "Skill";
				break;
			case 4:
				data = adm.teamByInd();
				title = "Teams By Industry";
				dataType = "Team";
				factor = "Industry";
				break;
			case 5:
				data = adm.teamByTech();
				title = "Teams By Technology";
				dataType = "Team";
				factor = "Tech";
				break;
			default:
				data = new TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>();
				break;
		}
		
		String directory = "C:\\Users\\admin\\git\\Lightning-Strike\\WebContent\\Analytics Data\\";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HHmm");
		Date date = new Date();
		String timestampStr = sdf.format(date);
		
		directory += timestampStr;
		directory += " " + title;
		
		
		File f = new File(directory);
		try{
		    if(f.mkdir()) { 
		        System.out.println("Directory Created");
		    } else {
		        System.out.println("Directory is not created");
		    }
		} catch(Exception e){
		    e.printStackTrace();
		} 
		
		
		File file = null;
        Writer output = null;
		
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition","attachment;filename=test.csv");
		
		String state = "State";
		String text = "";
		ArrayList<Integer> allRawValues = new ArrayList<Integer>();
		HashMap<Integer, Integer> stateMap = new HashMap<Integer, Integer>();
		try
		{
		   
		    for (Map.Entry<String, TreeMap<Integer, ArrayList<Integer>>> entry : data.entrySet()){
		    	String acadYear = entry.getKey();
		    	
		    	String acadYearfmt = acadYear.replaceAll("/", "");
		    	acadYearfmt = acadYearfmt.replaceAll(" ", "");
		    	
		    	String dataFile = directory + "\\" + acadYearfmt + ".csv";
		    	
		    	file = new File(dataFile);
		        output = new BufferedWriter(new FileWriter(file));
		        
		    	TreeMap<Integer, ArrayList<Integer>> mapValue = entry.getValue();
		    	
		    	for (Map.Entry<Integer, ArrayList<Integer>> entryValue : mapValue.entrySet()){
		    		state += "," + entryValue.getKey();
		    		
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
		    	output.write(state);
		    	output.write(text);
		    	System.out.println(text);
		    }
		    
		    for(int i = 0; i < allRawValues.size(); i++){
		    	state += "," + Integer.toString(allRawValues.get(i));
		    }
		    
		    output.flush();
		    output.close();
		    
		    
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
		    
		    
		    /*
		    for (Map.Entry<Integer, Integer> entry : stateMap.entrySet())
		    {
		    	System.out.println(entry.getKey() + "/" + entry.getValue());
		    }
		    */
		}
		catch(Exception e){
		     e.printStackTrace();
		}
		
		request.setAttribute("data", data);
		request.setAttribute("dataType", dataType);
		request.setAttribute("title", title);
		request.setAttribute("factor", factor);
		
		RequestDispatcher rd = request.getRequestDispatcher("testGroupCharts.jsp"); 
		//rd.forward(request, response);
	}
}
