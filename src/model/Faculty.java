package model;

public class Faculty extends User{
	private String type;
  
	public Faculty(){}
	
	//constructor
	public Faculty(int id, String username, String fullName, String contactNum, String email, String type){
		super(id, username, fullName, contactNum, email, type);
		this.type = type;
	}
	
	//getter
	public String getType(){
		return type;
	}
	
	//setter
	public void setType(String type){
		this.type = type;
	}
}
