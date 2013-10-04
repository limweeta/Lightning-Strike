package model;

public class Role {
	private String roleName;
	private int id;
	
	public Role(){}
	
	public Role(int id, String roleName){
		this.id = id;
		this.roleName = roleName;
	}
	
	public String getRoleName(){
		return roleName;
	}
	
	public int getId(){
		return id;
	}

	public void setRoleName(String roleName){
		this.roleName = roleName;
	}
	
	public void setId(int id){
		this.id = id;
	}
}
