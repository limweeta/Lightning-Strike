package model;

import javax.persistence.Id;

public class Company{
	@Id private int id;
	private String coyName;
	private String coyAdd;
	private int coyContactNum;
	private int orgType;
  
	public Company(){}
	
	//constructor
	public Company(int id, String coyName, String coyAdd, int coyContactNum, int orgType){
		this.id				=	id;
		this.coyName		=	coyName;
		this.coyAdd			=	coyAdd;
		this.coyContactNum	=	coyContactNum;
		this.orgType		=	orgType;
	  }
	
	//getter
	public int getID(){
		  return id;
	}
	
	public String getCoyName(){
		return coyName;
	}
	
	public String getCoyAdd(){
		return coyAdd;
	}
	
	public int getCoyContactNum(){
		return coyContactNum;
	}
	
	public int getOrgType(){
		return orgType;
	}
	
	//setter
	public void setID(int ID){
		this.id	= ID;
	}
	
	public void setCoyName(String coyName){
		this.coyName = coyName;
	}
	
	public void setCoyAdd(String coyAdd){
		this.coyAdd = coyAdd;
	}
	
	public void setCoyContactNum(int coyContactNum){
		this.coyContactNum = coyContactNum;
	}
	
	public void setOrgType(int orgType){
		this.orgType = orgType;
	}
}