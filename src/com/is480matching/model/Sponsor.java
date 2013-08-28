package com.is480matching.model;

import java.io.*;

public class Sponsor implements Serializable {
	private static final long serialVersionUID = 1L;
	private String ID;
	private String name;
	private String username;
	private String contact;
	private String email;
	private String password;
	
	public Sponsor() {}
	
	public Sponsor(String ID, String name, String username, String contact, String email, String password){
		this.ID = ID; 
		this.name = name;
		this.username = username; 
		this.contact = contact;
		this.email = email; 
		this.password = password;
	}
	
	public String getID(){
		return ID; 
	}
	
	public String getName(){
		return name;
	}
	
	public String getUsername(){
		return username;
	}
	
	public String getContact(){
		return contact;
	}
	
	public String getEmail(){
		return email;
	}
	
	public String getPassword(){
		return password;
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public void setUsername(String username){
		this.username = username;
	}
	
	public void setContact(String contact){
		this.contact = contact;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
}
