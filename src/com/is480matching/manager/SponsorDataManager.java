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
			String username = array.get(0);
			String password = array.get(1);
			String roleName = array.get(2);
			String sponsorCompany = array.get(3);
			String sponsorAddress = array.get(4);
			
			Sponsor sponsor = new Sponsor(username, password, roleName, sponsorCompany, sponsorAddress);
			sponsors.add(sponsor);
		}
		
		return sponsors;
	}
	
	public Sponsor retrieve(String username) throws Exception{
		Sponsor sponsor = null;
		System.out.println("testing1");
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select", "select * from sponsor where user_username = '" + username + "';");
		System.out.println("testing2");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		
		while (iterator.hasNext()){
			String key = iterator.next();
			ArrayList<String> array = map.get(key);	
			String retrieveUsername = array.get(0);
			String password = array.get(1);
			String roleName = array.get(2);
			String sponsorCompany = array.get(3);
			String sponsorAddress = array.get(4);
			
		sponsor = new Sponsor(retrieveUsername, password, roleName, sponsorCompany, sponsorAddress);
		}
		return sponsor;
	}
	
	public void add(Sponsor sponsor){
		
		String username = sponsor.getUsername();
		String password = sponsor.getPassword();
		String roleName = sponsor.getRoleName();
		String sponsorCompany = sponsor.getSponsorCompany();
		String sponsorAddress = sponsor.getSponsorAddress();
		MySQLConnector.executeMySQL("insert", "INSERT INTO `is480-matching`.`sponsors` (`user_username`, `user_password`, `role_name, `sponsor_company`, `sponsor_address`) VALUES ('" + username + "', '" + password + "', '" + roleName + "', '" + sponsorCompany + "', '" + sponsorAddress + "');");
		System.out.println("sponsor added successfully");
	}
		
	public void modify(Sponsor sponsor){
		
	}
	
	public void remove(int ID){
		
	}
	
	public void removeAll() {
		
	}
}
