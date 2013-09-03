package model;

import javax.persistence.Id;

public class User{
	@Id private int id;
	private String username;
	private String fullName;
	private String contactNum;
	private String email;
	private String type;
  
	public User(){}
  
	public User(int id, String username, String fullName, String contactNum, String email, String type){
		this.id			=	id;
		this.username	=	username;
		this.fullName	=	fullName;
		this.contactNum	=	contactNum;
		this.email		=	email;
		this.type		= 	type;
	  }
  
	public int getID(){
		  return id;
	}
	
	public String getUsername(){
		return username;
	}
	
	public String getFullName(){
		return fullName;
	}
	
	public String getContactNum(){
		return contactNum;
	}
	
	public String getEmail(){
		return email;
	}
	
	public String getType(){
		return type;
	}
	
	public void setID(int ID){
		this.id	= ID;
	}
	
	public void setUsername(String username){
		this.username = username;
	}
	
	public void setFullName(String fullName){
		this.fullName = fullName;
	}
	
	public void setContactNum(String contactNum){
		this.contactNum = contactNum;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public void setType(String type){
		this.type = type;
	}
}