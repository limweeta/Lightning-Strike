package model;

import javax.persistence.Id;

public class Company{
	@Id private int id;
	private String coyName;
	private String coyAdd;
	private int coyContactNum;
  
	public Company(){}
	
	//constructor
	public Company(int id, String coyName, String coyAdd, int coyContactNum){
		this.id				=	id;
		this.coyName		=	coyName;
		this.coyAdd			=	coyAdd;
		this.coyContactNum	=	coyContactNum;
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
}