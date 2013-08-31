package com.is480matching.model;

public class Project{
  @Id private Long id;
  private Long termId;
  private String name;
  private String description;
  private String status;
  private String industry;
  private String organization;
  private String teamName;
  
  public Project(){}
  
  public Project(Long id, Long teamId, String name, String description, String status, String industry, String organization, String teamName){
    this(termId, name, description, status, industry, organization, teamName);
    this.id = id;
  }
  
  public Project(Long termId, String name, String description, String status, String industry, String organization, String teamName){
    this.termId = termId;
    this.name = name;
    this.description = description;
    this.status = status;
    this.industry = industry;
    this.organization = organization;
    this.teamName = teamName;
  }
  
  public Long getId(){
    return id;
  }
  
  public Long getTermId(){
    return termId;
  }
  
  public Long setTermId(Long termId){
    this.termId = termId;
  }
  
  public String getName(){
    return name;
  }
  
  public void setName(String name){
    this.name = name;
  }
  
  public String getDescription(){
    return description;
  }
  
  public void setDescription(String description){
    this.description = description;
  }
  
  public String getStatus(){
    return status;
  }
  
  public void setStatus(String status){
    this.status = status;
  }
  
  public String getIndustry(){
    return industry;
  }
  
  public void setIndustry(String industry){
    this.industry = industry;
  }
  
  public String getOrganization(){
    return organization;
  }
  
  public void setOrganization(String organization){
    this.organization = organization;
  }
  
  public String getTeamName(){
    return teamName;
  }
  
  public void setTeamName(String teamName){
    this.teamName = teamName;
  }
}
