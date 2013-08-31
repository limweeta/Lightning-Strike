package com.is480matching.model;

public class Student extends User{
  
  @Id private Long id;
  private String secondMajor;
  
  public Student(){}
  
  public Student(Long id, String fullName, String userName, String contact, String gender, String email, String role, String secondMajor){
    super(id, fullname, userName, contact, gender, email, role);
    this.secondMajor = secondMajor;
  }
  
  public Student(String fullName, String userName, String contact, String gender, String email, String role, String secondMajor){
    super(fullname, userName, contact, gender, email, role);
    this.secondMajor = secondMajor;
  }
  
  public String getSecondMajor(){
    return secondMajor;
  }
  
  public void setSecondMajor(String secondMajor){
    this.secondMajor = secondMajor;
  }
} 
