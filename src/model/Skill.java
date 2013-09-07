package model;

import javax.persistence.Id;

public class Skill{
	@Id private int id;
	private String skillName;
  
	public Skill(){}
  
	public Skill(int id, String skillName){
		this.id 		= 	id;
		this.skillName 	= 	skillName;
	}
  
	public int getId(){
		return id;
	}
  
	public String getSkillName(){
		return skillName;
	}
  
	
	public void setId(int id){
		this.id = id;
	}
	
	public void setSkillName(String skillName){
		this.skillName = skillName;
	}
	
}
