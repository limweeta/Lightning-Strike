package com.is480matching.model;

public class StudentSkill{
  @Id private Long id;
  private Long skillId;
  private String userName;
  
  public StudentSkill(){}
  
  public StudentSkill(Long id, Long skillId, String userName){
    this(skillId, userName);
    this.id = id;
  }
  
  public StudentSkill(Long skillId, String userName){
    this.skillId = skillId;
    this.userName = userName;
  }
  
  public Long getId(){
    return id;
  }
  
  public Long getSkillId(){
    return skillId;
  }
  
  public void setSkillId(Long skillId){
    this.skillId = skillId;
  }
  
  public String getUserName(){
    return userName;
  }
  
  public void setUserName(String userName){
    this.userName = userName;
  }
}
