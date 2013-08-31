package com.is480matching.model;

public class Team{ 
  @Id private Long id;
  private String name;
  private String contactName;
  
  public Team(){}
  
  public Team(Long id, String name, String contactName){
    this(name, contactName);
    this.id = id;
  }
  
  public Team (String name, String contactName){
    this.name = name;
    this.contactName = contactName;
  }
  
  public Long getId(){
    return id;
  }
  
  private String getName(){
    return name;
  }
  
  private void setName(String name){
    this.name = name;
  }
  
  private String getContactName(){
    return contactName;
  }
  
  private void setContactName(String contactName){
    this.contactName = contactName;
  }
}
