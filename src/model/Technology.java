package model;

import javax.persistence.Id;

public class Technology{
	@Id private int id;
	private String techName;
  
	public Technology(){}
  
	public Technology(int id, String techName){
		this.id 		= 	id;
		this.techName 	= 	techName;
	}
  
	public int getId(){
		return id;
	}
  
	public String getTechName(){
		return techName;
	}
  

	public void setId(int id){
		this.id = id;
	}
	
	public void setTechName(String techName){
		this.techName = techName;
	}

}
