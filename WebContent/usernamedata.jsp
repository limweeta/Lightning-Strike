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
		
		i++;
	}
	
	for(int j = 0; j < str.length; j++){
		System.out.print(str[j] + "\n");
	}
	

%>