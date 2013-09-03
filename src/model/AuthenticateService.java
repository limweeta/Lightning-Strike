package model;

import manager.*;

public class AuthenticateService {

	private SponsorDataManager sponsorDM;

	public AuthenticateService(){
		sponsorDM = new SponsorDataManager();
	}
	
	public Sponsor authenticateSponsor(String username, String password) throws Exception{
		Sponsor tempSponsor = sponsorDM.retrieve(username);  
		if(tempSponsor!= null){
			String sponsorPwd = tempSponsor.getPassword();
			if(!sponsorPwd.equals(password)){
				tempSponsor = null;
			}
		}
		return tempSponsor;
	}
}
