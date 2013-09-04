package model;

public class Faculty extends User {
	private String facultyType;

	public Faculty() {
	}

	// constructor
	public Faculty(int id, String username, String fullName, String contactNum,
			String email, String type, String facultyType) {
		super(id, username, fullName, contactNum, email, type);
		this.facultyType = facultyType;
	} // getter 
	
	public String getFacultyType(){ 
		return facultyType; 
	} 
	//setter
	public void setFacultyType(String facultyType){ 
		this.facultyType =facultyType; 
		} 
}
