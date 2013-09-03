package model;

public class Sponsor extends User{
	private String coyName;
	private String password;
	
	public Sponsor() {}
	
	//constructor
	public Sponsor (int id, String username, String fullName, String contactNum, String email, String type, String coyName,String password){
		super(id, username, fullName, contactNum, email, type);
		this.coyName	=	coyName;
		this.password	=	password;
	}
	
	//getter
	public String getCoyName(){
		return coyName;
	}
	
	public String getPassword(){
		return password;
	}
	
	//setter
	public void setCoyName(String coyName){
		this.coyName = coyName;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
}
	
	
