package model;

public class Sponsor extends User{
	private int coyId;
	private String password;
	private int userid;
	
	public Sponsor() {}
	
	//constructor
	public Sponsor (int id, String username, String fullName, String contactNum, String email, String type, int coyId, String password, int userid){
		super(id, username, fullName, contactNum, email, type);
		this.coyId	=	coyId;
		this.password	=	password;
		this.userid = userid;
	}
	
	//getter
	public int getCoyId(){
		return coyId;
	}
	
	public String getPassword(){
		return password;
	}
	
	public int getUserid(){
		return userid;
	}
	
	//setter
	public void setCoyName(int coyId){
		this.coyId = coyId;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public void setUserId(String userid){
		this.password = userid;
	}
}
	
	
