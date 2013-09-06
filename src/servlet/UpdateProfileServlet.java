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
		String fullName = request.getParameter("fullName");
		String contactNum = request.getParameter("contactNum");
		String email = request.getParameter("email");
		String type = request.getParameter("type");
		String secondMajor = request.getParameter("secondMajor");
		String role = "";
		int teamID = 0;

		StudentDataManager sdm = new StudentDataManager();
		FacultyDataManager fdm = new FacultyDataManager();
		if (type.equals("Student")) {
			Student student = new Student(id, username, fullName, contactNum,
					email, type, secondMajor, role, teamID);
			sdm.add(student);
		} else {
			String facultyType = "Staff";
			Faculty faculty = new Faculty(id, username, fullName, contactNum,
					email, type, facultyType);
			fdm.add(faculty);
		}
		response.sendRedirect("userProfile.jsp?id="+id);
	}
}