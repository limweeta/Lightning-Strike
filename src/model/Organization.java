package model;

import javax.persistence.Id;

public class Organization{
	@Id private int id;
	private String orgType;
  
	public Organization(){}
  
	public Organization(int id, String orgType){
		this.id 		= 	id;
		this.orgType 	= 	orgType;
	}
  
	public int getId(){
		return id;
	}
  
	public String getOrgType(){
		return orgType;
	}
  

	public void setId(int id){
		this.id = id;
	}
	
	public void setOrgType(String orgType){
		this.orgType = orgType;
	}

}
