package model;

public class Industry {
	private int industryId;
	private String industryName;
	
	public Industry(int industryId, String industryName){
		this.industryId = industryId;
		this.industryName = industryName;
	}
	
	//getter
	
	public int getIndustryId(){
		return industryId;
	}
	
	public String getIndustryName(){
		return industryName;
	}
	
	//setter
	
	public void setId(int industryId){
		this.industryId = industryId;
	}
	
	public void setIndustryName(String industryName){
		this.industryName = industryName;
	}
	
}
