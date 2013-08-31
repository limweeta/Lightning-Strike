package com.is480matching.model;

public class Role{
  
  @Id private Long id;
  private String type;
  
  public Role(){}
  
  public Role(Long id, String type){
    this(type);
    this.id = id;
  }
  
  public Role(String type){
    this.type = type;
  }
  
  public String getType(){
    return type;
  }
  
  public void setType(String type){
    this.type = type;
  }
  
}
