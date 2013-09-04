package model;

public class Student extends User{
	private String secondMajor;
	private String role;
	private int teamId;
	
  
	public Student(){}
	
	//constructor
	public Student(int id, String username, String fullName, String contactNum, String email, String type, String secondMajor,String role, int teamId){
		super(id, username, fullName, contactNum, email, type);
		this.secondMajor 	= 	secondMajor;
		this.role 			= 	role;
		this.teamId			=	teamId;
  	}
	//constructor without team and role
	public Student(int id, String username, String fullName, String contactNum, String email, String type, String secondMajor){
		super(id, username, fullName, contactNum, email, type);
		this.secondMajor = secondMajor;
  	}
	
	//getter
	public String getSecondMajor(){
		return secondMajor;
	}
	
	public String getRole(){
		return role;
	}
	
	public int getTeamId(){
		return teamId;
	}

	//setter
	public void setSecondMajor(String secondMajor){
		this.secondMajor = secondMajor;
	}
	
	public void setRole(String role){
		this.role = role;
	}
	
	public void setTeamId(int id){
		this.teamId = id;
	}
} 