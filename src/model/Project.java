package model;

import javax.persistence.Id;

public class Project{
	@Id private int id;
	private int coyId;
	private int teamId;
	private int sponsorId;
	private String projName;
	private String projDesc;
	private String status;
	private int industry;
	private int creator_id;
	private int intendedTermId;
	private String wikiLink;
	
	public Project(){}
	
	//constructor
	public Project(int id, int coyId, int teamId, int sponsorId, String projName, String projDesc, 
			String status, int industry, int creator_id, int intendedTermId){
		this.id				=	id;
		this.coyId 			= 	coyId;
		this.teamId			= 	teamId;
		this.sponsorId 		=	sponsorId;
		this.projName		=	projName;
		this.projDesc 		= 	projDesc;
		this.status			=	status;
		this.industry		=	industry;
		this.creator_id 	= 	creator_id;
		this.intendedTermId	=	intendedTermId;
	}
	
	public Project(int id, int coyId, int teamId, int sponsorId, String projName, String projDesc, 
			String status, int industry, int creator_id, int intendedTermId, String wikiLink){
		this.id				=	id;
		this.coyId 			= 	coyId;
		this.teamId			= 	teamId;
		this.sponsorId 		=	sponsorId;
		this.projName		=	projName;
		this.projDesc 		= 	projDesc;
		this.status			=	status;
		this.industry		=	industry;
		this.creator_id 	= 	creator_id;
		this.intendedTermId	=	intendedTermId;
		this.wikiLink		=	wikiLink;
	}
	
	public int getId(){
		return id;
	}
  
	public int getCreatorId(){
		return creator_id;
	}
	
	public int getCoyId(){
		return coyId;
	}
  
	public int getTeamId(){
		return teamId;
	}
  
	public int getSponsorId(){
		return sponsorId;
	}

  
	public String getProjName(){
		return projName;
	}
  
	public String getProjDesc(){
		return projDesc;
	}
	
	public String getStatus(){
		return status;
	}
	
	public int getIndustry(){
		return industry;
	}
	
	public int getIntendedTermId(){
		return intendedTermId;
	}
	
	public String getWikiLink(){
		return wikiLink;
	}
	
	//setter
	public void setId(int id){
		this.id = id;
	}
	
	public void setCreatorId(int creator_id){
		this.creator_id = creator_id;
	}
	
	public void setCoyId(int coyId){
		this.coyId = coyId;
	}
	
	public void setTeamId(int teamId){
		this.teamId = teamId;
	}
  
	public void setSponsorId(int sponsorId){
		this.sponsorId = sponsorId;
	}
 
	public void setProjName(String projName){
		this.projName = projName;
	}
  
	public void setProjDesc(String projDesc){
		this.projDesc = projDesc;
	}
	
	public void setStatus(String status){
		this.status = status;
	}
  
	public void setIndustry(int industry){
		this.industry = industry;
	}
	
	public void setIntendedTermId(int intendedTermId){
		this.intendedTermId = intendedTermId;
	}
	
	public void setWikiLink(String wikiLink){
		this.wikiLink = wikiLink;
	}
}
