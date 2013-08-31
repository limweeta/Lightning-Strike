package com.is480matching.manager;

import com.is480matching.model.*;
import java.io.Serializable;
import java.sql.*;
import java.util.*;

import com.is480matching.model.MySQLConnector;
import com.is480matching.model.Sponsor;

public class SponsorDataManager implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public SponsorDataManager() {}
	
	public ArrayList<Sponsor> retrieveAll() {
		ArrayList<Sponsor> sponsors = new ArrayList<Sponsor>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from sponsors");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String id = array.get(0);
			String name = array.get(1);
			String username = array.get(2);
			String contact = array.get(3);
			String email = array.get(4);
			String password = array.get(5);
			
			Sponsor sponsor = new Sponsor(id,name,username,contact,email,password);
			sponsors.add(sponsor);
		}
		
		return sponsors;
	}
	
	public Sponsor retrieve(String username) throws Exception{
		Sponsor sponsor = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from sponsors where username = '" + username + "';");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String id = array.get(0);
			String name = array.get(1);
			username = array.get(2);
			String contact = array.get(3);
			String email = array.get(4);
			String password = array.get(5);
			
			sponsor = new Sponsor(id,name,username,contact,email,password);
		}
		return sponsor;
	}
	
	public void add(Sponsor sponsor){
		String ID = sponsor.getID();
		String name = sponsor.getName();
		String username = sponsor.getUsername();
		String contact = sponsor.getContact();
		String email = sponsor.getEmail();
		String password = sponsor.getPassword();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`sponsors` (`ID`, `name`, `username`, `contact`, `email`, `password`) VALUES ('" + ID + "', '" + name + "', '" + username + "', '" + contact + "', '" + email + "', '" + password +"');");
		System.out.println("sponsor added successfully");
	}
		
	public void modify(Sponsor sponsor){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
