package model;

import javax.persistence.Id;

public class Team{
	@Id private int id;
	private String teamName;
	private String teamDesc;
	private int teamLimit;
	private int	pmId;
	
	public Team(){}
	
	//constructor
	public Team (int id, String teamName, String teamDesc, int teamLimit, int pmId){
		this.id 		= 	id;
		this.teamName 	= 	teamName;
		this.teamDesc 	= 	teamDesc;
		this.teamLimit	=	teamLimit;
		this.pmId		=	pmId;
	}
	
	//getter
	public int getId(){
		return id;
	}
  
	public String getTeamName(){
		return teamName;
	}
  
	public String getTeamDesc(){
	    return teamDesc;
	}
	
	public int getTeamLimit(){
	    return teamLimit;
	}
	
	public int getPmId(){
		return pmId;
	}
	
	//setter
	public void setId(int id){
		this.id = id;
	}
  
	public void setTeamName(String teamName){
		this.teamName = teamName;
	}
  
	public void setTeamDesc(String teamDesc){
	    this.teamDesc = teamDesc;
	}
	
	public void setTeamLimit(int teamLimit){
	    this.teamLimit = teamLimit;
	}
	
	public void setPmId(int id){
		this.pmId = id;
	}
}
