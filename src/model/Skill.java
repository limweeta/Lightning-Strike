package model;

import javax.persistence.Id;

public class Skill{
	@Id private int id;
	private String skillName;
	private String skillDesc;
  
	public Skill(){}
  
	public Skill(int id, String skillName, String skillDesc){
		this.id 		= 	id;
		this.skillName 	= 	skillName;
		this.skillDesc 	= 	skillDesc;
	}
  
	public int getId(){
		return id;
	}
  
	public String getSkillName(){
		return skillName;
	}
  
	public String getDescription(){
		return skillDesc;
	}
	
	public void setId(int id){
		this.id = id;
	}
	
	public void setSkillName(String skillName){
		this.skillName = skillName;
	}
	
	public void setSkillDesc(String skillDesc){
		this.skillDesc = skillDesc;
	}
}
