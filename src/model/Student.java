package model;

public class Student extends User{
	private String secondMajor;
	private int role;
	private int teamId;
	private int preferredRole;
  
	public Student(){}
	
	//constructor
	public Student(int id, String username, String fullName, String contactNum, String email, String type, String secondMajor,int role, int teamId, int preferredRole){
		super(id, username, fullName, contactNum, email, type);
		this.secondMajor 	= 	secondMajor;
		this.role 			= 	role;
		this.teamId			=	teamId;
		this.preferredRole 	= preferredRole;
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
	
	public int getRole(){
		return role;
	}
	
	public int getTeamId(){
		return teamId;
	}
	
	public int getPreferredRole(){
		return preferredRole;
	}

	//setter
	public void setSecondMajor(String secondMajor){
		this.secondMajor = secondMajor;
	}
	
	public void setRole(int role){
		this.role = role;
	}
	
	public void setPreferredRole(int preferredRole){
		this.preferredRole = preferredRole;
	}
	
	public void setTeamId(int id){
		this.teamId = id;
	}
} 
