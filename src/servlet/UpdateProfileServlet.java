package servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import model.Project;
import model.Sponsor;

import model.*;
import manager.*;

@SuppressWarnings("serial")
public class UpdateProfileServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processAuthenticateRequest(request, response);
	}

	public void processAuthenticateRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		UserDataManager udm = new UserDataManager();
		ArrayList<User> users = udm.retrieveAll();
		int id = 0;
		
		for(int i=0; i < users.size(); i++){
			User u = users.get(i);
			if(id < u.getID()){
				id = u.getID();
			}
		}
		
		id++;
		
		String username = request.getParameter("username");
		String fullName = request.getParameter("fullname");
		String contactNum = request.getParameter("contactno");
		String email = request.getParameter("email");
		String type = "Student"; //to be changed later
		String secondMajor = request.getParameter("secondMajor");
		int preferredRole = Integer.parseInt(request.getParameter("prefRole"));
		int role = 0;
		int teamID = 0;
		
		String[] skills = request.getParameterValues("skills");
		
		
		if(contactNum.length() != 8){
			session.setAttribute("message", "Please enter a valid phone number");
			response.sendRedirect("details.jsp");
		}else{
			StudentDataManager sdm = new StudentDataManager();
			FacultyDataManager fdm = new FacultyDataManager();
			if (type.equals("Student")) {
				Student student = new Student(id, username, fullName, contactNum,email, type, secondMajor, role, teamID, preferredRole);
				sdm.add(student);
	
				udm.addSkills(skills, id);
				
			} else {
				String facultyType = "Supervisor";
				Faculty faculty = new Faculty(id, username, fullName, contactNum,
						email, type, facultyType);
				fdm.add(faculty);
			}
			session.setAttribute("message", "Profile Updated");
			response.sendRedirect("userProfile.jsp?id="+id);
		}
	}
}