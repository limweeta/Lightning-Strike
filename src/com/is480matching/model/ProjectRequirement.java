package com.is480matching.model;

public class ProjectRequirement{
  @Id private Long id;
  private Long projectId;
  private Long requirementId;
  
  public ProjectRequirement(){}
  
  public ProjectRequirement(Long id, Long projectId, Long requirementId){
    this(projectId, requirementId);
    this.id = id;
  }
  
  public ProjectRequirement(Long projectId, Long requirementId){
    this.projectId = projectId;
    this.requirementId = requirementId;
  }
  
  public Long getId(){
    return id;
  }
  
  public Long getProjectId(){
    return projectId;
  }
  
  public void setProjectId(Long projectId){
    this.projectId = projectId;
  }
  
  public Long getRequirementId(){
    return requirementId;
  }
  
  public void setRequirementId(Long requirementId){
    this.requirementId = requirementId;
  }
}
