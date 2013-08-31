package com.is480matching.model;

public class Requirement{
  @Id private Long id;
  private String description;
  
  public Requirement(){}
  
  public Requirement(Long id, String description){
    this(description);
    this.id = id;
  }
  
  public Requirement(String description){
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
