package com.is480matching.model;

import javax.persistence.Id;

public class Team{ 
  private String name;
  private String pmName;
  private String teamLimit;
  
  public Team(){}
  
  public Team (String name, String pmName, String teamLimit){
    this.name 		= 	name;
    this.pmName 	= 	pmName;
    this.teamLimit 	= 	teamLimit;
  }
  
  public String getName(){
    return name;
  }
  
  private String getPMName(){
    return pmName;
  }
  
  private String getTeamLimit(){
	    return teamLimit;
	  }
  
  private void setName(String name){
    this.name = name;
  }
  
  private void setPMName(String pmName){
    this.pmName = pmName;
  }
  
  private void setTeamLimit(String teamLimit){
	    this.teamLimit = teamLimit;
	  }
}
