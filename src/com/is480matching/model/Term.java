package com.is480matching.model;

public class Term{
  @Id private Long id;
  private String name;
  
  public Term(){}
  
  public Term(Long id, String name){
    this(name);
    this.id = id;
  }
  
  public Term(String name){
    this.name = name;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getName(){
    return name;
  }
  
  public void setName(String name){
    this.name = name;
  }
}
