package model;

import javax.persistence.Id;

public class Project{
	@Id private int id;
	private String termId;
	private int coyId;
	private int teamId;
	private int sponsorId;
	private int supervisorId;
	private int reviewer1Id;
	private int reviewer2Id;
	private String projName;
	private String projDesc;
	private String status;
	private String industry;
  
	public Project(){}
	
	//constructor
	public Project(int id, String termId, int coyId, int teamId, int sponsorId, int supervisorId, int reviewer1Id, int reviewer2Id, String projName, String projDesc, String status, String industry){
		this.id				=	id;
		this.termId 		=	termId;
		this.coyId 			= 	coyId;
		this.teamId			= 	teamId;
		this.sponsorId 		=	sponsorId;
		this.supervisorId	=	supervisorId;
		this.reviewer1Id	=	reviewer1Id;
		this.reviewer2Id	=	reviewer2Id;
		this.projName		=	projName;
		this.projDesc 		= 	projDesc;
		this.status			=	status;
		this.industry		=	industry;
	}
  
	public int getId(){
		return id;
	}
  
	public String getTermId(){
		return termId;
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
  
	public int getSupervisorId(){
		return supervisorId;
	}
	
	public int getReviewer1Id(){
		return reviewer1Id;
	}
	
	public int getReviewer2Id(){
		return reviewer2Id;
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
	
	public String getIndustry(){
		return industry;
	}
	
	//setter
	public void setId(int id){
		this.id = id;
	}
	  
	public void setTermId(String termId){
		this.termId = termId;
	}
  
	public void setSponsorId(int sponsorId){
		this.sponsorId = sponsorId;
	}
  
	public void setSupervisorId(int supervisorId){
		this.supervisorId = supervisorId;
	}
  
	public void setReviewer1Id(int id){
		this.reviewer1Id = id;
	}
	
	public void setReviewer2Id(int id){
		this.reviewer2Id = id;
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
  
	public void setIndustry(String industry){
		this.industry = industry;
	}
}
