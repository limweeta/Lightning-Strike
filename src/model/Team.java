package model;

import javax.persistence.Id;

public class Team{
	@Id private int id;
	private String teamName;
	private int teamLimit;
	private int	pmId;
	private int supId;
	private int termId;
	private int reviewer1_id;
	private int reviewer2_id;
	
	public Team(){}
	
	//constructor
	public Team (int id, String teamName, int teamLimit, int pmId, int supId, int reviewer1_id, int reviewer2_id, int termId){
		this.id 				= 	id;
		this.teamName 			= 	teamName;
		this.teamLimit			=	teamLimit;
		this.pmId				=	pmId;
		this.supId 				= 	supId;
		this.termId 			= 	termId;
		this.reviewer1_id 		= 	reviewer1_id;
		this.reviewer2_id 		= 	reviewer2_id;
	}
	
	//getter
	public int getId(){
		return id;
	}
  
	public String getTeamName(){
		return teamName;
	}
  
	
	public int getTeamLimit(){
	    return teamLimit;
	}
	
	public int getPmId(){
		return pmId;
	}
	
	public int getSupId(){
		return supId;
	}
	
	public int getTermId(){
		return termId;
	}
	
	public int getRev1Id(){
		return reviewer1_id;
	}
	
	public int getRev2Id(){
		return reviewer2_id;
	}
	
	//setter
	public void setId(int id){
		this.id = id;
	}
  
	public void setTeamName(String teamName){
		this.teamName = teamName;
	}
  
	
	public void setTeamLimit(int teamLimit){
	    this.teamLimit = teamLimit;
	}
	
	public void setPmId(int id){
		this.pmId = id;
	}
	
	public void setSupId(int supId){
		this.supId 	= 	supId;
	}
	
	public void setTermId(int termId){
		this.termId 	= 	termId;
	}
	
	public void setRev1Id(int reviewer1_id){
		this.reviewer1_id 	= 	reviewer1_id;
	}
	
	public void setRev2Id(int reviewer2_id){
		this.reviewer2_id 	= 	reviewer2_id;
	}
	
}
