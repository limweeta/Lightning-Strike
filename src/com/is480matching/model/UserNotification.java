package com.is480matching.model;

import javax.persistence.Id;

public class UserNotification{
  @Id private Long id;
  private Long notificationId;
  private String userName;
  
  public UserNotification(){}
  
  public UserNotification(Long id, Long notificationId, String userName){
    this(notificationId, userName);
    this.id = id;
  }
  
  public UserNotification(Long notificationId, String userName){
    this.notificationId = notificationId;
    this.userName = userName;
  }
  
  public Long getId(){
    return id;
  }
  
  public Long getNotificationId(){
    return notificationId; 
  }
  
  public void setNotificationId(Long notificationId){
    this.notificationId = notificationId;
  }
  
  public String getUserName(){
    return userName;
  }
  
  public void setUserName(String userName){
    this.userName = userName;
  }
}
