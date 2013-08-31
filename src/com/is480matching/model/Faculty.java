package com.is480matching.model;

public class Faculty extends User{
  private String type;
  
  public Faculty(){}
  
  public Faculty(Long id, String fullName, String userName, String contact, String gender, String email, String role, String type){
    super(id, fullName, userName, contact, gender, email, role);
    this.type = type;
  }
  
  public Faculty(String fullName, String userName, String contact, String gender, String email, String role, String type){
    super(fullName, userName, contact, gender, email, role);
    this.type = type;
  }
  
  public String getType(){
    return type;
  }
  
  public void setType(String type){
    this.type = type;
  }
}
