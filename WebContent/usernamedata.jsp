<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="manager.*"%>
<%@page import="model.*"%>

<%
	StudentDataManager sdm = new StudentDataManager();
	ArrayList<Student> students = sdm.retrieveAll();
	
	String[] str = new String[students.size()];
	
	Iterator<Student> iter = students.iterator();
	
	int i = 0;
	while(iter.hasNext()){
		Student student = (Student) iter.next();
		String studentUser = student.getUsername();
		str[i] = studentUser;
		out.print(studentUser + "\n");
		i++;
	}
	/*
	 String query = (String)request.getParameter("q");
	 
     int cnt=1;
     for(int j=0;j<str.length;j++)
     {
         if(str[j].toUpperCase().startsWith(query.toUpperCase()))
         {
            out.print(str[j]+"\n");
            if(cnt>=5)// 5=How many results have to show while we are typing(auto suggestions)
            break;
            cnt++;
          }
     }
	
	*/

%>