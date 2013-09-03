package model;

import javax.persistence.Id;

public class Technology{
	@Id private int id;
	private String techName;
	private String techDesc;
  
	public Technology(){}
  
	public Technology(int id, String techName, String techDesc){
		this.id 		= 	id;
		this.techName 	= 	techName;
		this.techDesc 	= 	techDesc;
	}
  
	public int getId(){
		return id;
	}
  
	public String getTechName(){
		return techName;
	}
  
	public String getDescription(){
		return techDesc;
	}
	
	public void setId(int id){
		this.id = id;
	}
	
	public void setTechName(String techName){
		this.techName = techName;
	}
	
	public void setTechDesc(String techDesc){
		this.techDesc = techDesc;
	}
}
