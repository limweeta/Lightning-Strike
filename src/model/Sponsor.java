package model;

public class Sponsor extends User{
	private String coyName;
	private String password;
	private int userid;
	
	public Sponsor() {}
	
	//constructor
	public Sponsor (int id, String username, String fullName, String contactNum, String email, String type, String coyName, String password, int userid){
		super(id, username, fullName, contactNum, email, type);
		this.coyName	=	coyName;
		this.password	=	password;
		this.userid = userid;
	}
	
	//getter
	public String getCoyName(){
		return coyName;
	}
	
	public String getPassword(){
		return password;
	}
	
	public int getUserid(){
		return userid;
	}
	
	//setter
	public void setCoyName(String coyName){
		this.coyName = coyName;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public void setUserId(String userid){
		this.password = userid;
	}
}
	
	
