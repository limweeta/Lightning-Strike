package com.is480matching.model;

import java.io.*;

public class Sponsor implements Serializable {
	private static final long serialVersionUID = 1L;
	private String username;
	private String password;
	private String roleName;
	private String sponsorCompany;
	private String sponsorAddress;
	
	public Sponsor() {}
	
	public Sponsor(String username, String password, String roleName, String sponsorCompany, String sponsorAddress){
		this.username = username;
		this.password = password;
		this.roleName = roleName;
		this.sponsorCompany = sponsorCompany;
		this.sponsorAddress = sponsorAddress;
	}
	
	public String getUsername(){
		return username;
	}
	
	public void setUsername(String username){
		this.username = username;
	}
	
	public String getPassword(){
		return password;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public String getRoleName(){
		return roleName;
	}
	
	public void setRoleName(String roleName){
		this.roleName = roleName;
	}
	
	public String getSponsorCompany(){
		return sponsorCompany;
	}
	
	public void setSponsorCompany(String sponsorCompany){
		this.sponsorCompany = sponsorCompany;
	}
	
	public String getSponsorAddress(){
		return sponsorAddress;
	}
	
	public void setSponsorAddress(String sponsorAddress){
		this.sponsorAddress = sponsorAddress;
	}
}
