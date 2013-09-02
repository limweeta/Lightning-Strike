package com.is480matching.model;

import javax.persistence.Id;

public class Skill{
  @Id private Long id;
  private String description;
  
  public Skill(){}
  
  public Skill(Long id, String description){
    this(description);
    this.id = id;
  }
  
  public Skill(String description){
    this.description = description;  
  }
  
  public Long getId(){
    return id;
  }
  
  public String getDescription(){
    return description;
  }
  
  public void setDescription(String description){
    this.description = description;
  }
}
