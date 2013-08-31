package com.is480matching.model;

public class CourseCoordinator extends User{
  
  public CourseCoordinator(){}
  
  public CourseCoordinator(Long id, String fullName, String userName, String contact, String gender, String email, String role){
     super(id, fullName, userName, contact, gender, email, role);
  }
  
    public CourseCoordinator(String fullName, String userName, String contact, String gender, String email, String role){
      super(fullName, userName, contact, gender, email, role);
  }
}
