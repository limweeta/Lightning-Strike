<%@page import="java.util.*"%>
<%@page import="manager.*"%>
<%@page import="model.*"%>

<%
	StudentDataManager sdm = new StudentDataManager();
	ArrayList<Student> students = sdm.retrieveAll();
	
	Iterator<Student> iter = students.iterator();
	while(iter.hasNext()){
		Student student = (Student) iter.next();
		String studentUser = student.getUsername();
		out.println(studentUser);		
	}

%>