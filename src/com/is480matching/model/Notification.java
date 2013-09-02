package com.is480matching.model;

import javax.persistence.Id;

public class Notification{
  @Id private Long id;
  private String description;
  private String timestamp;
  private boolean read;
  
  public Notification(){}
  
  public Notification(Long id, String description, String timestamp, boolean read){
    this(description, timestamp, read);
    this.id = id;
  }
  
  public Notification(String description, String timestamp, boolean read){
    this.description = description;
    this.timestamp = timestamp;
    this.read = read;
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
  
  public String getTimestamp(){
    return timestamp;
  }
  
  public void setTimestamp(String timestamp){
    this.timestamp = timestamp;
  }
  
  public boolean getRead(){
    return read;
  }
  
  public void setRead(boolean read){
    this.read = read;
  }
}
